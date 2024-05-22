class UserLoginState {}
class LoginInitialState extends UserLoginState{}

class LoginLoadingState extends UserLoginState{}

class LoginSuccessState extends UserLoginState{}

class LoginFailureState extends UserLoginState{
  String? errorMassage;

  LoginFailureState({this.errorMassage});
}