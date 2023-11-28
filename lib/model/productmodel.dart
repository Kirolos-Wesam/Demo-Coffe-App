
import 'package:cloud_firestore/cloud_firestore.dart';

List<ProductModel> ProductModelFromJson(List<QueryDocumentSnapshot> list) =>
    List<ProductModel>.from(list
        .map((x) => ProductModel.fromJson(x.data() as Map<String, dynamic>)));

class ProductModel {
  String? id;
  String? name;
  String? title;
  String? description;
  num? price;
  int? categoryId;
  String? profileImage;

  ProductModel({
    this.id,
    required this.name,
    this.title,
    required this.description,
    required this.price,
    required this.categoryId,
    this.profileImage,
  });
  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    categoryId = json['categoryId'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'title': title,
      'description': description,
      'price': price,
      'categoryId': categoryId,
      'profileImage': profileImage,

    };
  }
}
