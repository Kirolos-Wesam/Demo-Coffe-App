import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffeeapp/model/checkoutmodel.dart';
import 'package:coffeeapp/model/idsproductmodel.dart';
import 'package:coffeeapp/model/ordermodel.dart';
import 'package:coffeeapp/shared/componets/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'order_history_state.dart';

class OrderHistoryCubit extends Cubit<OrderHistoryState> {
  OrderHistoryCubit() : super(OrderHistoryInitial());

  static OrderHistoryCubit get(context) => BlocProvider.of(context);


  List<CheckOutModel>? checkOuts;
  getOrdersHistory(){
    emit(GetOrderHistoryLoadingState());

    FirebaseFirestore.instance.collection('Users').doc(uID).collection('orders').get().then((value) {
      checkOuts = checkOutModelFromJson(value.docs);
      emit(GetOrderHistorySuccessState());
    }).onError((error, stackTrace) {emit(GetOrderHistoryErrorState());});
    
  }
  List<OrderModel>? orders; 
  getProductsOrder({required String historyId}){
    emit(GetProductsOrderHistoryLoadingState());

    FirebaseFirestore.instance.collection('Users').doc(uID).collection('orders').doc(historyId).collection('products').get().then((value) {
      orders = orderModelFromJson(value.docs);
      emit(GetProductsOrderHistorySuccessState());
    }).onError((error, stackTrace) {
      emit(GetProductsOrderHistoryErrorState());
    });
  }
}
