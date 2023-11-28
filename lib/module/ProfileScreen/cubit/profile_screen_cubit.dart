import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'profile_screen_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileScreenInitial());
}
