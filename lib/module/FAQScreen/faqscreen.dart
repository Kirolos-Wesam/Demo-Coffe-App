import 'package:coffeeapp/module/FAQScreen/cubit/faq_cubit.dart';
import 'package:coffeeapp/shared/componets/componets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = FaqCubit.get(context);
    return BlocConsumer<FaqCubit, FaqState>(
      listener: (context, state) {
      },
      builder: (context, state) {
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
              child: defaultText(text: 'FAQ', color: Colors.black),
            )),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Frequently\nAsked Questions',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                    maxLines: 2,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: defaultText(text: 'General', color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(height: 5,),
                  Theme(
                    data: Theme.of(context).copyWith(
                      dividerColor:
                          Colors.transparent, // Set dividerColor to transparent
                    ),
                    child: ExpansionTile(
                      trailing: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: mainColor)),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: cubit.arrowCheck[0] == false
                              ? Icon(
                                  Icons.keyboard_arrow_down,
                                  color: mainColor,
                                )
                              : Icon(
                                  Icons.keyboard_arrow_up,
                                  color: mainColor,
                                ),
                        ),
                      ),
                      onExpansionChanged: (value) {
                        cubit.changeArrow(value, 0);
                      },
                      title: const Text(
                        '1.How do i place an order on your website?',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            'All you need to do to place an order on our website is to choose the product that you would like to buy, then add it to cart and pay for it using any of supported payment methods',
                            style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Theme(
                    data: Theme.of(context).copyWith(
                      dividerColor:
                          Colors.transparent, // Set dividerColor to transparent
                    ),
                    child: ExpansionTile(
                      trailing: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: mainColor)),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: cubit.arrowCheck[1] == false
                              ? Icon(
                                  Icons.keyboard_arrow_down,
                                  color: mainColor,
                                )
                              : Icon(
                                  Icons.keyboard_arrow_up,
                                  color: mainColor,
                                ),
                        ),
                      ),
                      onExpansionChanged: (value) {
                        cubit.changeArrow(value,1);
                      },
                      title: const Text(
                        '2.What is your return policy?',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            'Any items purchased from Coffee App can be returned for a full refund (subject to 30EGP return fee) within 30 days from when you received your item(s). ',
                            style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Theme(
                    data: Theme.of(context).copyWith(
                      dividerColor:
                          Colors.transparent, // Set dividerColor to transparent
                    ),
                    child: ExpansionTile(
                      trailing: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: mainColor)),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: cubit.arrowCheck[2] == false
                              ? Icon(
                                  Icons.keyboard_arrow_down,
                                  color: mainColor,
                                )
                              : Icon(
                                  Icons.keyboard_arrow_up,
                                  color: mainColor,
                                ),
                        ),
                      ),
                      onExpansionChanged: (value) {
                        cubit.changeArrow(value,2);
                      },
                      title: const Text(
                        '3.What shipping company do you use?',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            'Orders within the continental EG are shipped via FedEx. During checkout, you can select FedEx Home Delivery, FedEx 2 Day, or FedEx Standard Overnight ',
                            style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
