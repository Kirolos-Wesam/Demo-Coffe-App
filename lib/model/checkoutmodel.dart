import 'package:cloud_firestore/cloud_firestore.dart';

List<CheckOutModel> productIdModelFromJson(List<QueryDocumentSnapshot> list) =>
    List<CheckOutModel>.from(list
        .map((x) => CheckOutModel.fromJson(x.data() as Map<String, dynamic>)));

class CheckOutModel {
  String? id;
  num? price;
  DateTime? date;

  CheckOutModel({
    this.id,
    this.price,
    this.date
  });
  CheckOutModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    date = json['date'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'price': price,
      'date': date,
    };
  }
}
