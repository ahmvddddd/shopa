import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../common/widgets/pop_up/custom_snackbar.dart';
import '../../nav_menu.dart';
import '../../utils/constants/colors.dart';

final deleteProductProvider = Provider((ref) => DeleteProductController());
final String deleteProductUrl = dotenv.env['DELETE_PRODUCT_URL'] ?? 'https://defaulturl.com/api';

class DeleteProductController {
  Future<void> deleteProduct(BuildContext context, String productId) async {
    try {
    final response = await http.delete(
      Uri.parse('$deleteProductUrl$productId'),
    );
    if (response.statusCode == 200) {
        CustomSnackbar.show(
        context: context,
        title: 'Success',
        message: 'Product deleted successfully',
        backgroundColor: TColors.success,
        icon: Icons.check
       );
      Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) =>
                      NavigationMenu()
            ),
          );
    } else {
       CustomSnackbar.show(
        context: context,
        title: 'An error occured',
        message: 'Could not delete this product',
        backgroundColor: TColors.error,
        icon: Icons.cancel
       );
    }
    } catch (e) {
       CustomSnackbar.show(
        context: context,
        title: 'An error occured',
        message: 'Could not delete this product',
        backgroundColor: TColors.error,
        icon: Icons.cancel
       );
    }
  }
}