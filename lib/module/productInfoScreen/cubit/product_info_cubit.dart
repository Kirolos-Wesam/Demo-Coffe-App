import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffeeapp/model/favoriteModel.dart';
import 'package:coffeeapp/model/idsproductmodel.dart';
import 'package:coffeeapp/model/ordermodel.dart';
import 'package:coffeeapp/shared/componets/constants.dart';
import 'package:coffeeapp/shared/network/local/cachehelper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'product_info_state.dart';

class ProductInfoCubit extends Cubit<ProductInfoState> {
  ProductInfoCubit() : super(ProductInfoInitial());

  static ProductInfoCubit get(context) => BlocProvider.of(context);

  int currentIndex = 1;
  changeButtons(int i){
    currentIndex = i;
    emit(ChangeSizeButtonsState());
  }

  bool? isFavorite;

 void checkFavorite({required String id}){
  print('test');
    FirebaseFirestore.instance.collection('Users').doc(uID).collection('favorites').doc(id).get().then((value) {
      if(value.exists){
        isFavorite = true;
        emit(CheckFavoriteState());
      }
      else{
        isFavorite = false;
        emit(CheckFavoriteState());
      }
    });
  }

  
  addFavorite(bool i, {
    required String productId,
    required String productName,
    required String description,
    required String profileImage,
    required String title,
    required num price,
    required int categoryId, 
  }){
    isFavorite = i;
    
    
    if(i == true){
      emit(AddFavoriteLoadingState());
      FavoriteModel addFavorite = FavoriteModel(productId: productId, productName: productName, description: description, price: price, categoryId: categoryId, profileImage: profileImage, title: title);
      FirebaseFirestore.instance.collection('Users').doc(uID).collection('favorites').doc(productId).set(addFavorite.toMap()).then((favorite) {
        emit(AddFavoriteSuccessState());
      }).onError((error, stackTrace) {emit(AddFavoriteErrorState());});
    }else{
      FirebaseFirestore.instance.collection('Users').doc(uID).collection('favorites').doc(productId).delete().then((value) => emit(DeleteFavoriteSuccessState()));
    }
  }
  
  addOrder({
    required String productId,
  }){
    emit(AddOrderLoadingState());


    CartModel addCart = CartModel(productId: productId);
    FirebaseFirestore.instance.collection('Users').doc(uID).collection('carts').add(addCart.toMap()).then((value) {
      CartModel addCart = CartModel(productId: productId, id: value.id);
      FirebaseFirestore.instance.collection('Users').doc(uID).collection('carts').doc(value.id).update(addCart.toMap()).then((value) => emit(AddOrderSuccessState()));
    }).onError((error, stackTrace) {emit(AddOrderErrorState());});
  
}
}