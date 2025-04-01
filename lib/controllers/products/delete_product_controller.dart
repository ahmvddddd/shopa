import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../nav_menu.dart';

final deleteProductProvider = Provider((ref) => DeleteProductController());
final String deleteProductUrl = dotenv.env['DELETE_PRODUCT_URL'] ?? 'https://defaulturl.com/api';

class DeleteProductController {
  Future<void> deleteProduct(BuildContext context, String productId) async {
    final response = await http.delete(
      Uri.parse('$deleteProductUrl$productId'),
    );
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product deleted successfully')),
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response.body)),
      );
    }
  }
}