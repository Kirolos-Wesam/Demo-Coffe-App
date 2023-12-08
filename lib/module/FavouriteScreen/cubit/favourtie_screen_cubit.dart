import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffeeapp/model/favoriteModel.dart';
import 'package:coffeeapp/shared/componets/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'favourtie_screen_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteScreenInitial());

  static FavoriteCubit get(context) => BlocProvider.of(context);

  List<FavoriteModel>? favorites;
  List<bool> checkedIcon =[];
  getFavorites() {
    emit(GetFavoriteLoadingState());
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uID)
        .collection('favorites')
        .get()
        .then((value) {
      favorites = favoriteModelFromJson(value.docs);
      print(favorites);
      for(int i = 0; i <= favorites!.length ; i++){
        checkedIcon.add(true);
      }
      emit(GetFavoriteSuccessState());
    }).onError((error, stackTrace) {
      emit(GetFavoriteErrorState());
    });
  }


  removeFavorites({required String productId}) {
    emit(RemoveFavoriteLoadingState());

    FirebaseFirestore.instance
        .collection('Users')
        .doc(uID)
        .collection('favorites')
        .doc(productId)
        .delete()
        .then((value) => emit(RemoveFavoriteSuccessState()))
        .onError((error, stackTrace) {
      emit(RemoveFavoriteErrorState());
    });
  }
}
