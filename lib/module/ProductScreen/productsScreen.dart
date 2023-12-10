// ignore_for_file: sized_box_for_whitespace

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:coffeeapp/layout/HomeScreen/cubit/home_screen_cubit.dart';
import 'package:coffeeapp/model/productmodel.dart';
import 'package:coffeeapp/module/OrderScreen/cubit/order_screen_cubit.dart';
import 'package:coffeeapp/module/ProductScreen/cubit/products_screen_cubit.dart';
import 'package:coffeeapp/module/productInfoScreen/cubit/product_info_cubit.dart';
import 'package:coffeeapp/module/productInfoScreen/productinfoscreen.dart';
import 'package:coffeeapp/shared/componets/componets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({super.key});

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsCubit, ProductsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = ProductsCubit.get(context);
        List<ProductModel> filteredProduct = cubit.products.where((element) {
          if (cubit.currentIndex == 0) {
            return element.categoryId == 1;
          } else if (cubit.currentIndex == 1) {
            return element.categoryId == 2;
          } else {
            return element.categoryId == 3;
          }
        }).toList();
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 420,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Container(
                        height: 370,
                        width: double.infinity,
                        padding: const EdgeInsetsDirectional.symmetric(vertical: 30),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(60),
                                bottomRight: Radius.circular(60)),
                            color: Colors.grey[900]),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.notifications_none,
                                          color: Colors.white,
                                        )),
                                     if(HomeCubit.get(context).user != null)   
                                     InkWell(
                                      onTap: (){
                                        HomeCubit.get(context).changeNavBottom(3);
                                      },
                                       child: Text(
                                        HomeCubit.get(context).user!.name! ,
                                        style: TextStyle(color: Colors.white),
                                                                           ),
                                     ),
                                    if(HomeCubit.get(context).user != null) 
                                     InkWell(
                                      onTap: (){
                                        HomeCubit.get(context).changeNavBottom(3);
                                      },
                                       child: CircleAvatar(
                                        radius: 25,
                                        backgroundImage: CachedNetworkImageProvider(HomeCubit.get(context).user!.image!),
                                                                           ),
                                     )
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                if(HomeCubit.get(context).user != null) 
                                 Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Hello, ${HomeCubit.get(context).user!.name!.split(' ').first} ',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: 'Poppins'),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 50,
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(17)),
                                      color: Colors.white),
                                  child: TextFormField(
                                    controller: searchController,
                                    validator: (value) {
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Search Coffee..',
                                      contentPadding: const EdgeInsets.all(8),
                                      border: InputBorder.none,
                                      prefixIcon: const Icon(Icons.search),
                                      suffixIcon: IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.keyboard_control,
                                            color: mainColor,
                                          )),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: defaultText(
                                    text: 'Special Offers 🔥',
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    ),
                    if (cubit.imageUrl.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: Container(
                          width: double.infinity,
                          height: 125,
                          child: CarouselSlider(
                            items: cubit.imageUrl
                                .map((e) => CachedNetworkImage(
                                      imageUrl: e.toString(),
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius: const BorderRadius.all(
                                                Radius.circular(30)),
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            )),
                                      ),
                                    ))
                                .toList(),
                            options: CarouselOptions(
                                height: double.infinity,
                                initialPage: 0,
                                viewportFraction: 1.0,
                                reverse: false,
                                autoPlay: true,
                                autoPlayInterval: const Duration(seconds: 3),
                                autoPlayAnimationDuration: const Duration(seconds: 3),
                                autoPlayCurve: Curves.fastOutSlowIn,
                                scrollDirection: Axis.horizontal),
                          ),
                        ),
                      )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    defaultText(
                        text: 'Categories', color: Colors.black, fontSize: 18),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 30,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  cubit.switchButton(0);
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: cubit.currentIndex == 0
                                        ? mainColor
                                        : Colors.white),
                                child: defaultText(
                                  text: 'Cappuccino',
                                  color: cubit.currentIndex == 0
                                      ? Colors.white
                                      : Colors.black,
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  cubit.switchButton(1);
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: cubit.currentIndex == 1
                                        ? mainColor
                                        : Colors.white),
                                child: defaultText(
                                  text: 'Cold Brew',
                                  color: cubit.currentIndex == 1
                                      ? Colors.white
                                      : Colors.black,
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  cubit.switchButton(2);
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: cubit.currentIndex == 2
                                        ? mainColor
                                        : Colors.white),
                                child: defaultText(
                                  text: 'espresso',
                                  color: cubit.currentIndex == 2
                                      ? Colors.white
                                      : Colors.black,
                                )),
                          ],
                        ),
                      ),
                    ),
                    if(filteredProduct.isEmpty)
                    const Padding(
                      padding: EdgeInsets.only(top: 100),
                      child: Center(child: CircularProgressIndicator()),
                    )
                    else
                    Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: GridView.count(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          crossAxisSpacing: 9,
                          mainAxisSpacing: 14,
                          childAspectRatio: .79,
                          children: List.generate(filteredProduct.length, (index) => products(filteredProduct,index, context)),
                        ))
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget products(List<ProductModel> products, index, context) => Card(
        elevation: 8,
        child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 105,
                  child: InkWell(
                    onTap: (){
                      ProductInfoCubit.get(context).checkFavorite(id: products[index].id!);
                      navigateTo(context, ProductInfo(productId: products[index].id! , coffeeName: products[index].name!, title: products[index].title!, description: products[index].description!, categoryId: products[index].categoryId!, image: products[index].profileImage!, price: products[index].price!, rate: 4.6, showOrder: true,));
                    },
                    child: CachedNetworkImage(imageUrl: products[index].profileImage!, imageBuilder: (context, imageProvider){
                      return Container(
                        decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(15)), image: DecorationImage(image: imageProvider, fit: BoxFit.cover)),
                      );
                    }),
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: (){
                          ProductInfoCubit.get(context).checkFavorite(id: products[index].id!);
                          navigateTo(context, ProductInfo(productId: products[index].id! , coffeeName: products[index].name!, title: products[index].title!, description: products[index].description!, categoryId: products[index].categoryId!, image: products[index].profileImage!, price: products[index].price!, rate: 4.6, showOrder: true,));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            defaultText(
                                text: products[index].name!,
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                            defaultText(
                                text: products[index].title!,
                                color: Colors.black,
                                fontSize: 9,
                                fontWeight: FontWeight.bold),
                            const SizedBox(
                              height: 6,
                            ),
                            defaultText(
                                text: '${products[index].price.toString()} EGP',
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: InkWell(
                        onTap: (){
                         //ProductInfoCubit.get(context).addOrder(productId: products[index].id!, productName: products[index].name!, productTitle: products[index].title!, productImage: products[index].profileImage!, productSize: 1, checkOut: false, price: products[index].price!, productCount: 1);
                         ProductInfoCubit.get(context).addOrder(productId: products[index].id!);
                         OrderCubit.get(context).getOrders(context);
                         
                        },
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: mainColor,
                          child: const Icon(Icons.add, color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
                
              ],
            ),
          ),
        ),
      );
}
