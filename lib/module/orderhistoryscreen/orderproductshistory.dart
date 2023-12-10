import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffeeapp/module/orderhistoryscreen/cubit/order_history_cubit.dart';
import 'package:coffeeapp/module/productInfoScreen/productinfoscreen.dart';
import 'package:coffeeapp/shared/componets/componets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderProductsHistoryScreen extends StatelessWidget {
  const OrderProductsHistoryScreen({super.key});

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
                  cubit.orders = null;
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
            child: Column(
              children: [
                if(cubit.orders == null)
                LinearProgressIndicator(minHeight: 2, backgroundColor: mainColor,)
                else
                ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                          navigateTo(context, ProductInfo(productId: cubit.orders![index].productId!
                          , coffeeName: cubit.orders![index].productName!
                          , title: cubit.orders![index].productTitle!
                          , description: cubit.orders![index].productTitle!
                          , categoryId: cubit.orders![index].productSize!
                          , image: cubit.orders![index].productImage!
                          , price: cubit.orders![index].price!
                          , rate: 4.6, showOrder: false));
                        },
                        child: Container(
                          width: double.infinity,
                          height: 135,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                              color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CachedNetworkImage(
                                  imageUrl:
                                     cubit.orders![index].productImage! ,
                                  imageBuilder: (context, imageProvider) {
                                    return Container(
                                      width: 120,
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(15)),
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover)),
                                    );
                                  },
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      defaultText(
                                          text: '${cubit.orders![index].productName} (${cubit.orders![index].productSize == 0 ? 'S' : cubit.orders![index].productSize == 1 ? 'M' : 'L'})',
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17),
                                      defaultText(
                                          text: cubit.orders![index].productTitle!,
                                          color: Colors.black,
                                          fontSize: 14),
                                      Spacer(),
                                      defaultText(
                                          text: '${cubit.orders![index].price} EGP (${cubit.orders![index].productCount})',
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                          height: 10,
                        ),
                    itemCount: 1)
              ],
            ),
          ),
        );
      },
    );
  }
}
