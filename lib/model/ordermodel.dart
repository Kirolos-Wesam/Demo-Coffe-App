import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

List<OrderModel> orderModelFromJson(List<QueryDocumentSnapshot> list) =>
    List<OrderModel>.from(
        list.map((x) => OrderModel.fromJson(x.data() as Map<String, dynamic>)));

class OrderModel {
  String? id;
  String? productId;
  String? productName;
  String? productTitle;
  String? productImage;
  int? productSize;
  num? price;
  num productCount = 1;

  OrderModel({
    this.id,
    required this.productId,
    required this.productName,
    required this.productTitle,
    required this.productImage,
    required this.productSize,
    required this.price,
    required this.productCount,
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['productId'];
    productName = json['productName'];
    productTitle = json['productTitle'];
    productImage = json['productImage'];
    productSize = json['productSize'];
    price = json['price'];
    productCount = json['productCount'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'productTitle': productTitle,
      'productImage': productImage,
      'productSize': productSize,
      'price': price,
      'productCount': productCount,
    };
  }

  // Convert MyModel to a JSON string
  String toJson() => json.encode(toMap());

  factory OrderModel.FromJson(String source) =>
      OrderModel.fromJson(json.decode(source));
}
