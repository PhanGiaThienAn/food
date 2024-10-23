import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product_model.dart';

class SharedPrefs {
  static const String keyProducts = 'products';

  Future<List<Product>> getProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString(keyProducts);
    if (data == null) return [];

    List<dynamic> jsonList = json.decode(data);
    return jsonList.map((json) => Product.fromJson(json)).toList();
  }

  Future<void> saveProducts(List<Product> products) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonList = json.encode(products.map((product) => product.toJson()).toList());
    prefs.setString(keyProducts, jsonList);
  }
}
