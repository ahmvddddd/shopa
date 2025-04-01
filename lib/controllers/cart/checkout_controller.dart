import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../models/cart/checkout_model.dart';
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
    )) {
    fetchOrderTotal();
  }

  Future<void> fetchOrderTotal() async {
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
        print(response.body);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
