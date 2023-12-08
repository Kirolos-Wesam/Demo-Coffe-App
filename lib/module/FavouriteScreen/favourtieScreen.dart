import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffeeapp/model/favoriteModel.dart';
import 'package:coffeeapp/module/FavouriteScreen/cubit/favourtie_screen_cubit.dart';
import 'package:coffeeapp/module/productInfoScreen/cubit/product_info_cubit.dart';
import 'package:coffeeapp/module/productInfoScreen/productinfoscreen.dart';
import 'package:coffeeapp/shared/componets/componets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoriteCubit, FavoriteState>(
      listener: (context, state) {
        if(state is RemoveFavoriteSuccessState){
          FavoriteCubit.get(context).getFavorites();
        }
      },
      builder: (context, state) {
        var cubit = FavoriteCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Center(
                child: Row(
              children: [
                defaultText(text: 'Favorite', color: Colors.black),
                Spacer(),
                CircleAvatar(
                  backgroundColor: Colors.grey[50],
                  radius: 20,
                  child: Icon(Icons.favorite, color: mainColor),
                )
              ],
            )),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (state is GetFavoriteLoadingState)
                    LinearProgressIndicator(minHeight: 2, color: mainColor,),
                  if(state is GetFavoriteSuccessState)
                  if(cubit.favorites!.isEmpty)
                  Center(child: defaultText(text: 'No Favorite inserted', color: Colors.black))
                  else
                    Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: GridView.count(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          crossAxisSpacing: 9,
                          mainAxisSpacing: 14,
                          childAspectRatio: .79,
                          children: List.generate(
                              cubit.favorites!.length,
                              (index) =>
                                  products(cubit.favorites!, index, context)),
                        )), 
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget products(List<FavoriteModel> products, index, context) => Card(
        elevation: 8,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Colors.grey[100]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 105,
                  child: InkWell(
                    onTap: () {
                      ProductInfoCubit.get(context).isFavorite = true;
                      navigateTo(
                          context,
                          ProductInfo(
                              productId: products[index].productId!,
                              coffeeName: products[index].productName!,
                              title: products[index].title!,
                              description: products[index].description!,
                              categoryId: products[index].categoryId!,
                              image: products[index].profileImage!,
                              price: products[index].price!,
                              rate: 4.6, showOrder: true,));
                    },
                    child: CachedNetworkImage(
                        imageUrl: products[index].profileImage!,
                        imageBuilder: (context, imageProvider) {
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover)),
                          );
                        }),
                  ),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          ProductInfoCubit.get(context).isFavorite = true;
                          navigateTo(
                              context,
                              ProductInfo(
                                showOrder: true,
                                  productId: products[index].productId!,
                                  coffeeName: products[index].productName!,
                                  title: products[index].title!,
                                  description: products[index].description!,
                                  categoryId: products[index].categoryId!,
                                  image: products[index].profileImage!,
                                  price: products[index].price!,
                                  rate: 4.6));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            defaultText(
                                text: products[index].productName!,
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                            defaultText(
                                text: products[index].title!,
                                color: Colors.black,
                                fontSize: 9,
                                fontWeight: FontWeight.bold),
                            SizedBox(
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
                          FavoriteCubit.get(context).removeFavorites(productId: products[index].productId!);
                        },
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.white,
                          child: Icon(FavoriteCubit.get(context).checkedIcon[index]== true ? Icons.favorite : Icons.favorite_border, color: mainColor),
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
