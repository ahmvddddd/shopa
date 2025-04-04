import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../../common/widgets/pop_up/custom_snackbar.dart';
import '../../models/products/update_product_model.dart';
import '../../nav_menu.dart';
import '../../utils/constants/colors.dart';

class UploadProductController extends StateNotifier<UpdateProductModel> {
  final ImagePicker _picker = ImagePicker();

  UploadProductController()
      : super(UpdateProductModel(
          name: '',
          price: '',
          description: '',
          category: '',
          tags: '',
          sku: '',
          images: [],
        ));

  void updateField(String key, String value) {
    state = UpdateProductModel(
      id: state.id,
      name: key == "name" ? value : state.name,
      price: key == "price" ? value : state.price,
      description: key == "description" ? value : state.description,
      category: key == "category" ? value : state.category,
      tags: key == "tags" ? value : state.tags,
      sku: key == "sku" ? value : state.sku,
      images: state.images,
    );
  }

  Future<void> pickImages() async {
    final pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      List<Uint8List> imagesData = [];
      for (var file in pickedFiles) {
        imagesData.add(await file.readAsBytes());
      }
      state = UpdateProductModel(
        id: state.id,
        name: state.name,
        price: state.price,
        description: state.description,
        category: state.category,
        tags: state.tags,
        sku: state.sku,
        images: imagesData,
      );
    }
  }

  Future<void> uploadProduct(BuildContext context) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse('http://localhost:3000/api/upload'));

      request.fields.addAll(state.toMap());

      for (var image in state.images) {
        request.files.add(
          http.MultipartFile.fromBytes(
            'productImages',
            image,
            filename: 'image.jpg',
          ),
        );
      }

      var response = await request.send();
      if (response.statusCode == 201) {
        CustomSnackbar.show(
        context: context,
        title: 'success',
        message: 'Product uploaded succefully',
        backgroundColor: TColors.success,
        icon: Icons.check
       );
       Navigator.push(context, 
       MaterialPageRoute(
        builder: (context) => NavigationMenu()
       ));
      } else {
       CustomSnackbar.show(
        context: context,
        title: 'An error occured',
        message: 'Could not upload product. Try again later',
        backgroundColor: TColors.error,
        icon: Icons.cancel
       );
      }
    } catch (e) {
       CustomSnackbar.show(
        context: context,
        title: 'An error occured',
        message: 'Could not place order. Try again later',
        backgroundColor: TColors.error,
        icon: Icons.cancel
       );
    }
  }
}

// **Riverpod Provider**
final uploadProductProvider = StateNotifierProvider<UploadProductController, UpdateProductModel>(
  (ref) => UploadProductController(),
);
