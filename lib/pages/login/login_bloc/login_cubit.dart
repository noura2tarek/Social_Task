import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_states.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoginInitialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);
  bool isPassword = true;
  IconData icon = Icons.visibility_outlined;

  //method to post login data to api by using dio
  void userLogin({
    required String email,
    required String password,
    String lang = 'en',
  }) {
    // emit(SocialLoginLoadingState());
    // DioHelper.postData(
    //   url: LOGIN,
    //   data: {
    //     "email": email,
    //     "password": password,
    //   },
    //   lang: lang,
    // ).then((value) {
    //   loginModel = LoginModel.fromJson(value.data);
    //   emit(SocialLoginSuccessState(loginModel));
    // }).catchError((error) {
    //   print(error.toString());
    //   emit(SocialLoginErrorState(error.toString()));
    // });
  }

  void changePasswordVisibility() {
    isPassword = !isPassword;
    icon =
    isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialpChangePasswordVisibilityState());
  }
}
