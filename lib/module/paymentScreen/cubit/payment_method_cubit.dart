import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffeeapp/model/paymentModel.dart';
import 'package:coffeeapp/shared/componets/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'payment_method_state.dart';

class PaymentMethodCubit extends Cubit<PaymentMethodState> {
  PaymentMethodCubit() : super(PaymentMethodInitial());

  static PaymentMethodCubit get(context) => BlocProvider.of(context);

  bool showAddCard = false;
  showCard(bool i) {
    showAddCard = i;
    emit(ShowAddCardState());
  }
  addPaymentCard(
      {required String cardNumber,
      required String nameHolder,
      required String expDate,
      required num cvv}) {
    emit(AddPaymentCardLoadingState());
    PaymentModel addPaymentCard = PaymentModel(
        cardNumber: cardNumber,
        expDate: expDate,
        cvv: cvv,
        nameHolder: nameHolder);
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uID)
        .collection('paymentCards')
        .add(addPaymentCard.toMap())
        .then((card) {
      PaymentModel addIdPaymentCard = PaymentModel(
          cardNumber: cardNumber,
          expDate: expDate,
          cvv: cvv,
          nameHolder: nameHolder,
          id: card.id);
      FirebaseFirestore.instance
          .collection('Users')
          .doc(uID)
          .collection('paymentCards')
          .doc(card.id)
          .update(addIdPaymentCard.toMap())
          .then((value) => emit(AddPaymentCardSuccessState()));
    }).onError((error, stackTrace) {emit(AddPaymentCardErrorState());});
  }

  List<PaymentModel>? cards;
  getPamyentCard(){
    emit(GetPaymentCardLoadingState());

    FirebaseFirestore.instance.collection('Users').doc(uID).collection('paymentCards').get().then((value) {
        cards = paymentModelFromJson(value.docs);
        emit(GetPaymentCardSuccessState());
    }).onError((error, stackTrace) {
      emit(GetPaymentCardErrorState());
    });
  }

}
