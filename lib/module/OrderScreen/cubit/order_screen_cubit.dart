import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffeeapp/model/checkoutmodel.dart';
import 'package:coffeeapp/model/idsproductmodel.dart';
import 'package:coffeeapp/model/ordermodel.dart';
import 'package:coffeeapp/model/productmodel.dart';
import 'package:coffeeapp/module/ProductScreen/cubit/products_screen_cubit.dart';
import 'package:coffeeapp/module/productInfoScreen/cubit/product_info_cubit.dart';
import 'package:coffeeapp/shared/componets/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'order_screen_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderScreenInitial());

  static OrderCubit get(context) => BlocProvider.of(context);

  List<OrderModel>? orders;
  List<OrderModel>? filter;
  List<CartModel>? carts;
  List<ProductModel> products = []; 
  List<int> count = [];
  num total = 0;
  num totalPayment = 0;

  getOrders(context) {
    emit(GetOrderLoadingState());
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uID)
        .collection('carts')
        .get()
        .then((value) {
      carts = cartModelFromJson(value.docs);
      for (int i = 0; i< carts!.length ;i++){
        for(int j = 0; j< ProductsCubit.get(context).products.length ; j++){
          if(carts![i].productId == ProductsCubit.get(context).products[j].id){
            products.add(ProductsCubit.get(context).products[j]);
            total += ProductsCubit.get(context).products[j].price!;
            count.add(1);
          }
        }
        totalPayment = total;
        emit(GetOrderSuccussState());
      }
      print(total);
      emit(GetOrderSuccussState());
    }).onError((error, stackTrace) {
      emit(GetOrderErrorState());
    });
  }

  removeOrder(int i){
    FirebaseFirestore.instance.collection('Users').doc(uID).collection('carts').doc(carts![i].id).delete().then((value) {
      products.removeAt(i);
      emit(RemoveOrderSuccessState());
    });
  }

  countPlus(index) {
    count[index]++;
    if (count[index] <= 0) count[index] = 1;
    if (count[index] >= 1) {
      totalPayment = (total - products[index].price!) +
          (products[index].price! * count[index].clamp(1, 20));
      print(totalPayment);
      emit(CountPlusState());
    }
  }

  countMinus(index) {
    count[index]--;
    if (count[index] <= 0) count[index] = 1;
    if (count[index] >= 1) {
      totalPayment = (total - products[index].price!) +
          (products[index].price! * count[index].clamp(1, 20));
      print(totalPayment);
      emit(CountMinusState());
    }
  }
  

  String? checkOutId;
  checkOut() async{
    emit(CheckOutOrderLoadingState());
    CheckOutModel checkout = CheckOutModel(price: totalPayment, date: DateTime.now());
   await FirebaseFirestore.instance.collection('Users').doc(uID).collection('orders').add(checkout.toMap()).then((check) {
      checkOutId = check.id;
      CheckOutModel checkoutId = CheckOutModel(id: check.id ,price: totalPayment, date: DateTime.now());
      FirebaseFirestore.instance.collection('Users').doc(uID).collection('orders').doc(check.id).update(checkoutId.toMap()).then((value){
        emit(CheckOutOrderSuccussState());
      });
    });
  }
  addOrder({ 
    required String productId,
    required String productName,
    required String productTitle,
    required int productSize,
    required num price,
    required num productCount,
    required String productImage,
  })async{
    print(checkOutId);
    OrderModel addProduct = OrderModel(productId: productId, productName: productName, productTitle: productTitle, productImage: productImage, productSize: productSize, price: price, productCount: productCount);
   await FirebaseFirestore.instance.collection('Users').doc(uID).collection('orders').doc(checkOutId).collection('products').add(addProduct.toMap()).then((product) {
      OrderModel addProductId = OrderModel(id: product.id,productId: productId, productName: productName, productTitle: productTitle, productImage: productImage, productSize: productSize, price: price, productCount: productCount);
      FirebaseFirestore.instance.collection('Users').doc(uID).collection('orders').doc(checkOutId).collection('products').doc(product.id).update(addProductId.toMap());
    });
  }

  deleteCarts(int i){
    FirebaseFirestore.instance.collection('Users').doc(uID).collection('carts').doc(carts![i].id).delete();
  }

  checkOutDone(){
    total = 0;
    totalPayment = 0;
    products.clear();
    count.clear();
    emit(CheckOutDoneState());
  }

}
