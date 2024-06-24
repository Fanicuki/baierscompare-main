// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ApiService {
  static const String baseUrl = 'http://tu-api-url:5000/api/products';

  Future<List<Product>> fetchProducts() async {
    List<Product> products = [];
    final response1 = await http.get(Uri.parse('$baseUrl/page1'));
    final response2 = await http.get(Uri.parse('$baseUrl/page2'));
    final response3 = await http.get(Uri.parse('$baseUrl/page3'));

    if (response1.statusCode == 200) {
      List<dynamic> data = jsonDecode(response1.body);
      products.addAll(data.map((item) => Product.fromJson(item)).toList());
    }
    if (response2.statusCode == 200) {
      List<dynamic> data = jsonDecode(response2.body);
      products.addAll(data.map((item) => Product.fromJson(item)).toList());
    }
    if (response3.statusCode == 200) {
      List<dynamic> data = jsonDecode(response3.body);
      products.addAll(data.map((item) => Product.fromJson(item)).toList());
    }

    return products;
  }
}
