import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../models/cart/cart_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../auth/userId_controller.dart';



final cartProductsProvider = StateNotifierProvider<FetchProductController, CartModel>((ref) {
  return FetchProductController();
});

class FetchProductController extends StateNotifier<CartModel> {
  FetchProductController() : super(
    CartModel(
      cartItems: [],
      isLoading: true
    )) {
    fetchProducts();
  }

  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<void> fetchProducts() async {
    final userIdService = UserIdService();
    final String userId = await userIdService.getCurrentUserId() ?? '';    
    final token = await storage.read(key: 'token');
    if (token == null) return;
    try {
      final String fetchCartProductsUrl = dotenv.env['FETCH_CART_PRODUCTS'] ?? 'https://defaulturl.com/api';

      final response = await http.get(
        Uri.parse('$fetchCartProductsUrl$userId'),
        headers: {
          'Content-Type': 'application/json',
          },
        );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        state = state.copyWith(
          cartItems: data,
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