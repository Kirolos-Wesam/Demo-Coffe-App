import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'profile_setting_state.dart';

class ProfileSettingCubit extends Cubit<ProfileSettingState> {
  ProfileSettingCubit() : super(ProfileSettingInitial());
}
