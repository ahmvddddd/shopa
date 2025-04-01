import 'dart:typed_data';

class UpdateProductModel {
  final String id;
  String name;
  String price;
  String description;
  String category;
  String tags;
  String sku;
  List<Uint8List> images;

  UpdateProductModel({
    this.id = '',
    required this.name,
    required this.price,
    required this.description,
    required this.category,
    required this.tags,
    required this.sku,
    required this.images,
  });

  Map<String, String> toMap() {
    return {
      'productName': name,
      'productPrice': price,
      'productDescription': description,
      'productCategory': category,
      'tags': tags,
      'productSku': sku,
    };
  }
}
