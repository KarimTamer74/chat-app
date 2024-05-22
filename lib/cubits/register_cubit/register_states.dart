class RegisterState {}

class RegisterInitialState extends RegisterState {}

class RegisterSuccessState extends RegisterState {}

class RegisterFailureState extends RegisterState {
  String errorMassage;
  RegisterFailureState({required this.errorMassage});
}

class RegisterLoadingState extends RegisterState {}