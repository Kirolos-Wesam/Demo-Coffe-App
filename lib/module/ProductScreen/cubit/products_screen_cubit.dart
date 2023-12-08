import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:coffeeapp/model/productmodel.dart';
import 'package:coffeeapp/model/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'products_screen_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsScreenInitial());

  static ProductsCubit get(context) => BlocProvider.of(context);

  List<String> imageUrl = [];
  int currentIndex = 0;

  switchButton(int index){
    currentIndex = index;
    emit(SwitchButtonState());
  }


  getImage(){
    emit(OffersProductsLoadingState());

    FirebaseStorage.instance.ref().child('offers').listAll().then((value) async {
      for (var item in value.items){
        String url = await item.getDownloadURL();

        imageUrl.add(url.toString());
      }
      print(imageUrl);
      emit(OffersProductsSuccessState());
    }).onError((error, stackTrace) {emit(OffersProductsErrorState());});
    
  }

  UserModel? user;
  getUser(){
    emit(GetUserLoadingState());
    FirebaseFirestore.instance.collection('Users').doc('EE8L88FDUlgDZcN8otwMSBFCWWW2').get().then((value) {
      // user = UserModel.fromjson(value.data()!);
      print(value.data()!);
      emit(GetUserSuccessState());
    });
  }

  List<ProductModel> products =[];
  getProducts(){
    emit(GetProductsLoadingState());

    FirebaseFirestore.instance.collection('products').get().then((value) {
      products = ProductModelFromJson(value.docs);
      print(products);
      emit(GetProductsSuccessState());
    }).onError((error, stackTrace) {emit(GetProductsErrorState());});
  }

  
}
