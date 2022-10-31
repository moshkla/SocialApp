abstract class SocialRegisterStates {}

class SocialRegisterInitialState extends SocialRegisterStates {}

class SocialRegisterLoadingState extends SocialRegisterStates {}

class SocialRegisterSuccessState extends SocialRegisterStates {

}

class SocialRegisterErrorState extends SocialRegisterStates {
  final String error;

  SocialRegisterErrorState(this.error);
}
//user create
class SocialUserCreateLoadingState extends SocialRegisterStates {}

class SocialUserCreateSuccessState extends SocialRegisterStates {

}

class SocialUserCreateErrorState extends SocialRegisterStates {
  final String error;

  SocialUserCreateErrorState(this.error);
}