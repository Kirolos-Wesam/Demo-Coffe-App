
import 'package:cloud_firestore/cloud_firestore.dart';

List<FavoriteModel> favoriteModelFromJson(List<QueryDocumentSnapshot> list) =>
    List<FavoriteModel>.from(list
        .map((x) => FavoriteModel.fromJson(x.data() as Map<String, dynamic>)));

class FavoriteModel {
  String? productId;
  String? productName;
  String? title;
  String? description;
  num? price;
  int? categoryId;
  String? profileImage;

  FavoriteModel({
    required this.productId,
    required this.productName,
    this.title,
    required this.description,
    required this.price,
    required this.categoryId,
    this.profileImage,
  });
  FavoriteModel.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    productName = json['productName'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    categoryId = json['categoryId'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productName': productName,
      'title': title,
      'description': description,
      'price': price,
      'categoryId': categoryId,
      'profileImage': profileImage,

    };
  }
}
