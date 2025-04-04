import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shopa/utils/constants/colors.dart';
import '../../common/widgets/pop_up/custom_snackbar.dart';
import 'cart_products_controller.dart';

final removeFromCartProvider = Provider((ref) => RemoveFromCartController(ref));

class RemoveFromCartController {
  final Ref ref;
  final storage = const FlutterSecureStorage();

  RemoveFromCartController(this.ref);

  Future<void> removeFromCart(BuildContext context, String productId) async {
    final token = await storage.read(key: 'token');
    if (token == null) return;

    final String removeFromCartUrl = dotenv.env['REMOVE_FROM_CART'] ?? 'https://defaulturl.com/api';

    try {
      final response = await http.delete(
        Uri.parse('$removeFromCartUrl$productId'),
        headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', 
        },
      );

      if (response.statusCode == 200) {
        ref.read(cartProductsProvider.notifier).fetchProducts(context);
       CustomSnackbar.show(
        context: context,
        title: 'Cart item removed',
        message: 'An item has been removed from your cart',
        backgroundColor: TColors.success,
        icon: Icons.check
       );
      } else {
       CustomSnackbar.show(
        context: context,
        title: 'An error occured',
        message: 'The item could not be removed from your cart. Try again later',
        backgroundColor: TColors.error,
        icon: Icons.cancel
       );
      }
    } catch (e) {
      CustomSnackbar.show(
        context: context,
        title: 'An error occured',
        message: 'The item could not be removed from your cart. Try again later',
        backgroundColor: TColors.error,
        icon: Icons.cancel
       );
    }
  }
}
