import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateAndfinish(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);


  Color mainColor = Color.fromARGB(255, 198, 124, 78);

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
  bool isPassword = false,
  required Function validate,
  String? label,
  IconData? prefix,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
}) =>
    Container(
      height: 40,
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        obscureText: isPassword,
        enabled: isClickable,
        onFieldSubmitted: (s) {
          onSubmit!(s);
        },
        onChanged: (s) {
          if (onChange == null) {
            return;
          }
          onChange(s);
        },
        onTap: () {
          if (onTap == null) {
            return;
          }
          onTap();
        },
        validator: (s) {
          return validate(s);
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[200],
          labelText: label,
          suffixIcon: suffix != null
              ? IconButton(
                  onPressed: () {
                    suffixPressed!();
                  },
                  icon: Icon(suffix))
              : null,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              borderSide: BorderSide.none),
        ),
      ),
    );
Widget defaultButton(
        {double width = double.infinity,
        required Color background,
        bool isUpperCase = true,
        double radius = 20.0,
        required Function function,
        required String text}) =>
    Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius), color: background),
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );

Widget defaultTextButton({
  required Function function,
  required String text,
}) =>
    TextButton(
        onPressed: () {
          function();
        },
        child: Text(text.toUpperCase()));

void showToast({required String text, required ToastStates state}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

Widget defaultText(
        {required String text,
        required Color color,
         double? fontSize,
         FontWeight? fontWeight}) =>
    Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontFamily: 'Poppins'),
    );

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.yellow;
      break;
  }
  return color;
}
class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Remove any non-digit characters
    String newText = newValue.text.replaceAll(RegExp(r'\D'), '');

    // Add space every four digits
    if (newText.length > 4) {
      newText = newText.substring(0, 4) +
          ' ' +
          newText.substring(4, newText.length);
    }
    if (newText.length > 9) {
      newText = newText.substring(0, 9) +
          ' ' +
          newText.substring(9, newText.length);
    }
    if (newText.length > 14) {
      newText = newText.substring(0, 14) +
          ' ' +
          newText.substring(14, newText.length);
    }

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.fromPosition(
        TextPosition(offset: newText.length),
      ),
    );
  }
}

// CarouselSlider(
//                 items: model.data!.banners.map((e) => Image(
//                     image: NetworkImage('${e.image}'),
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                 )).toList()
//                 , options: CarouselOptions(
//                 height: 250.0,
//               initialPage: 0,
//               viewportFraction: 1.0,
//               enableInfiniteScroll: true,
//               reverse: false,
//               autoPlay: true,
//               autoPlayInterval: Duration(seconds: 3),
//               autoPlayAnimationDuration: Duration(seconds: 1),
//               autoPlayCurve: Curves.fastOutSlowIn,
//               scrollDirection: Axis.horizontal
//             )),
