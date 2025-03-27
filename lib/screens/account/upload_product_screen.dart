
// // ignore_for_file: unnecessary_nullable_for_final_variable_declarations

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart' as http;

// import '../../common/widgets/appbar/appbar.dart';
// import '../../utils/constants/sizes.dart';

// class UploadProductScreen extends StatefulWidget {
//   const UploadProductScreen({super.key});

//   @override
//   UploadProductScreenState createState() => UploadProductScreenState();
// }

// class UploadProductScreenState extends State<UploadProductScreen> {
//   final _formKey = GlobalKey<FormState>();
//   List<XFile>? _images = [];
//   final ImagePicker _picker = ImagePicker();
  
//   TextEditingController productNameController = TextEditingController();
//   TextEditingController productPriceController = TextEditingController();
//   TextEditingController productDescriptionController = TextEditingController();
//   TextEditingController productCategoryController = TextEditingController();
//   TextEditingController productSkuController = TextEditingController();
//   TextEditingController skillsController = TextEditingController();

//   Future<void> _pickImages() async {
//     final List<XFile>? pickedFiles = await _picker.pickMultiImage();
//     if (pickedFiles != null) {
//       setState(() {
//         _images = pickedFiles;
//       });
//     }
//   }

//   Future<void> _uploadProduct() async {
//     if (_formKey.currentState!.validate() && _images!.isNotEmpty) {
//       var request = http.MultipartRequest('POST', Uri.parse('http://localhost:5000/api/upload'));

//       request.fields['productName'] = productNameController.text;
//       request.fields['productPrice'] = productPriceController.text;
//       request.fields['productDescription'] = productDescriptionController.text;
//       request.fields['productCategory'] = productCategoryController.text;
//       request.fields['tags'] = skillsController.text;
//       request.fields['productSku'] = productSkuController.text;

//       for (var image in _images!) {
//         request.files.add(
//           await http.MultipartFile.fromPath('productImages', image.path),
//         );
//       }

//       var response = await request.send();

//       if (response.statusCode == 201) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Product uploaded successfully")),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Failed to upload product")),
//         );
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Please fill all fields and select at least one image")),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: TAppBar(title: Text("Upload Product",
//       style: Theme.of(context).textTheme.headlineSmall,),
//       showBackArrow: true,),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 TextFormField(
//                   controller: productNameController,
//                   decoration: InputDecoration(
//                     hintText: 'product name',
//                     hintStyle: Theme.of(context).textTheme.labelSmall
//                   ),
//                   validator: (value) => value!.isEmpty ? "Required" : null,
//                 ),

//                 SizedBox(height: Sizes.spaceBtwItems),
//                 TextFormField(
//                   controller: productPriceController, 
//                   decoration: InputDecoration(
//                     hintText: 'product price',
//                     hintStyle: Theme.of(context).textTheme.labelSmall
//                   ),
//                   validator: (value) => value!.isEmpty ? "Required" : null,
//                 ),

//                 SizedBox(height: Sizes.spaceBtwItems),
//                 TextFormField(
//                   controller: productDescriptionController,
//                   decoration: InputDecoration(
//                     hintText: 'product description',
//                     hintStyle: Theme.of(context).textTheme.labelSmall
//                   ),
//                   validator: (value) => value!.isEmpty ? "Required" : null,
//                 ),

//                 SizedBox(height: Sizes.spaceBtwItems),
//                 TextFormField(
//                   controller: productCategoryController,
//                   decoration: InputDecoration(
//                     hintText: 'product category',
//                     hintStyle: Theme.of(context).textTheme.labelSmall
//                   ),
//                   validator: (value) => value!.isEmpty ? "Required" : null,
//                 ),

//                 SizedBox(height: Sizes.spaceBtwItems),
//                 TextFormField(
//                   controller: productSkuController,
//                   decoration: InputDecoration(
//                     hintText: 'SKU',
//                     hintStyle: Theme.of(context).textTheme.labelSmall
//                   ),
//                   validator: (value) => value!.isEmpty ? "Required" : null,
//                 ),

//                 SizedBox(height: Sizes.spaceBtwItems),
//                 TextFormField(
//                   controller: skillsController,
//                   decoration: InputDecoration(
//                     hintText: "Tags (comma-separated)",
//                     hintStyle: Theme.of(context).textTheme.labelSmall
//                   ),
//                 ),
                
//                 SizedBox(height: Sizes.spaceBtwSections),
//                 ElevatedButton(
//                   onPressed: _pickImages,
//                   child: Text("Pick Images"),
//                 ),
//                 _images!.isNotEmpty
//                     ? Wrap(
//                         spacing: 8,
//                         children: _images!.map((image) {
//                           return Image.file(
//                             File(image.path),
//                             height: 50,
//                             width: 50,
//                             fit: BoxFit.cover,
//                           );
//                         }).toList(),
//                       )
//                     : Text("No images selected"),
                
