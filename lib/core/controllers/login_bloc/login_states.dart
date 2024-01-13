abstract class SocialLoginStates {}

class SocialLoginInitialState extends SocialLoginStates {}

class SocialLoginLoadingState extends SocialLoginStates {}

class SocialLoginSuccessState extends SocialLoginStates {
  late String uId;

  SocialLoginSuccessState(this.uId);
}

class SocialLoginErrorState extends SocialLoginStates {
  late final String error;

  SocialLoginErrorState(this.error);
}

class LogOutSuccessState extends SocialLoginStates {}

class LogOutErrorState extends SocialLoginStates {}

class SocialpChangePasswordVisibilityState extends SocialLoginStates {}
