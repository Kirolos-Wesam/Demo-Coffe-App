import 'package:cloud_firestore/cloud_firestore.dart';

List<CartModel> cartModelFromJson(List<QueryDocumentSnapshot> list) =>
    List<CartModel>.from(list
        .map((x) => CartModel.fromJson(x.data() as Map<String, dynamic>)));

class CartModel {
  String? id;
  String? productId;

  CartModel({
    this.productId,
    this.id,
  });
  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['productId'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': productId,
    };
  }
}
