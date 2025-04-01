class SubCategoryModel {
  final List<dynamic> products;
  final bool isLoading;

  SubCategoryModel({
    required this.products,
    required this.isLoading,
  });

  SubCategoryModel copyWith({
    List<dynamic>? products,
    bool? isLoading
  }) {
    return SubCategoryModel(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

