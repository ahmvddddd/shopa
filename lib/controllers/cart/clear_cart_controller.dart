import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../common/widgets/pop_up/custom_snackbar.dart';
import '../../utils/constants/colors.dart';
import 'cart_products_controller.dart';

final clearCartProvider = Provider((ref) => ClearCartController(ref));

class ClearCartController {
  final Ref ref;

  ClearCartController(this.ref);

  final FlutterSecureStorage storage = FlutterSecureStorage();

  Future<void> clearCart(BuildContext context) async {
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
        ref.read(cartProductsProvider.notifier).fetchProducts(context);
        CustomSnackbar.show(
        context: context,
        title: 'Cart is now empty',
        message: 'All items have been removed from cart',
        backgroundColor: TColors.success,
        icon: Icons.check
       );
      } else {
       CustomSnackbar.show(
        context: context,
        title: 'An error occured',
        message: 'Could not clear your cart. Try again later',
        backgroundColor: TColors.error,
        icon: Icons.cancel
       );
      }
    } catch (e) {
       CustomSnackbar.show(
        context: context,
        title: 'An error occured',
        message: 'Could not clear your cart. Try again later',
        backgroundColor: TColors.error,
        icon: Icons.cancel
       );
    }
  }
}
