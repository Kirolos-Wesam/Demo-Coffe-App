import 'package:coffeeapp/module/paymentScreen/cubit/payment_method_cubit.dart';
import 'package:coffeeapp/shared/componets/componets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentMethodScreen extends StatelessWidget {
  PaymentMethodScreen({super.key});

  final formKey = GlobalKey<FormState>();
  var cardNumberController = TextEditingController();
  var nameHolderController = TextEditingController();
  var expiryDateController = TextEditingController();
  var cvvController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentMethodCubit, PaymentMethodState>(
      listener: (context, state) {
        if(state is AddPaymentCardSuccessState){
          PaymentMethodCubit.get(context).getPamyentCard();
          showToast(text: 'Your Card Have been added Successfully', state: ToastStates.SUCCESS);
          PaymentMethodCubit.get(context).showCard(false);
          cardNumberController.clear();
          nameHolderController.clear();
          expiryDateController.clear();
          cvvController.clear();
        }
      },
      builder: (context, state) {
        var cubit = PaymentMethodCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            backgroundColor: Colors.grey[100],
            leading: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    )),
              ),
            ),
            title: Center(
                child: Padding(
              padding: const EdgeInsets.only(right: 45),
              child: defaultText(text: 'payment', color: Colors.black),
            )),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if(cubit.cards == null || state is GetPaymentCardLoadingState)
                      LinearProgressIndicator(minHeight: 2, color: mainColor,),
                    if(cubit.cards != null)
                      if(cubit.cards!.isEmpty)
                        Center(child: defaultText(text: "You don't have any Payment Card", color: Colors.black),)
                    else
                    ListView.separated(
                      shrinkWrap: true,
                        itemBuilder: (context, index ){
                      return Container(
                        width: double.infinity,
                        height: 160,
                        decoration: BoxDecoration(
                            borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                            color: Colors.blue[900]),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        child: defaultText(
                                            text: cubit.cards![index].cardNumber!,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20)),
                                    Image.asset(
                                      'assets/images/mastercardlogo.png',
                                      width: 50,
                                      height: 50,
                                    )
                                  ],
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    defaultText(
                                        text: cubit.cards![index].expDate!,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    defaultText(
                                        text: cubit.cards![index].cvv!.toString(),
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ],
                                ),
                                const Spacer(),
                                defaultText(
                                    text: cubit.cards![index].nameHolder!,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17)
                              ]),
                        ),
                      );
                    }, separatorBuilder: (context,index){
                      return SizedBox(height: 10,);
                    }, itemCount: cubit.cards!.length),
                    const SizedBox(
                      height: 20,
                    ),
                    if (cubit.showAddCard)
                      Container(
                        width: double.infinity,
                        height: 380,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          color: Colors.grey[400],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  defaultText(
                                      text: 'Add Payment Card',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                  const Spacer(),
                                  Expanded(
                                      child: IconButton(
                                          onPressed: () {
                                            cubit.showCard(false);
                                          },
                                          icon: const Icon(
                                            Icons.close,
                                            color: Colors.red,
                                          )))
                                ],
                              ),
                              defaultText(
                                  text: 'Card Number',
                                  color: Colors.black,
                                  fontSize: 15),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                width: double.infinity,
                                height: 50,
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(25),
                                    ),
                                    color: Colors.white),
                                child: TextFormField(
                                  controller: cardNumberController,
                                  maxLength: 19,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter a card number';
                                    } else if (value.length != 19 ||
                                        !isValidCardNumber(value)) {
                                      return 'Invalid card number';
                                    }
                                    return null;
                                  },
                                  inputFormatters: [CardNumberFormatter()],
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      hintText: 'Card Number ',
                                      counterText: '',
                                      border: InputBorder.none),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              defaultText(
                                  text: 'Name Holder',
                                  color: Colors.black,
                                  fontSize: 15),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                width: double.infinity,
                                height: 50,
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(25),
                                    ),
                                    color: Colors.white),
                                child: TextFormField(
                                  controller: nameHolderController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter Name Holder';
                                    }
                                    return null;
                                  },
                                  textCapitalization:
                                      TextCapitalization.characters,
                                  keyboardType: TextInputType.name,
                                  decoration: const InputDecoration(
                                      hintText: 'Name',
                                      border: InputBorder.none),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        defaultText(
                                            text: 'Exp date',
                                            color: Colors.black,
                                            fontSize: 15),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          width: 100,
                                          height: 50,
                                          padding: const EdgeInsets.only(
                                              left: 20, right: 20),
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(25),
                                              ),
                                              color: Colors.white),
                                          child: TextFormField(
                                            maxLength: 5,
                                            controller: expiryDateController,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter an expiration date';
                                              } else if (!isDateValid(value)) {
                                                return 'Invalid expiration date';
                                              }
                                              return null;
                                            },
                                            onChanged: (value) {
                                              if (value.length == 2 &&
                                                  !expiryDateController.text
                                                      .contains('/')) {
                                                expiryDateController.text =
                                                    '${expiryDateController.text}/';
                                                expiryDateController.selection =
                                                    TextSelection.fromPosition(
                                                  TextPosition(
                                                      offset:
                                                          expiryDateController
                                                              .text.length),
                                                );
                                              }
                                            },
                                            keyboardType: TextInputType.number,
                                            decoration: const InputDecoration(
                                                hintText: 'MM/YY',
                                                counterText: '',
                                                border: InputBorder.none),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        defaultText(
                                            text: 'CVV',
                                            color: Colors.black,
                                            fontSize: 15),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          width: 100,
                                          height: 50,
                                          padding: const EdgeInsets.only(
                                              left: 20, right: 20),
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(25),
                                              ),
                                              color: Colors.white),
                                          child: TextFormField(
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter a CVV';
                                              } else if (value.length != 3 ||
                                                  int.tryParse(value) == null) {
                                                return 'Invalid CVV';
                                              }
                                              return null;
                                            },
                                            controller: cvvController,
                                            maxLength: 3,
                                            keyboardType: TextInputType.number,
                                            decoration: const InputDecoration(
                                                hintText: 'XXX',
                                                counterText: '',
                                                border: InputBorder.none),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              if(state is AddPaymentCardLoadingState)
                              Center(child: CircularProgressIndicator(color: mainColor,),)
                              else
                              SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if(formKey.currentState!.validate()){
                                        cubit.addPaymentCard(cardNumber: cardNumberController.text
                                        , nameHolder: nameHolderController.text
                                        , expDate: expiryDateController.text
                                        , cvv: num.parse(cvvController.text));
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: mainColor),
                                    child: defaultText(
                                        text: 'Add Card',
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                      onPressed: () {
                        cubit.showCard(true);
                      },
                      height: 60,
                      color: Colors.white,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/mastercardlogo.png',
                            width: 30,
                            height: 30,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          defaultText(
                              text: 'Add Payment Card',
                              color: Colors.black)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  bool isValidCardNumber(String cardNumber) {
    final cleanCardNumber = cardNumber.replaceAll(' ', '');
    if (cleanCardNumber.length != 16 || int.tryParse(cleanCardNumber) == null) {
      return false;
    }
    return true;
  }

  bool isDateValid(String date) {
    final parts = date.split('/');
    if (parts.length != 2) return false;
    final month = int.tryParse(parts[0]);
    final year = int.tryParse(parts[1]);
    if (month == null || year == null) return false;
    return month >= 1 && month <= 12 && year >= 21 && year <= 99;
  }
}
