import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/controllers/register_bloc/register_states.dart';
import 'package:social_app/core/managers/app_strings.dart';
import 'package:social_app/core/managers/images_path.dart';
import 'package:social_app/models/user_model.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);
  bool isPassword = true;
  bool isCheckPassword = true;
  IconData icon = Icons.visibility_outlined;
  IconData confirmIcon = Icons.visibility_outlined;

  //method to register user by firebase Auth
  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      userCreate(
        name: name,
        email: email,
        phone: phone,
        usId: value.user!.uid,
        isEmailVerified: false,
      );
      //emit(SocialRegisterSuccessState());
    }).catchError((error) {
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  //create user (doc) in firebase firestore and save his data, this function called after register.
  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String usId,
    required bool isEmailVerified,
  }) {
    UserModel model = UserModel(
      name: name,
      email: email,
      phone: phone,
      uId: usId,
      isEmailVerified: isEmailVerified,
      image: AppImages.defaultImagePath,
      coverImage: AppImages.defaultCoverImagePath,
      bio: AppStrings.writeYourBio,
      noOfPosts: 0,
      noOfFollowers: 0,
      noOfFollowing: 0,
      noOfFriends: 0,
      //userPosts: null,
    );
    FirebaseFirestore.instance
        .collection(AppStrings.users)
        .doc(usId)
        .set(model.toMap())
        .then((value) {
      emit(SocialCreateUserSuccessState(usId));
    }).catchError((error) {
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

  //change confirm password visibility
  void changeConfirmPasswordVisibility() {
    isCheckPassword = !isCheckPassword;
    confirmIcon = isCheckPassword
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(SocialRegChangePasswordVisibilityState());
  }
}
