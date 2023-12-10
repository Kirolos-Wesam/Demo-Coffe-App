import 'package:coffeeapp/module/orderhistoryscreen/cubit/order_history_cubit.dart';
import 'package:coffeeapp/module/orderhistoryscreen/orderproductshistory.dart';
import 'package:coffeeapp/shared/componets/componets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = OrderHistoryCubit.get(context);
    return BlocConsumer<OrderHistoryCubit, OrderHistoryState>(
      listener: (context, state) {
        // TODO: implement listener
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
                  child: defaultText(text: 'Orders History', color: Colors.black),
                )),
              ),
              body: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if(cubit.checkOuts == null)
                      LinearProgressIndicator(minHeight: 2, backgroundColor: mainColor,)
                      else
                      ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index){
                        return InkWell(
                          onTap: (){
                            cubit.getProductsOrder(historyId: cubit.checkOuts![index].id!);
                            navigateTo(context, const OrderProductsHistoryScreen());
                          },
                          child: Container(
                          width: double.infinity,
                          height: 150,
                          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              Row(
                                children: [
                                  defaultText(text: 'Date:', color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
                                  const SizedBox(width: 5,),
                                  defaultText(text:  DateFormat.yMEd().add_jms().format(cubit.checkOuts![index].date!),color: Colors.black, fontSize: 15)
                                ],
                              ),
                              const Spacer(),
                              defaultText(text: '${cubit.checkOuts![index].price} EGP', color: Colors.black, fontWeight: FontWeight.bold)
                            ]),
                          ),
                                                ),
                        );
                      }
                      , separatorBuilder: (context, index) => const SizedBox(height: 10,), itemCount: cubit.checkOuts!.length)
                      
                    ],
                  ),
                ),
              ),
        );
      },
    );
  }
}