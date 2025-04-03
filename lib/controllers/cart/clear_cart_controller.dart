import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'cart_products_controller.dart';

final clearCartProvider = Provider((ref) => ClearCartController(ref));

class ClearCartController {
  final Ref ref;

  ClearCartController(this.ref);

  final FlutterSecureStorage storage = FlutterSecureStorage();

  Future<void> clearCart() async {
    final String clearCartUrl = dotenv.env['CLEAR_CART'] ?? 'https://defaulturl.com/api';
    final token = await storage.read(key: 'token');

    try {
      final response = await http.delete(
        Uri.parse(clearCartUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer: $token'
          },
      );

      if (response.statusCode == 200) {
        ref.read(cartProductsProvider.notifier).fetchProducts();
      } else {
        // throw Exception('Failed to clear cart');
        print(response.body);
      }
    } catch (e) {
      throw Exception('Failed to clear cart');
    }
  }
}
