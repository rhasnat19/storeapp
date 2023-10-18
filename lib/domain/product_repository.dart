import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:storeapp/presentation/splash_screen/splash_screen.dart';

class ProductRepository {
  ProductRepository();

  Future<List<dynamic>> fetchProducts(int page) async {
    try {
      //https://fakestoreapi.com/docs this link has limit api. not pagination.
      var response = await http
          .get(Uri.parse('https://fakestoreapi.com/products?limit=10'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<dynamic> fetchSingleProduct(int prodId) async {
    try {
      var response = await http
          .get(Uri.parse('https://fakestoreapi.com/products/$prodId'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      debugPrint(e.toString());
      return;
    }
  }
}
