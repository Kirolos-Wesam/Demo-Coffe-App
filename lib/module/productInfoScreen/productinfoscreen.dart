// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffeeapp/module/FavouriteScreen/cubit/favourtie_screen_cubit.dart';
import 'package:coffeeapp/module/OrderScreen/cubit/order_screen_cubit.dart';
import 'package:coffeeapp/shared/network/local/cachehelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:coffeeapp/module/productInfoScreen/cubit/product_info_cubit.dart';
import 'package:coffeeapp/shared/componets/componets.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductInfo extends StatelessWidget {
  String productId;
  String coffeeName;
  String title;
  String description;
  int categoryId;
  String image;
  bool showOrder;
  num price;
  num rate;

  ProductInfo({
    Key? key,
    required this.productId,
    required this.coffeeName,
    required this.title,
    required this.description,
    required this.categoryId,
    required this.image,
    required this.price,
    required this.rate,
    required this.showOrder
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductInfoCubit, ProductInfoState>(
      listener: (context, state) {
        if(state is AddOrderSuccessState){
         showToast(text: 'Your order have been added, Go to Order to CheckOut', state: ToastStates.SUCCESS);
         OrderCubit.get(context).getOrders(context);
        }
      },
      builder: (context, state) {
        var cubit = ProductInfoCubit.get(context);
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    CachedNetworkImage(
                      imageUrl:
                          image,
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          width: double.infinity,
                          height: 370,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover)),
                        );
                      },
                    ),
                    Container(
                      width: double.infinity,
                      height: 110,
                      color: Colors.black.withOpacity(0.3),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  defaultText(
                                      text: coffeeName,
                                      color: Colors.white,
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold),
                                  defaultText(
                                      text: title,
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ]),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 26),
                              child: Container(
                                width: 70,
                                height: 30,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                    color: mainColor),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.star_outlined,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    defaultText(
                                        text: rate.toString(),
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold)
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional.bottomCenter,
                      child: Container(
                        width: double.infinity,
                        height: 35,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50)),
                            color: Colors.white),
                      ),
                    ),
                    Positioned(
                        top: 50,
                        left: 15,
                        child: InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.white.withOpacity(1),
                            radius: 20,
                            child: Center(
                                child: Icon(
                              Icons.arrow_back_ios_new,
                              color: mainColor,
                            )),
                          ),
                        )),
                    Positioned(
                        top: 50,
                        right: 15,
                        child: InkWell(
                            onTap: () {
                              if (cubit.isFavorite!) {
                                cubit.addFavorite(false, productId: productId, productName: coffeeName, title: title, description: description, categoryId: categoryId, price: price, profileImage: image);
                                FavoriteCubit.get(context).getFavorites();
                              } else {
                               cubit.addFavorite(true, productId: productId, productName: coffeeName, title: title, description: description, categoryId: categoryId, price: price, profileImage: image);
                               FavoriteCubit.get(context).getFavorites();
                              }
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.white.withOpacity(1),
                              radius: 20,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if(cubit.isFavorite == null)
                                  Container()
                                  else
                                  Center(
                                      child: Icon(
                                    cubit.isFavorite == false
                                        ? Icons.favorite_border_outlined
                                        : Icons.favorite,
                                    color: mainColor,
                                  )),
                                ],
                              ),
                            ))),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                              color: Colors.grey[500],
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(45))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.abc),
                                defaultText(
                                    text: 'Coffee',
                                    color: Colors.white,
                                    fontSize: 11),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width: 1,
                                  height: 30,
                                  color: Colors.black,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Icon(Icons.chair),
                                defaultText(
                                    text: 'Chocolate',
                                    color: Colors.white,
                                    fontSize: 11),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width: 1,
                                  height: 30,
                                  color: Colors.black,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: defaultText(
                                        text: 'Medium Roasted ',
                                        color: Colors.white,
                                        fontSize: 11)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              defaultText(
                                  text: coffeeName,
                                  color: Colors.black,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold),
                              defaultText(
                                  text: title,
                                  color: Colors.grey),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star_outlined,
                                    color: Colors.yellow[600],
                                  ),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  defaultText(
                                      text: rate.toString(),
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  defaultText(
                                      text: '(230)',
                                      color: Colors.grey,
                                      fontSize: 12)
                                ],
                              )
                            ],
                          ),
                          const Spacer(),
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(15),
                                ),
                                color: Colors.grey[100]),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(15),
                                ),
                                color: Colors.grey[100]),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultText(
                          text: 'Description',
                          color: Colors.black,
                          fontSize: 19,
                          fontWeight: FontWeight.bold),
                      const SizedBox(
                        height: 10,
                      ),
                       Text(
                        description,
                        maxLines: 3,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Poppins',
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                cubit.changeButtons(0);
                              },
                              child: Container(
                                width: cubit.currentIndex == 0 ? 70 : 130,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                    color: cubit.currentIndex == 0
                                        ? mainColor.withOpacity(.7)
                                        : Colors.white,
                                    border: Border.all(
                                        color: cubit.currentIndex == 0
                                            ? mainColor
                                            : Colors.grey)),
                                child: Center(
                                    child: defaultText(
                                        text: 'S',
                                        color: Colors.black,
                                        fontSize: 19)),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                cubit.changeButtons(1);
                              },
                              child: Container(
                                width: cubit.currentIndex == 1 ? 70 : 130,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                    border: Border.all(
                                        color: cubit.currentIndex == 1
                                            ? mainColor
                                            : Colors.grey),
                                    color: cubit.currentIndex == 1
                                        ? mainColor.withOpacity(.7)
                                        : Colors.white),
                                child: Center(
                                    child: defaultText(
                                        text: 'M',
                                        color: Colors.black,
                                        fontSize: 19)),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                cubit.changeButtons(2);
                              },
                              child: Container(
                                width: cubit.currentIndex == 2 ? 70 : 130,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                    border: Border.all(
                                        color: cubit.currentIndex == 2
                                            ? mainColor
                                            : Colors.grey),
                                    color: cubit.currentIndex == 2
                                        ? mainColor.withOpacity(.7)
                                        : Colors.white),
                                child: Center(
                                    child: defaultText(
                                        text: 'L',
                                        color: Colors.black,
                                        fontSize: 19)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      if(state is AddOrderLoadingState)
                      Center(child: CircularProgressIndicator(color: mainColor,))
                      else
                      if(showOrder)
                      SizedBox(
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {
                            cubit.addOrder(productId: productId);
                            //cubit.addOrder(productId: productId, productName: coffeeName, productTitle: title, productImage: image, productSize: cubit.currentIndex, checkOut: false, price: price, productCount: 1);
                            
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: mainColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                  flex: 3,
                                  child: defaultText(
                                    text: 'Order Now',
                                    color: Colors.white,
                                    fontSize: 20,
                                  )),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Container(
                                  width: 1,
                                  height: double.infinity,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                  flex: 1,
                                  child: defaultText(
                                    text: '$price EGP',
                                    color: Colors.white,
                                    fontSize: 17,
                                  )),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
