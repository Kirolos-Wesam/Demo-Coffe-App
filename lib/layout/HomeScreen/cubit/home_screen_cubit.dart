import 'package:bloc/bloc.dart';
import 'package:coffeeapp/module/FavouriteScreen/favourtieScreen.dart';
import 'package:coffeeapp/module/OrderScreen/orderScreen.dart';
import 'package:coffeeapp/module/ProductScreen/productsScreen.dart';
import 'package:coffeeapp/module/ProfileScreen/profileScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'home_screen_state.dart';

class HomeCubit extends Cubit<HomeScreenState> {
  HomeCubit() : super(HomeScreenInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
     ProductScreen(),
     FavoriteScreen(),
     OrderScreen(),
     ProfileScreen()
  ];

  void changeNavBottom(int index){
    currentIndex = index;
    emit(ChangeNavBottomState());
  }

}
