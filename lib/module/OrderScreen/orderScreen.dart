import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffeeapp/model/ordermodel.dart';
import 'package:coffeeapp/model/productmodel.dart';
import 'package:coffeeapp/module/OrderScreen/cubit/order_screen_cubit.dart';
import 'package:coffeeapp/module/productInfoScreen/productinfoscreen.dart';
import 'package:coffeeapp/shared/componets/componets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = OrderCubit.get(context);
    return BlocConsumer<OrderCubit, OrderState>(
      listener: (context, state) {
        if (state is CheckOutOrderSuccussState) {
          for (int i = 0; i < cubit.products.length; i++) {
            cubit.addOrder(
                productId: cubit.products[i].id!,
                productName: cubit.products[i].name!,
                productTitle: cubit.products[i].title!,
                productSize: 1,
                price: cubit.products[i].price!,
                productCount: cubit.count[i],
                productImage: cubit.products[i].profileImage!);
            cubit.deleteCarts(i);
            if (i == cubit.products.length - 1) {
              cubit.checkOutDone();
              Navigator.pop(context);
            }
          }
        }
        if (state is CheckOutDoneState) {
          showToast(
              text: 'You Orders Have been Done', state: ToastStates.SUCCESS);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Center(
              child: defaultText(text: 'Orders', color: Colors.black),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: cubit.total == 0
                ? Center(
                    child: defaultText(
                        text: "you don't have any Orders", color: Colors.black),
                  )
                : Column(
                    children: [
                      if (cubit.products.isNotEmpty)
                        Expanded(
                          flex: 6,
                          child: ListView.separated(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return Dismissible(
                                  key: ValueKey<ProductModel>(
                                      cubit.products[index]),
                                  direction: DismissDirection.endToStart,
                                  onDismissed: (value) {
                                    cubit.removeOrder(index);
                                  },
                                  background: Container(
                                    alignment: AlignmentDirectional.centerEnd,
                                    padding: const EdgeInsets.only(right: 40),
                                    color: mainColor,
                                    child: const Icon(
                                      Icons.delete_outlined,
                                      color: Colors.white,
                                    ),
                                  ),
                                  child: Container(
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                    height: 110,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              navigateTo(
                                                  context,
                                                  ProductInfo(
                                                    productId: cubit
                                                        .products[index].id!,
                                                    coffeeName: cubit
                                                        .products[index].name!,
                                                    title: cubit
                                                        .products[index].title!,
                                                    description: cubit
                                                        .products[index]
                                                        .description!,
                                                    categoryId: cubit
                                                        .products[index]
                                                        .categoryId!,
                                                    image: cubit.products[index]
                                                        .profileImage!,
                                                    price: cubit
                                                        .products[index].price!,
                                                    rate: 4.6,
                                                    showOrder: false,
                                                  ));
                                            },
                                            child: CachedNetworkImage(
                                              imageUrl: cubit.products[index]
                                                  .profileImage!,
                                              imageBuilder:
                                                  (context, imageProvider) {
                                                return Container(
                                                  width: 120,
                                                  height: double.infinity,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  15)),
                                                      image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.cover)),
                                                );
                                              },
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: InkWell(
                                                          onTap: () {
                                                            navigateTo(
                                                                context,
                                                                ProductInfo(
                                                                  productId: cubit
                                                                      .products[
                                                                          index]
                                                                      .id!,
                                                                  coffeeName: cubit
                                                                      .products[
                                                                          index]
                                                                      .name!,
                                                                  title: cubit
                                                                      .products[
                                                                          index]
                                                                      .title!,
                                                                  description: cubit
                                                                      .products[
                                                                          index]
                                                                      .description!,
                                                                  categoryId: cubit
                                                                      .products[
                                                                          index]
                                                                      .categoryId!,
                                                                  image: cubit
                                                                      .products[
                                                                          index]
                                                                      .profileImage!,
                                                                  price: cubit
                                                                      .products[
                                                                          index]
                                                                      .price!,
                                                                  rate: 4.6,
                                                                  showOrder:
                                                                      false,
                                                                ));
                                                          },
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              defaultText(
                                                                  text: cubit
                                                                      .products[
                                                                          index]
                                                                      .name!,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 16),
                                                              defaultText(
                                                                  text: cubit
                                                                      .products[
                                                                          index]
                                                                      .title!,
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 11,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                          alignment: Alignment
                                                              .topRight,
                                                          child: defaultText(
                                                              text: 'M',
                                                              color: Colors
                                                                  .black)),
                                                      const SizedBox(
                                                        width: 10,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Row(
                                                    children: [
                                                      defaultText(
                                                          text:
                                                              '${cubit.count[index] >= 1 ? cubit.products[index].price! * cubit.count[index] : cubit.products[index].price!} EGP',
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      const Spacer(),
                                                      InkWell(
                                                        onTap: () {
                                                          cubit.countMinus(
                                                              index);
                                                        },
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                                  border: Border
                                                                      .all(
                                                                    color:
                                                                        mainColor,
                                                                  ),
                                                                  shape: BoxShape
                                                                      .circle),
                                                          child: CircleAvatar(
                                                            backgroundColor:
                                                                Colors.white,
                                                            radius: 15,
                                                            child: defaultText(
                                                                text: '-',
                                                                color:
                                                                    mainColor),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 8,
                                                      ),
                                                      defaultText(
                                                          text: cubit
                                                              .count[index]
                                                              .clamp(1, 20)
                                                              .toString()
                                                              .padLeft(2, '0'),
                                                          color: mainColor),
                                                      const SizedBox(
                                                        width: 8,
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          cubit
                                                              .countPlus(index);
                                                        },
                                                        child: CircleAvatar(
                                                          backgroundColor:
                                                              mainColor,
                                                          radius: 15,
                                                          child: defaultText(
                                                              text: '+',
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    height: 8,
                                  ),
                              itemCount: cubit.products.length),
                        ),
                      Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    defaultText(
                                        text: 'Tax:',
                                        color: Colors.grey,
                                        fontSize: 15),
                                    defaultText(
                                        text: '10 EGP',
                                        color: Colors.black,
                                        fontSize: 16)
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    defaultText(
                                        text: 'Total:',
                                        color: Colors.grey,
                                        fontSize: 15),
                                    defaultText(
                                        text: '${cubit.totalPayment + 10} EGP',
                                        color: Colors.black,
                                        fontSize: 16)
                                  ],
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 1,
                                  color: Colors.grey,
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                defaultText(
                                    text: 'Delivery Time',
                                    color: Colors.grey,
                                    fontSize: 18),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    defaultText(
                                        text: '28 Feb 2024',
                                        color: Colors.black,
                                        fontSize: 16),
                                    defaultText(
                                        text: '10:30 AM',
                                        color: Colors.black,
                                        fontSize: 16),
                                  ],
                                )
                              ],
                            ),
                          )),
                      Expanded(
                          flex: 1,
                          child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  
                                  showBottomSheet(context,state, cubit);
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: mainColor),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if(state is CheckOutOrderSuccussState)
                                    Center(child: CircularProgressIndicator(),)
                                    else
                                    Center(
                                      child: defaultText(
                                          text: 'CHECKOUT',
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              )))
                    ],
                  ),
          ),
        );
      },
    );
  }

  void showBottomSheet(context, state, cubit) {
    showModalBottomSheet(context: context, builder: (context){
      return Container(
        color: Colors.grey[100],
        width: double.infinity,
        height: 200,
        child: Padding(padding: EdgeInsets.all(15), 
        child: Column(
          children: [
            SizedBox(
              height: 60,
              child: MaterialButton(onPressed: (){ 
                cubit.checkOut(); 
              }, color: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15),)), elevation: 0, 
              child: Row(
                children: [
                  Icon(Icons.money, color: Colors.green,),
                  SizedBox(width: 10,),
                  defaultText(text: 'Cash', color: Colors.black)
                ],
              ),),
            ),
            SizedBox(height: 15,),
            SizedBox(
              height: 60,
              child: MaterialButton(onPressed: (){  
                cubit.checkOut();
              }, color: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15),)), elevation: 0, 
              child: Row(
                children: [
                  Image.asset('assets/images/mastercardlogo.png', width: 40, height: 40,),
                  SizedBox(width: 10,),
                  defaultText(text: 'Payment', color: Colors.black)
                ],
              ),),
            )
          ],
        ),
        ),
      );
    });
  }
}
