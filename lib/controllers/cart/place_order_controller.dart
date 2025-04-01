import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../screens/payment/payment_screen.dart';
import '../auth/userId_controller.dart';

final placeOrderProvider = Provider((ref) => AddToCartController());

class AddToCartController {
  Future<void> placeOrder( BuildContext context, List<dynamic> products, double totalAmount) async {
    try {
      final String placeOrderUrl = dotenv.env['PLACE_ORDER'] ?? 'https://defaulturl.com/api';
    final userIdService = UserIdService();
    final String userId = await userIdService.getCurrentUserId() ?? '';
      
      final response = await http.post(
        Uri.parse(placeOrderUrl),
        body: json.encode({
          "userId": userId,
          "products": products,
          "totalAmount": totalAmount,
          "deliveryStatus": "pending",
        }),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Your order has been placed. Proceed to payment page',
            ),
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => PaymentScreen(
                  products: products,
                  totalAmount: totalAmount,
                ),
          ),
        );
      } else {
        print(response.body);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}


 