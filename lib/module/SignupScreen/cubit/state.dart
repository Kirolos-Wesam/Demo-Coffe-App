abstract class SignupState {}

class SignupInitalState extends SignupState {}

class ChangePasswordVisibiltyState extends SignupState {}

class ChangeSwitchButtonState extends SignupState {}

class SignuploadingState extends SignupState {}

class SignupSuccessState extends SignupState {}

class SignupErrorState extends SignupState {}

class CreateUserloadingState extends SignupState {}

class CreateUserSuccessState extends SignupState {
  final String uID;

  CreateUserSuccessState(this.uID);
}

class CreateUserErrorState extends SignupState {}
