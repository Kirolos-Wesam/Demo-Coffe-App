import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'favourtie_screen_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteScreenInitial());
}
