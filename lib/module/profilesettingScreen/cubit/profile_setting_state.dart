part of 'profile_setting_cubit.dart';

@immutable
abstract class ProfileSettingState {}

class ProfileSettingInitial extends ProfileSettingState {}

class ProfileImagePickedSuccessState extends ProfileSettingState {}

class ProfileImagePickedErrorState extends ProfileSettingState {}

class UpdatingProfileImageSuccessState extends ProfileSettingState {}

class UpdatingProfileImageErrorState extends ProfileSettingState {}

class UpdateUserLoadingState extends ProfileSettingState {}

class UpdateUserSuccessState extends ProfileSettingState {}

class UpdateUserErrorState extends ProfileSettingState {}

