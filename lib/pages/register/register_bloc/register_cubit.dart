import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/pages/register/register_bloc/register_states.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);
  bool isPassword = true;
  IconData icon = Icons.visibility_outlined;

  //method to register user by firebase Auth
  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
    ).then((value) {
      userCreate(
        name: name,
        email: email,
        phone: phone,
        uId: value.user!.uid,
        isEmailVerified: false,
      );
      //emit(SocialRegisterSuccessState());
    }).catchError((error){
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

 //create user (doc) in firebase firestore and save his data, this function called after register.
  void userCreate(
      {
        required String name,
        required String email,
        required String phone,
        required String uId,
        required bool isEmailVerified,
      }){
    UserModel model = UserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      isEmailVerified: isEmailVerified,
      image: 'https://cdn.landesa.org/wp-content/uploads/default-user-image.png',
      coverImage: 'https://img.freepik.com/free-photo/full-shot-woman-running-outdoors_23-2149622958.jpg?t=st=1693073648~exp=1693074248~hmac=c0db97a92eb3f7fbf1f39ed5e020ba5a3ecba60d9f00d8eee5386f173c13080a',
      bio: 'write your bio..',
      noOfPosts: 0,
      noOfFollowers: 0,
      noOfFollowing: 0,
      noOfFriends: 0,
    );
     FirebaseFirestore.instance
         .collection('users')
         .doc(uId)
         .set(model.toMap())
         .then((value) {
          emit(SocialCreateUserSuccessState());
     }).catchError((error){
        emit(SocialCreateUserErrorState(error.toString()));
     });

  }

  //change password visibility
  void changePasswordVisibility() {
    isPassword = !isPassword;
    icon =
    isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialRegChangePasswordVisibilityState());
  }
}