//                 SizedBox(height: Sizes.spaceBtwItems),
//                 ElevatedButton(
//                   onPressed: _uploadProduct,
//                   child: Text("Upload Product"),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }




// ignore_for_file: unnecessary_nullable_for_final_variable_declarations, prefer_final_fields


import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../../common/widgets/appbar/appbar.dart';
import '../../common/widgets/custom_shapes/containers/button_container.dart';
import '../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';

class UploadProductScreen extends StatefulWidget {
  const UploadProductScreen({super.key});

  @override
  UploadProductScreenState createState() => UploadProductScreenState();
}

class UploadProductScreenState extends State<UploadProductScreen> {
  final _formKey = GlobalKey<FormState>();
  List<XFile>? _images = [];
  final ImagePicker _picker = ImagePicker();
  List<Uint8List> _imageBytes = [];

  TextEditingController productNameController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  TextEditingController productCategoryController = TextEditingController();
  TextEditingController productSkuController = TextEditingController();
  TextEditingController tagsController = TextEditingController();

  Future<void> _pickImages() async {
    final List<XFile>? pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles != null) {
      _images = pickedFiles;

      // Convert images to Uint8List for web compatibility
      _imageBytes.clear();
      for (var file in _images!) {
        Uint8List bytes = await file.readAsBytes();
        _imageBytes.add(bytes);
      }

      setState(() {});
    }
  }

  Future<void> _uploadProduct() async {
    if (_formKey.currentState!.validate() && _images!.isNotEmpty) {
      var request = http.MultipartRequest('POST', Uri.parse('http://localhost:3000/api/upload'));

      
      request.fields['productName'] = productNameController.text;
      request.fields['productPrice'] = productPriceController.text;
      request.fields['productDescription'] = productDescriptionController.text;
      request.fields['productCategory'] = productCategoryController.text;
      request.fields['tags'] = tagsController.text;
      request.fields['productSku'] = productSkuController.text;

      for (int i = 0; i < _imageBytes.length; i++) {
        request.files.add(
          http.MultipartFile.fromBytes(
            'productImages',
            _imageBytes[i],
            filename: 'image$i.jpg',
          ),
        );
      }

      var response = await request.send();

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Product uploaded successfully")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to upload product")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill all fields and select at least one image")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(title: Text("Upload Product",
      style: Theme.of(context).textTheme.headlineSmall,),
      showBackArrow: true,),
      bottomNavigationBar: ButtonContainer(
        onPressed: () {
          _uploadProduct();
        },
        text: 'Upload Product'
      ),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.spaceBtwItems),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: productNameController,
                  decoration: InputDecoration(
                    hintText: 'product name',
                    hintStyle: Theme.of(context).textTheme.labelSmall
                  ),
                  validator: (value) => value!.isEmpty ? "Required" : null,
                ),

                SizedBox(height: Sizes.spaceBtwItems),
                TextFormField(
                  controller: productPriceController,
                  decoration: InputDecoration(
                    hintText: 'product price',
                    hintStyle: Theme.of(context).textTheme.labelSmall
                  ),
                  validator: (value) => value!.isEmpty ? "Required" : null,
                ),

                SizedBox(height: Sizes.spaceBtwItems),
                TextFormField(
                  controller: productDescriptionController,
                  decoration: InputDecoration(
                    hintText: 'product description',
                    hintStyle: Theme.of(context).textTheme.labelSmall
                  ),
                  validator: (value) => value!.isEmpty ? "Required" : null,
                ),

                SizedBox(height: Sizes.spaceBtwItems),
                TextFormField(
                  controller: productCategoryController,
                  decoration: InputDecoration(
                    hintText: 'product category',
                    hintStyle: Theme.of(context).textTheme.labelSmall
                  ),
                  validator: (value) => value!.isEmpty ? "Required" : null,
                ),

                SizedBox(height: Sizes.spaceBtwItems),
                TextFormField(
                  controller: productSkuController,
                  decoration: InputDecoration(
                    hintText: 'SKU',
                    hintStyle: Theme.of(context).textTheme.labelSmall
                  ),
                  validator: (value) => value!.isEmpty ? "Required" : null,
                ),

                SizedBox(height: Sizes.spaceBtwItems),
                TextFormField(
                  controller: tagsController,
                  decoration: InputDecoration(
                    hintText: "Tags (comma-separated)",
                    hintStyle: Theme.of(context).textTheme.labelSmall
                  ),
                ),
                
                SizedBox(height: Sizes.spaceBtwSections),
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
                _imageBytes.isNotEmpty
                    ? Wrap(
                        spacing: 8,
                        children: _imageBytes.map((image) {
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
                
                SizedBox(height: Sizes.spaceBtwSections),
                // ElevatedButton(
                //   onPressed: _uploadProduct,
                //   child: Text("Upload Product"),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

