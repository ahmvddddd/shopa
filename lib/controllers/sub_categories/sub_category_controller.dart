import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../models/products/sub_category_model.dart';

final fetchProductProvider = StateNotifierProvider<FetchProductController, SubCategoryModel>((ref) {
  return FetchProductController();
});

class FetchProductController extends StateNotifier<SubCategoryModel> {
  FetchProductController() : super(
    SubCategoryModel(
      products: [],
      isLoading: true
    ));

  Future<void> fetchProducts(String tag) async {
    try {
      final String productsTagUrl = dotenv.env['PRODUCTS_TAG_URL'] ?? 'https://defaulturl.com/api';

      final response = await http.get(Uri.parse('$productsTagUrl$tag'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        state = state.copyWith(
          products: data,
          isLoading: false
        );
      } else {
        print('Could not load products');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
