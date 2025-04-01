

class ProductDetailsModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final String sku;
  final List<String> images;
  final List<String> tags;

  ProductDetailsModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.sku,
    required this.images,
    required this.tags,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailsModel(
      id: json['_id'] ?? '',
      name: json['productName'] ?? 'No Name',
      description: json['productDescription'] ?? 'No Description',
      price: (json['productPrice'] as num?)?.toDouble() ?? 0.0,
      sku: json['productSku'] ?? 'No SKU',
      images: (json['productImages'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
    );
  }
}