import 'package:coffeeapp/model/ordermodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{
  static late SharedPreferences sharedPreferences;
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }
  static Future<bool> putBoolean({
    required String key,
    required bool value
  })async {
    return await sharedPreferences.setBool(key, value);
  }

  static dynamic getData({
    required String key
  }){
    return sharedPreferences.get(key);
  }

  static Future<bool> saveData({
    required String key,
    required dynamic value
  }) async {
    if(value is String) return await sharedPreferences.setString(key, value);
    if(value is int) return await sharedPreferences.setInt(key, value);
    if(value is bool) return await sharedPreferences.setBool(key, value);

    return await sharedPreferences.setDouble(key, value);
  }

//  static Future<void> saveListToSharedPreferences({required String key ,required List<OrderModel> dataList}) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   List<String> jsonList = dataList.map((model) => model.toJson()).toList();
//   prefs.setStringList(key, jsonList);
// }

// static Future<List<OrderModel>> getListFromSharedPreferences({required String key}) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   List<String>? jsonList = prefs.getStringList(key);
//   if (jsonList == null) {
//     return [];
//   }

//   List<OrderModel> modelList = jsonList.map((json) => OrderModel.FromJson(json)).toList();
//   return modelList;
// }

  static Future<bool> removeData({
    required String key
  }) async{
    return await sharedPreferences.remove(key);
  }
}