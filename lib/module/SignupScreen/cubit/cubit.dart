import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffeeapp/model/usermodel.dart';
import 'package:coffeeapp/module/SignupScreen/cubit/state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitalState());

  static SignupCubit get(context) => BlocProvider.of(context);

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ChangePasswordVisibiltyState());
  }

  bool switchButton = false;
  void changeSwitchButton() {
    switchButton = !switchButton;
    emit(ChangeSwitchButtonState());
  }

  void signUp(
      {required String email,
      required String password,
      required String name,
      required String phone,
      required String address}) {
    emit(SignuploadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      createUser(
          name: name,
          uID: value.user!.uid,
          email: email,
          phone: phone,
          address: address);
          emit(SignupSuccessState());
    }).catchError((onError) {
      emit(SignupErrorState());
    });
  }

  void createUser({
    required String name,
    required String uID,
    required String email,
    required String phone,
    required String address,
  }) {
    emit(CreateUserloadingState());
    UserModel user = UserModel(
        name: name,
        email: email,
        uID: uID,
        phone: phone,
        address: address,
        image:
            'https://images.pexels.com/photos/1695052/pexels-photo-1695052.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1');

    FirebaseFirestore.instance
        .collection('Users')
        .doc(uID)
        .set(user.toMap())
        .then((value) {
      emit(CreateUserSuccessState(uID));
    }).catchError((onError) {
      emit(CreateUserErrorState());
    });
  }
}
