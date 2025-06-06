import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../common/widgets/pop_up/custom_snackbar.dart';
import '../../screens/payment/payment_screen.dart';
import '../../utils/constants/colors.dart';
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

      if (response.statusCode == 200) {
        CustomSnackbar.show(
        context: context,
        title: 'Success',
        message: 'Your order has been placed. Proceed to payment page',
        backgroundColor: TColors.success,
        icon: Icons.check
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
      } else if (response.statusCode == 201) {
        CustomSnackbar.show(
        context: context,
        title: 'Success',
        message: 'Your order has been placed. Proceed to payment page',
        backgroundColor: TColors.success,
        icon: Icons.check
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
      }
      else {
       CustomSnackbar.show(
        context: context,
        title: 'An error occured',
        message: 'Could not place order. Try again later',
        backgroundColor: TColors.error,
        icon: Icons.cancel
       );
      }
    } catch (e) {
       CustomSnackbar.show(
        context: context,
        title: 'An error occured',
        message: 'Could not place order. Try again later',
        backgroundColor: TColors.error,
        icon: Icons.cancel
       );
    }
  }
}


 