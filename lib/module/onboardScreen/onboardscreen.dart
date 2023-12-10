import 'package:coffeeapp/module/LoginScreen/loginscreen.dart';
import 'package:coffeeapp/shared/componets/componets.dart';
import 'package:coffeeapp/shared/network/local/cachehelper.dart';
import 'package:flutter/material.dart';

class OnboardScreen extends StatelessWidget {
  const OnboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image.asset('assets/images/onboard.jpg',
              height: double.infinity, fit: BoxFit.cover),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 45),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Coffee so good, your taste buds will love it.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'The best grain, the finest roast, the powerful flavor',
                  style: TextStyle(color: Colors.grey, fontFamily: 'Poppins'),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 85,)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                  onPressed: () {
                    CacheHelper.saveData(key: 'onBoard', value: true).then((value) {
                      navigateAndfinish(context, LoginScreen());
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainColor
                  ),
                  child: defaultText(
                      text: 'Get Started',
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
            ),
          )
        ],
      ),
    );
  }
}
