import 'package:coffeeapp/layout/HomeScreen/cubit/home_screen_cubit.dart';
import 'package:coffeeapp/layout/HomeScreen/homeScreen.dart';
import 'package:coffeeapp/module/FavouriteScreen/cubit/favourtie_screen_cubit.dart';
import 'package:coffeeapp/module/LoginScreen/cubit/cubit.dart';
import 'package:coffeeapp/module/LoginScreen/loginscreen.dart';
import 'package:coffeeapp/module/OrderScreen/cubit/order_screen_cubit.dart';
import 'package:coffeeapp/module/ProductScreen/cubit/products_screen_cubit.dart';
import 'package:coffeeapp/module/ProfileScreen/cubit/profile_screen_cubit.dart';
import 'package:coffeeapp/module/SignupScreen/cubit/cubit.dart';
import 'package:coffeeapp/shared/componets/constants.dart';
import 'package:coffeeapp/shared/network/local/cachehelper.dart';
import 'package:coffeeapp/shared/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  Widget? widget;

  if(CacheHelper.getData(key: 'uID') != null){
    uID = CacheHelper.getData(key: 'uID');
    print(uID);
    widget = HomeScreen();
  }
  else
  widget = LoginScreen();

  runApp(MyApp(startWidget: widget,));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
   MyApp({super.key, required this.startWidget});

   final Widget startWidget;

   //Color mainColor = const Color(0x00c67c4e);

   Color mainColor = const Color.fromARGB(1, 198, 124, 78);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context)=> SignupCubit()),
        BlocProvider(create: (context)=> HomeCubit()),
        BlocProvider(create: (context)=> ProductsCubit()..getImage()..getProducts()),
        BlocProvider(create: (context)=> FavoriteCubit()),
        BlocProvider(create: (context)=> OrderCubit()),
        BlocProvider(create: (context)=> ProfileCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: light,
        home: HomeScreen(),
      ),
    );
  }
}
class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('onClose -- ${bloc.runtimeType}');
  }
}



