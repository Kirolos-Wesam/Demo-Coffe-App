abstract class LoginState {}

class LoginInitalState extends LoginState {}

class ChangePasswordVisibiltyState extends LoginState {}

class ChangeSwitchButtonState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final String uID;

  LoginSuccessState(this.uID);
}

class LoginErrorState extends LoginState {}