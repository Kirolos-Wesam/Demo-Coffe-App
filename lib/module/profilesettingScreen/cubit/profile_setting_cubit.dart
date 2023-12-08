import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffeeapp/model/usermodel.dart';
import 'package:coffeeapp/shared/componets/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'profile_setting_state.dart';

class ProfileSettingCubit extends Cubit<ProfileSettingState> {
  ProfileSettingCubit() : super(ProfileSettingInitial());

  static ProfileSettingCubit get(context) => BlocProvider.of(context);

  File? profileImage;
  var picker = ImagePicker();
  Future getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(ProfileImagePickedSuccessState());
    } else {
      print('No Image selected.');
      emit(ProfileImagePickedErrorState());
    }
  }

  void uploadProfileImageAndUpdateAccount({
    required String name,
    required String email,
    required String phone,
    required String address,
    required String image,
  }) {
    if (profileImage != null) {
      print('not null');
      FirebaseStorage.instance
          .ref()
          .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
          .putFile(profileImage!)
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          emit(UpdatingProfileImageSuccessState());
          updateUser(
              name: name,
              email: email,
              phone: phone,
              address: address,
              image: value);
        }).catchError((error) {
          emit(UpdatingProfileImageErrorState());
        });
      }).catchError((error) {
        emit(UpdatingProfileImageErrorState());
      });
    }
    if (profileImage == null) {
      updateUser(
          name: name,
          email: email,
          phone: phone,
          address: address,
          image: image);
    }
  }

  updateUser(
      {required String name,
      required String email,
      required String phone,
      required String address,
       String? image}) {
    emit(UpdateUserLoadingState());

    UserModel updateUser = UserModel(name: name, email: email, phone: phone, address: address, image: image);
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uID)
        .update(updateUser.toMap())
        .then((value) {
      emit(UpdateUserSuccessState());
    }).onError((error, stackTrace) {
      emit(UpdateUserErrorState());
    });
  }
}
