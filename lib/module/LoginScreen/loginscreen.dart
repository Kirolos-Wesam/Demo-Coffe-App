import 'package:coffeeapp/layout/HomeScreen/homeScreen.dart';
import 'package:coffeeapp/module/LoginScreen/cubit/cubit.dart';
import 'package:coffeeapp/module/LoginScreen/cubit/state.dart';
import 'package:coffeeapp/module/SignupScreen/signupscreen.dart';
import 'package:coffeeapp/shared/componets/componets.dart';
import 'package:coffeeapp/shared/componets/constants.dart';
import 'package:coffeeapp/shared/network/local/cachehelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginErrorState) {
          showToast(
              text: 'Invalid Email or Password', state: ToastStates.ERROR);
        }
        if (state is LoginSuccessState) {
          if (LoginCubit.get(context).switchButton) {
            print(LoginCubit.get(context).switchButton);
            CacheHelper.saveData(key: 'uID', value: state.uID).then((value) {
              print(CacheHelper.getData(key: 'uID'));
              uID = state.uID;
              navigateAndfinish(context, HomeScreen());
              print(value);
            });
          }
          navigateAndfinish(context, HomeScreen());
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'SIGN IN',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text('Complete this step for best adjustment',
                      style: TextStyle(color: Colors.grey[700])),
                  const SizedBox(
                    height: 50,
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
                      validate: () {}),
                  const SizedBox(
                    height: 30,
                  ),
                  Text('Password',
                      style: TextStyle(
                        color: Colors.grey[700],
                      )),
                  const SizedBox(
                    height: 7,
                  ),
                  defaultFormField(
                      controller: passwordController,
                      type: TextInputType.visiblePassword,
                      validate: () {},
                      isPassword: LoginCubit.get(context).isPassword,
                      suffixPressed: () {
                        LoginCubit.get(context).changePasswordVisibility();
                      },
                      suffix: LoginCubit.get(context).suffix),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Transform.scale(
                          scale: .6,
                          child: Container(
                              width: 20,
                              child: Switch(
                                value: LoginCubit.get(context).switchButton,
                                onChanged: (value) {
                                  LoginCubit.get(context)
                                      .changeSwitchButton(value);
                                },
                              ))),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Remember Me',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const Spacer(),
                      TextButton(
                          onPressed: () {},
                          child: const Text('Forget Password ?'))
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultButton(
                      function: () {
                        LoginCubit.get(context).signIn(
                            email: emailController.text,
                            password: passwordController.text);
                      },
                      text: 'Sign in',
                      background: Colors.brown),
                  const SizedBox(
                    height: 60,
                  ),
                  defaultButton(
                      background: Colors.blueAccent,
                      function: () {},
                      text: 'Sign in with Facebook'),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Dont have a account ?',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      TextButton(
                          onPressed: () {
                            navigateTo(context, SignupScreen());
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(fontSize: 15),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
