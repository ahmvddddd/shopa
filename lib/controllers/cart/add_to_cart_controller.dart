import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../common/widgets/pop_up/custom_snackbar.dart';
import '../../utils/constants/colors.dart';

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
        CustomSnackbar.show(
        context: context,
        title: 'Added to cart',
        message: 'You have added one item to your cart',
        backgroundColor: TColors.success,
        icon: Icons.check
       );
      } else {
       CustomSnackbar.show(
        context: context,
        title: 'An error occured',
        message: 'Could not add item to cart. Try again later',
        backgroundColor: TColors.error,
        icon: Icons.cancel
       );
      }
    } catch (e) {
       CustomSnackbar.show(
        context: context,
        title: 'An error occured',
        message: 'Could not add item to cart. Try again later',
        backgroundColor: TColors.error,
        icon: Icons.cancel
       );
    }
  }
}


 