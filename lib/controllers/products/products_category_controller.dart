import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/products/products_category_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

final categoryProductsProvider = StateNotifierProvider<CategoryProductsController, CategoryProductsState>((ref) {
  return CategoryProductsController();
});

class CategoryProductsController extends StateNotifier<CategoryProductsState> {
  CategoryProductsController()
      : super(CategoryProductsState(
          categories: [],
          allProducts: [],
          filteredProducts: [],
          isLoading: true,
        )) {
    fetchCategories();
  }

  final String categoryUrl = dotenv.env['CATEGORY_URL'] ?? 'https://defaulturl.com/api';

  Future<void> fetchCategories() async {
    try {
      final response = await http.get(Uri.parse(categoryUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final sortedCategories = List.from(data)..sort((a, b) => a['productCategory'].compareTo(b['productCategory']));
        state = state.copyWith(
          categories: sortedCategories,
          allProducts: sortedCategories.expand((category) => category['products']).toList(),
          isLoading: false,
        );
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  void filterProducts(String query) {
    final searchQuery = query.toLowerCase();
    final filtered = state.allProducts.where((product) {
      final productName = product['productName'].toString().toLowerCase();
      final productPrice = product['productPrice'].toString().toLowerCase();
      final tags = (product['tags'] ?? []).map((tag) => tag.toString().toLowerCase());

      return productName.contains(searchQuery) ||
          productPrice.contains(searchQuery) ||
          tags.any((tag) => tag.contains(searchQuery));
    }).toList();
    state = state.copyWith(filteredProducts: filtered);
  }
}