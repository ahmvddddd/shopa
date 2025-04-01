import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'cart_products_controller.dart';

final removeFromCartProvider = Provider((ref) => RemoveFromCartController(ref));

class RemoveFromCartController {
  final Ref ref;
  final storage = const FlutterSecureStorage();

  RemoveFromCartController(this.ref);

  Future<void> removeFromCart(String productId) async {
    final token = await storage.read(key: 'token');
    if (token == null) return;

    final String removeFromCartUrl = dotenv.env['REMOVE_FROM_CART'] ?? 'https://defaulturl.com/api';

    try {
      final response = await http.post(
        Uri.parse(removeFromCartUrl),
        body: json.encode({"productId": productId}),
        headers: {
        'Authorization': 'Bearer $token', 
        'Content-Type': 'application/json'
        },
      );

      if (response.statusCode == 200) {
        ref.read(cartProductsProvider.notifier).fetchProducts();
      } else {
        print(response.body);
      }
    } catch (e) {
      throw Exception('Failed to remove item');
    }
  }
}
