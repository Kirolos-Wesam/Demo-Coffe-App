import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffeeapp/layout/HomeScreen/cubit/home_screen_cubit.dart';
import 'package:coffeeapp/module/ProfileScreen/cubit/profile_screen_cubit.dart';
import 'package:coffeeapp/module/paymentScreen/cubit/payment_method_cubit.dart';
import 'package:coffeeapp/module/paymentScreen/paymentmethodscreen.dart';
import 'package:coffeeapp/module/profilesettingScreen/profilesettingscreen.dart';
import 'package:coffeeapp/shared/componets/componets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          color: Colors.grey[100],
          child: Padding(
            padding: const EdgeInsets.only(top: 125, left: 15, right: 15, bottom: 10),
            child: HomeCubit.get(context).user == null
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: CachedNetworkImageProvider(
                          HomeCubit.get(context).user!.image!,
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      defaultText(
                          text: HomeCubit.get(context).user!.name!,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                      defaultText(
                          text: HomeCubit.get(context).user!.email!,
                          color: Colors.grey),
                      const SizedBox(
                        height: 30,
                      ),
                      MaterialButton(
                        onPressed: () {
                          navigateTo(context, ProfileSetting(image: HomeCubit.get(context).user!.image!
                          , name: HomeCubit.get(context).user!.name!
                          , email: HomeCubit.get(context).user!.email!
                          , phone: HomeCubit.get(context).user!.phone!
                          , address: HomeCubit.get(context).user!.address!));

                          
                        },
                        minWidth: double.infinity,
                        height: 60,
                        color: Colors.white,
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: Row(
                          children: [
                            Icon(Icons.person, color: Colors.grey[700],),
                            const SizedBox(width: 10,),
                            defaultText(
                                text: 'Profile',
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.bold)
                          ],
                        ),
                      ),
                      const SizedBox(height: 15,),
                      MaterialButton(
                        onPressed: () {
                          navigateTo(context, PaymentMethodScreen());
                          PaymentMethodCubit.get(context).getPamyentCard();
                        },
                        minWidth: double.infinity,
                        height: 60,
                        color: Colors.white,
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: Row(
                          children: [
                            Icon(Icons.account_balance_wallet_outlined, color: Colors.grey[700],),
                            const SizedBox(width: 10,),
                            defaultText(
                                text: 'Payment Methods',
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.bold)
                          ],
                        ),
                      ),
                      const SizedBox(height: 15,),
                      MaterialButton(
                        onPressed: () {},
                        minWidth: double.infinity,
                        height: 60,
                        color: Colors.white,
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: Row(
                          children: [
                            Icon(Icons.insert_drive_file_outlined, color: Colors.grey[700],),
                            const SizedBox(width: 10,),
                            defaultText(
                                text: 'Order History',
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.bold)
                          ],
                        ),
                      ),
                      const SizedBox(height: 15,),
                      MaterialButton(
                        onPressed: () {},
                        minWidth: double.infinity,
                        height: 60,
                        color: Colors.white,
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: Row(
                          children: [
                            Icon(Icons.question_mark_outlined, color: Colors.grey[700],),
                            const SizedBox(width: 10,),
                            defaultText(
                                text: 'FAQ',
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.bold)
                          ],
                        ),
                      ),
                      const SizedBox(height: 15,),
                      MaterialButton(
                        onPressed: () {},
                        minWidth: double.infinity,
                        height: 60,
                        color: Colors.white,
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: Row(
                          children: [
                            Icon(Icons.handshake, color: Colors.grey[700],),
                            const SizedBox(width: 10,),
                            defaultText(
                                text: 'Legal Policy',
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.bold)
                          ],
                        ),
                      ),
                      Expanded(child: Container()),
                      SizedBox(
                        width: double.infinity,
                        child: TextButton(onPressed: (){}, child: defaultText(text: 'Log Out', color: mainColor, fontSize: 17, fontWeight: FontWeight.bold)))
                    ],
                  ),
          ),
        );
      },
    );
  }
}
