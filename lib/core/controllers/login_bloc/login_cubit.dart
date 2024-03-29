import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../screens/widgets/components.dart';
import '../../managers/app_strings.dart';
import '../../network/local/cache_helper.dart';
import 'login_states.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoginInitialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);
  bool isPassword = true;
  IconData icon = Icons.visibility_outlined;

  //method to login user by firebase Auth
  void userLogin({
    required String email,
    required String password,
  }) {
    emit(SocialLoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(value.user?.uid);
      emit(SocialLoginSuccessState(value.user!.uid));
    }).catchError((error) {
      emit(SocialLoginErrorState(error.toString()));
    });
  }

  void changePasswordVisibility() {
    isPassword = !isPassword;
    icon =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialpChangePasswordVisibilityState());
  }

//log out method
  void logOut({required BuildContext context, required Widget widget}) {
    FirebaseAuth.instance.signOut().then((value) {
      CacheHelper.removeData(key: AppStrings.userIdKey).then((value) {
        navigateAndRemove(context: context, widget: widget);
      });
      emit(LogOutSuccessState());
    }).catchError((error) {
      emit(LogOutErrorState());
    });
  }
}
