// lib/screens/product_list_screen.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product {
  final String name;
  final double price;

  Product({required this.name, required this.price});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      price: json['price'],
    );
  }
}

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late Future<List<Product>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = fetchProducts();
  }

  Future<List<Product>> fetchProducts() async {
    final response1 = await http.get(Uri.parse('http://www.carrefour.com.ar/almacen:5000/api/products/page1'));
    final response2 = await http.get(Uri.parse('http://diaonline.supermercadosdia.com.ar/almacen:5000/api/products/page2'));
    final response3 = await http.get(Uri.parse('http://www.cotodigital3.com.ar/sitios/cdigi/browse/catalogo-almac%C3%A9n/_/N-8pub5zZ1uh5oniZyq0zf8/:5000/api/products/page3'));

    if (response1.statusCode == 200 && response2.statusCode == 200 && response3.statusCode == 200) {
      List<Product> products = [];
      products.addAll((jsonDecode(response1.body) as List).map((data) => Product.fromJson(data)).toList());
      products.addAll((jsonDecode(response2.body) as List).map((data) => Product.fromJson(data)).toList());
      products.addAll((jsonDecode(response3.body) as List).map((data) => Product.fromJson(data)).toList());
      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Productos'),
      ),
      body: FutureBuilder<List<Product>>(
        future: futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay productos disponibles'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final product = snapshot.data![index];
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text('\$${product.price}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
