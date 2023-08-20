import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/pages/register/register_bloc/register_states.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);
  bool isPassword = true;
  IconData icon = Icons.visibility_outlined;

  //method to post register data to api by using dio
  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
    String lang = 'en',
  }) {
    emit(SocialRegisterLoadingState());

  }

  void changePasswordVisibility() {
    isPassword = !isPassword;
    icon =
    isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialRegChangePasswordVisibilityState());
  }
}
