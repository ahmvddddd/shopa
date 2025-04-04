import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../common/widgets/pop_up/custom_snackbar.dart';
import '../../models/cart/cart_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../utils/constants/colors.dart';


final cartProductsProvider = StateNotifierProvider<FetchProductController, CartModel>((ref) {
  return FetchProductController();
});

class FetchProductController extends StateNotifier<CartModel> {
  FetchProductController() : super(
    CartModel(
      cartItems: [],
      isLoading: true
    ));

  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<void> fetchProducts(BuildContext context) async {   
    final token = await storage.read(key: 'token');
    if (token == null) return;
    try {
      final String fetchCartProductsUrl = dotenv.env['FETCH_CART_PRODUCTS'] ?? 'https://defaulturl.com/api';

      final response = await http.get(
        Uri.parse(fetchCartProductsUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          },
        );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        state = state.copyWith(
          cartItems: data,
          isLoading: false
        );
      } else {
       CustomSnackbar.show(
        context: context,
        title: 'An error occured',
        message: 'Could not load cart items. Try again later',
        backgroundColor: TColors.error,
        icon: Icons.cancel
       );
      }
    } catch (e) {
       CustomSnackbar.show(
        context: context,
        title: 'An error occured',
        message: 'Could not load cart items. Try again later',
        backgroundColor: TColors.error,
        icon: Icons.cancel
       );
    }
  }
}