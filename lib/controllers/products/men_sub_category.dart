// ignore_for_file: avoid_print

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final menProductsProvider = StateNotifierProvider<MenProductsController, List<Product>>(
  (ref) => MenProductsController(),
);

class MenProductsController extends StateNotifier<List<Product>> {
  MenProductsController() : super([]) {
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      String tag ='for you';
      final response = await http.get(Uri.parse('http://localhost:3000/api/tag/$tag'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        state = data.map((item) => Product.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print('Error fetching products: $e');
    }
  }
}

class Product {
  final String id;
  final String productId;
  final String name;
  final double price;
  final String imageUrl;

  Product({
    required this.id,
    required this.productId,
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      productId:  json['productId'],
      name: json['productName'],
      price: json['productPrice'].toDouble(),
      imageUrl: 'data:image/png;base64,${base64Encode(List<int>.from(json['productImages'][0]))}',
    );
  }
}
