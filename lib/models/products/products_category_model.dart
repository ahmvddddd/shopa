

class CategoryProductsState {
  final List<dynamic> categories;
  final List<dynamic> allProducts;
  final List<dynamic> filteredProducts;
  final bool isLoading;
  
  CategoryProductsState({
    required this.categories,
    required this.allProducts,
    required this.filteredProducts,
    required this.isLoading,
  });

  CategoryProductsState copyWith({
    List<dynamic>? categories,
    List<dynamic>? allProducts,
    List<dynamic>? filteredProducts,
    bool? isLoading,
  }) {
    return CategoryProductsState(
      categories: categories ?? this.categories,
      allProducts: allProducts ?? this.allProducts,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}