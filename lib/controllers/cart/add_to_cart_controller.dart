import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final addToCartProvider = Provider((ref) => AddToCartController());

class AddToCartController {
  Future<void> addToCart(BuildContext context, String userId, String productId, String productName, double productPrice) async {
    try {
      final String addToCartUrl = dotenv.env['ADD_TO_CART'] ?? 'https://defaulturl.com/api';
      
      final response = await http.post(
        Uri.parse(addToCartUrl),
        body: json.encode({
          "userId": userId,
          "productId": productId,
          "productName": productName,
          "productPrice": productPrice,
          "quantity": 1,
        }),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Item added to cart')),
        );
      } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not add item to cart. Try again')),
      );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not add item to cart. Try again')),
      );
    }
  }
}


 