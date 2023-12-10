import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'faq_state.dart';

class FaqCubit extends Cubit<FaqState> {
  FaqCubit() : super(FaqInitial());

  static FaqCubit get(context) => BlocProvider.of(context);
  

  List<bool> arrowCheck = [false, false, false];
  changeArrow(bool i, int index){
    arrowCheck[index] = i;
    emit(ChangeArrowState());
  }
}
