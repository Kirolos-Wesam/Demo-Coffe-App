// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffeeapp/layout/HomeScreen/cubit/home_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:coffeeapp/module/profilesettingScreen/cubit/profile_setting_cubit.dart';
import 'package:coffeeapp/shared/componets/componets.dart';

// ignore: must_be_immutable
class ProfileSetting extends StatelessWidget {
   String image;
   String name;
   String email;
   String phone;
   String address;

   var nameController = TextEditingController();
   var emailController = TextEditingController();
   var phoneController = TextEditingController();
   var addressController = TextEditingController();
  
  

   ProfileSetting({
    Key? key,
    required this.image,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    nameController.text = name;
    emailController.text = email;
    phoneController.text = phone;
    addressController.text = address;
    return BlocConsumer<ProfileSettingCubit, ProfileSettingState>(
      listener: (context, state) {
        if(state is UpdateUserSuccessState){
          showToast(text: 'Updated Successfully', state: ToastStates.SUCCESS);
          HomeCubit.get(context).getProfile();
        }
      },
      builder: (context, state) {
        var cubit = ProfileSettingCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            backgroundColor: Colors.grey[100],
            leading: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: InkWell(
                onTap: () {
                   Navigator.pop(context);
                   HomeCubit.get(context).getProfile();
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
                child: defaultText(text: 'Profile', color: Colors.black)),
            actions: [
              
              SizedBox(
                width: 50,
                child: MaterialButton(
                  onPressed: () {
                    if(nameController.text != name || emailController.text != email || phoneController.text != phone || addressController.text != address || cubit.profileImage != null){
                      cubit.uploadProfileImageAndUpdateAccount(name: nameController.text
                      , email: emailController.text
                      , phone: phoneController.text, address: addressController.text, image: image);
                      
                    }
                  },
                  height: 40,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  color: mainColor,
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if(state is UpdateUserLoadingState)
                  LinearProgressIndicator(color: mainColor, minHeight: 3,),
                  Align(
                      alignment: Alignment.topLeft,
                      child: defaultText(
                          text: 'Photo',
                          color: Colors.grey,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 30,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: cubit.profileImage == null ?  CachedNetworkImageProvider(image) as  ImageProvider : FileImage(cubit.profileImage!),
                          radius: 55,
                        ),
                        TextButton(onPressed: (){
                          cubit.getProfileImage();
                        }, child: defaultText(text: 'Upload Photo', color: mainColor))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      defaultText(text: 'Name:', color: Colors.grey, fontSize: 16, fontWeight: FontWeight.bold),
                      const SizedBox(width: 20,),
                      Expanded(child: TextField(
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                        hintText: 'Name',
                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: mainColor))
                      ),))
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      defaultText(text: 'Email:', color: Colors.grey, fontSize: 16, fontWeight: FontWeight.bold),
                      const SizedBox(width: 20,),
                      Expanded(child: TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                        hintText: 'Email',
                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: mainColor))
                      ),))
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      defaultText(text: 'Phone:', color: Colors.grey, fontSize: 16, fontWeight: FontWeight.bold),
                      const SizedBox(width: 20,),
                      Expanded(child: TextField(
                        controller: phoneController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                        hintText: 'phone',
                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: mainColor))
                      ),))
                    ],
                  ),
                   const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      defaultText(text: 'Address:', color: Colors.grey, fontSize: 16, fontWeight: FontWeight.bold),
                      const SizedBox(width: 10,),
                      Expanded(child: TextField(
                        controller: addressController,
                        keyboardType: TextInputType.streetAddress,
                        decoration: InputDecoration(
                        hintText: 'Address',
                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: mainColor))
                      ),))
                    ],
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
