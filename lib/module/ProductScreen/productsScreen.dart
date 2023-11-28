// ignore_for_file: sized_box_for_whitespace

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:coffeeapp/model/productmodel.dart';
import 'package:coffeeapp/module/ProductScreen/cubit/products_screen_cubit.dart';
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
        List<ProductModel> fillterdProduct = cubit.products!.where((element) {
          if(cubit.currentIndex == 0){
            return element.categoryId == 1;
          }
          else if(cubit.currentIndex == 1){
             return element.categoryId == 2; 
          }
          else{
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
                        padding: EdgeInsetsDirectional.symmetric(vertical: 30),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
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
                                        icon: Icon(
                                          Icons.notifications_none,
                                          color: Colors.white,
                                        )),
                                    Text(
                                      'Kirolos Wesam',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    CircleAvatar(
                                      radius: 25,
                                      backgroundColor: Colors.orange,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Good Moring, Kirolos',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: 'Poppins'),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 50,
                                  decoration: BoxDecoration(
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
                                      contentPadding: EdgeInsets.all(8),
                                      border: InputBorder.none,
                                      prefixIcon: Icon(Icons.search),
                                      suffixIcon: IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.keyboard_control,
                                            color: Colors.brown,
                                          )),
                                    ),
                                  ),
                                ),
                                SizedBox(
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
                                            borderRadius: BorderRadius.all(
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
                                autoPlayInterval: Duration(seconds: 3),
                                autoPlayAnimationDuration: Duration(seconds: 3),
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
                    SizedBox(
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
                                child: defaultText(
                                  text: 'Cappuccino',
                                  color: cubit.currentIndex == 0 ? Colors.white : Colors.black,
                                ),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: cubit.currentIndex == 0 ? Colors.brown[400] : Colors.white)),
                            SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  cubit.switchButton(1);
                                },
                                child: defaultText(
                                  text: 'Cold Brew',
                                  color: cubit.currentIndex == 1 ? Colors.white : Colors.black,
                                ),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: cubit.currentIndex == 1 ? Colors.brown[400] : Colors.white)),
                            SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  cubit.switchButton(2);
                                },
                                child: defaultText(
                                  text: 'espresso',
                                  color: cubit.currentIndex == 2 ? Colors.white : Colors.black,
                                ),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: cubit.currentIndex == 2 ? Colors.brown[400] : Colors.white)),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 6,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 15,
                                  mainAxisSpacing: 12,
                                  childAspectRatio: .76),
                          itemBuilder: (context, index) => Card(
                            elevation: 8,
                            child: Container(
                              width: 120,
                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15)), color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 105,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                          color: Colors.orange),
                                    ),
                                    Spacer(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            defaultText(
                                                text: 'Cappuccino',
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight:
                                                    FontWeight.bold),
                                            defaultText(
                                                text: 'with low far drink',
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontWeight:
                                                    FontWeight.bold),
                                            SizedBox(
                                              height: 6,
                                            ),
                                            defaultText(
                                                text: '100 EGP',
                                                color: Colors.black,
                                                fontSize: 13,
                                                fontWeight:
                                                    FontWeight.bold),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10),
                                          child: CircleAvatar(
                                            radius: 15,
                                            backgroundColor:
                                                Colors.brown[400],
                                            child: Icon(Icons.add,
                                                color: Colors.white),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
