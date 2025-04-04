import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../common/widgets/pop_up/custom_snackbar.dart';
import '../../models/cart/checkout_model.dart';
import '../../utils/constants/colors.dart';
import '../auth/userId_controller.dart';

final checkoutProvider = StateNotifierProvider<FetchProductController, CheckoutModel>((ref) {
  return FetchProductController();
});

class FetchProductController extends StateNotifier<CheckoutModel> {
  FetchProductController() : super(
    CheckoutModel(
      totalAmount: 0,
      cartItems: [],
      isLoading: true
    ));

  Future<void> fetchOrderTotal(BuildContext context) async {
    try {
      final String fetchOrderTotalUrl = dotenv.env['FETCH_ORDER_TOTAL'] ?? 'https://defaulturl.com/api';
    final userIdService = UserIdService();
    final String userId = await userIdService.getCurrentUserId() ?? '';

      final response = await http.get(Uri.parse('$fetchOrderTotalUrl$userId'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        state = state.copyWith(
          totalAmount: data['totalAmount'],
          cartItems: data['items'],
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
