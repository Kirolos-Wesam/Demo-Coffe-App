import 'package:coffeeapp/module/LoginScreen/cubit/state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState>{
  LoginCubit() : super(LoginInitalState());

  static LoginCubit get(context) => BlocProvider.of(context);

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ChangePasswordVisibiltyState());
  }

  bool switchButton = false;
  void changeSwitchButton(bool value){
    switchButton = value;
    emit(ChangeSwitchButtonState());
    print(switchButton);
  }

  void signIn({required String email, required String password}){
    emit(LoginLoadingState());

    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) {
      emit(LoginSuccessState(value.user!.uid));
    }).catchError((onError){emit(LoginErrorState());});
  }

}