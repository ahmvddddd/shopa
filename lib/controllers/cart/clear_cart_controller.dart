import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'cart_products_controller.dart';
import '../auth/userId_controller.dart';

final clearCartProvider = Provider((ref) => ClearCartController(ref));

class ClearCartController {
  final Ref ref;

  ClearCartController(this.ref);

  Future<void> clearCart() async {
    final userIdService = UserIdService();
    final String userId = await userIdService.getCurrentUserId() ?? '';
    final String clearCartUrl = dotenv.env['CLEAR_CART'] ?? 'https://defaulturl.com/api';

    try {
      final response = await http.post(
        Uri.parse(clearCartUrl),
        body: json.encode({"userId": userId}),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        ref.read(cartProductsProvider.notifier).fetchProducts();
      } else {
        throw Exception('Failed to clear cart');
      }
    } catch (e) {
      throw Exception('Failed to clear cart');
    }
  }
}
