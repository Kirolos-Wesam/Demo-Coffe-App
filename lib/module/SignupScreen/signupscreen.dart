import 'package:coffeeapp/layout/HomeScreen/homeScreen.dart';
import 'package:coffeeapp/module/SignupScreen/cubit/cubit.dart';
import 'package:coffeeapp/module/SignupScreen/cubit/state.dart';
import 'package:coffeeapp/shared/componets/constants.dart';
import 'package:coffeeapp/shared/network/local/cachehelper.dart';
import 'package:flutter/material.dart';
import 'package:coffeeapp/shared/componets/componets.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var cubit = SignupCubit.get(context);
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if(state is SignupErrorState){
          showToast(text: 'The email address is already existed', state: ToastStates.ERROR);
        }
        if (state is CreateUserSuccessState) {
          CacheHelper.saveData(key: 'uID', value: state.uID).then((value) {
            uID = state.uID;
            navigateAndfinish(context, HomeScreen());
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'SIGN UP',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text('Complete this step for best adjustment',
                        style: TextStyle(color: Colors.grey[700])),
                    const SizedBox(
                      height: 20,
                    ),
                    Text('Your Name',
                        style: TextStyle(color: Colors.grey[700])),
                    const SizedBox(
                      height: 7,
                    ),
                    defaultFormField(
                        controller: nameController,
                        type: TextInputType.name,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Your Name';
                          }
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    Text('Your Email',
                        style: TextStyle(
                          color: Colors.grey[700],
                        )),
                    const SizedBox(
                      height: 7,
                    ),
                    defaultFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Your E-mail';
                          }
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    Text('Your Mobile Number',
                        style: TextStyle(
                          color: Colors.grey[700],
                        )),
                    const SizedBox(
                      height: 7,
                    ),
                    defaultFormField(
                        controller: phoneController,
                        type: TextInputType.number,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Your Mobile';
                          }
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    Text('Your Address',
                        style: TextStyle(
                          color: Colors.grey[700],
                        )),
                    const SizedBox(
                      height: 7,
                    ),
                    defaultFormField(
                        controller: addressController,
                        type: TextInputType.streetAddress,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Your Address';
                          }
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    Text('Your Password',
                        style: TextStyle(
                          color: Colors.grey[700],
                        )),
                    const SizedBox(
                      height: 7,
                    ),
                    defaultFormField(
                        controller: passwordController,

                        type: TextInputType.streetAddress,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Your Password';
                          }
                        }, 
                        isPassword: cubit.isPassword,
                      suffixPressed: () {
                        cubit.changePasswordVisibility();
                      },
                      suffix: cubit.suffix
                        ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Transform.scale(
                            scale: .6,
                            child: Container(
                                width: 20,
                                child: Switch(
                                  activeColor: mainColor,
                                  value: SignupCubit.get(context).switchButton,
                                  onChanged: (value) {
                                    SignupCubit.get(context)
                                        .changeSwitchButton();
                                  },
                                ))),
                        const SizedBox(
                          width: 10,
                        ),
                        Text('I accepted all tearms & conditions',
                            style: TextStyle(
                              color: Colors.grey[700],
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    if(state is SignuploadingState)
                    Center(child: CircularProgressIndicator(color: mainColor,),)
                    else
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: cubit.switchButton == false ? null : (){
                            if (formKey.currentState!.validate()) {
                              SignupCubit.get(context).signUp(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  address: addressController.text);
                            }
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: mainColor),
                          child: defaultText(
                              text: 'SIGN UP',
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('I already have account',
                            style: TextStyle(
                              color: Colors.grey[700],
                            )),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Sign In',
                              style: TextStyle(color: mainColor),
                            )) 
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
