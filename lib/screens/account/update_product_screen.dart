import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../common/widgets/appbar/appbar.dart';
import '../../common/widgets/custom_shapes/containers/button_container.dart';
import '../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';

class UpdateProductPage extends StatefulWidget {
  final String productId;

  const UpdateProductPage({super.key, required this.productId, });

  @override
  UpdateProductPageState createState() => UpdateProductPageState();
}

class UpdateProductPageState extends State<UpdateProductPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _tagsController = TextEditingController();
  final TextEditingController _skuController = TextEditingController();
  List<Uint8List> _images = [];

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImages() async {
    final pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      List<Uint8List> imagesData = [];
      for (var file in pickedFiles) {
        imagesData.add(await file.readAsBytes());
      }
      setState(() {
        _images = imagesData;
      });
    }
  }

  Future<void> _updateProduct() async {
    try {
      var uri = Uri.parse(
        'http://localhost:3000/api/update/${widget.productId}',
      );
      var request = http.MultipartRequest('PUT', uri);

      request.fields['productName'] = _nameController.text;
      request.fields['productPrice'] = _priceController.text;
      request.fields['productDescription'] = _descriptionController.text;
      request.fields['productCategory'] = _categoryController.text;
      request.fields['tags'] = _tagsController.text;
      request.fields['productSku'] = _skuController.text;

      for (var image in _images) {
        request.files.add(
          http.MultipartFile.fromBytes(
            'productImages',
            image,
            filename: 'image.jpg',
          ),
        );
      }

      var response = await request.send();
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product updated successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text(response.toString())),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(title:  Text('Update Product',
      style: Theme.of(context).textTheme.headlineSmall),
      showBackArrow: true,
      ),
      bottomNavigationBar: ButtonContainer(
        onPressed: () {
          _updateProduct();
        },
        text: 'Update Product'
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: Sizes.spaceBtwItems),
        
        
              const SizedBox(height: Sizes.sm),
              TextField(
                controller: _nameController,
                decoration:  InputDecoration(
                  hintText: 'Product Name',
                  hintStyle: Theme.of(context).textTheme.labelSmall),
              ),
        
              const SizedBox(height: Sizes.spaceBtwItems),
              TextField(
                controller: _priceController,
                decoration:  InputDecoration(hintText: 'Product Price',
                  hintStyle: Theme.of(context).textTheme.labelSmall),
                keyboardType: TextInputType.number,
              ),
        
              const SizedBox(height: Sizes.spaceBtwItems),
              TextField(
                controller: _descriptionController,
                decoration:  InputDecoration(
                  hintText: 'Product Description',
                  hintStyle: Theme.of(context).textTheme.labelSmall),
              ),
        
              const SizedBox(height: Sizes.spaceBtwItems),
              TextField(
                controller: _categoryController,
                decoration:  InputDecoration(
                  hintText: 'Product Category',
                  hintStyle: Theme.of(context).textTheme.labelSmall),
              ),
        
              const SizedBox(height: Sizes.sm),
              TextField(
                controller: _tagsController,
                decoration:  InputDecoration(
                  hintText: 'Tags (comma separated)',
                  hintStyle: Theme.of(context).textTheme.labelSmall),
              ),
        
              const SizedBox(height: Sizes.spaceBtwItems),
              TextField(
                controller: _skuController,
                decoration:  InputDecoration(hintText: 'Product SKU',
                  hintStyle: Theme.of(context).textTheme.labelSmall),
              ),
        
              const SizedBox(height: Sizes.spaceBtwSections),
              IconButton(
                    onPressed: _pickImages,
                    style: IconButton.styleFrom(
                      padding: const EdgeInsets.all(Sizes.sm),
                      backgroundColor: TColors.primary
                    ),
                    icon: Icon(Icons.add_a_photo,
                    color: Colors.white,
                    size: Sizes.iconMd,),
                    ),
              _images.isNotEmpty
                    ? Wrap(
                        spacing: 8,
                        children: _images.map((image) {
                          return RoundedContainer(
                            backgroundColor: Colors.transparent,
                            showBorder: true,
                            borderColor: TColors.primary,
                            child: Image.memory(
                              image,
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                          );
                        }).toList(),
                      )
                    : Text("No images selected"),
              const SizedBox(height: Sizes.spaceBtwItems),
            ],
          ),
        ),
      ),
    );
  }
}
