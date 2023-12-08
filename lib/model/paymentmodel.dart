
import 'package:cloud_firestore/cloud_firestore.dart';

List<PaymentModel> paymentModelFromJson(List<QueryDocumentSnapshot> list) =>
    List<PaymentModel>.from(list
        .map((x) => PaymentModel.fromJson(x.data() as Map<String, dynamic>)));

class PaymentModel {
  String? id;
  String? cardNumber;
  String? nameHolder;
  String? expDate;
  num? cvv;
 

  PaymentModel({
    this.id,
    required this.cardNumber,
    this.nameHolder,
    required this.expDate,
    required this.cvv,
  });
  PaymentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cardNumber = json['cardNumber'];
    nameHolder = json['nameHolder'];
    expDate = json['expDate'];
    cvv = json['cvv'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cardNumber': cardNumber,
      'nameHolder': nameHolder,
      'expDate': expDate,
      'cvv': cvv,
    };
  }
}
