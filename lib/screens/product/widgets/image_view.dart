// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/widgets/appbar/appbar.dart';
import 'package:intl/intl.dart';
import '../../../common/widgets/custom_shapes/containers/button_container.dart';
import '../../../controllers/products/delete_product_controller.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_function.dart';
import '../../account/update_product_screen.dart';

class ImageView extends ConsumerStatefulWidget {
  final Map<String, dynamic> product;
  const ImageView({super.key, required this.product});

  @override
  ConsumerState<ImageView> createState() => ImageViewState();
}

class ImageViewState extends ConsumerState<ImageView> {
  String selectedImage = '';

  @override
  void initState() {
    super.initState();
  }

  Uint8List? decodeBase64Image(String base64String) {
    try {
      return base64Decode(base64String);
    } catch (e) {
      return null;
    }
  }


  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final List<String> imageBase64List =
        widget.product['productImages'].cast<String>();
    final List<Uint8List?> images =
        imageBase64List.map(decodeBase64Image).toList();
    selectedImage = selectedImage.isEmpty ? imageBase64List[0] : selectedImage;
    String productPrice = NumberFormat('#,##0.00').format(widget.product['productPrice']);

    return Scaffold(
      bottomNavigationBar: DoubleButtonContainer(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) =>
                      UpdateProductPage(productId: widget.product['_id']),
            ),
          );
        },
        onPressed2: () {
          ref.read(deleteProductProvider).deleteProduct(context, widget.product['_id']);
        },
        backgroundColor: TColors.warning,
        backgroundColor2: TColors.error,
        child2: Icon(Icons.delete, color: Colors.white, size: Sizes.iconSm),
        child: Icon(Icons.edit, color: Colors.white, size: Sizes.iconSm),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Product Image
            Container(
              height: screenHeight * 0.28,
              decoration: BoxDecoration(
                color: dark ? TColors.dark : TColors.light,
                image: DecorationImage(
                  image: MemoryImage(decodeBase64Image(selectedImage)!),
                  fit: BoxFit.contain,
                ),
              ),
              child: const Column(
                children: [
                  SizedBox(height: Sizes.xs),
                  TAppBar(showBackArrow: true),
                ],
              ),
            ),

            // Product Thumbnails
            Padding(
              padding: const EdgeInsets.all(Sizes.spaceBtwItems),
              child: Column(
                children: [
                  SizedBox(
                    height: 70,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: images.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedImage = imageBase64List[index];
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(Sizes.sm),
                            child: Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  Sizes.borderRadiusLg,
                                ),
                                color: dark ? TColors.dark : TColors.light,
                              ),
                              child:
                                  images[index] != null
                                      ? Image.memory(
                                        images[index]!,
                                        height: 60,
                                        fit: BoxFit.contain,
                                      )
                                      : const Icon(Icons.image, size: 60),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // Name and Price
                  const SizedBox(height: Sizes.spaceBtwItems),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.product['productName'] ?? 'no name',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '\u20A6$productPrice',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: Sizes.spaceBtwItems),
                  const Divider(),

                  // Product Description
                  Text(
                    widget.product['productDescription'] ?? 'no description',
                    style: Theme.of(context).textTheme.bodySmall,
                    softWrap: true,
                  ),

                  const SizedBox(height: Sizes.spaceBtwItems),
                  const Divider(),

                  Wrap(
                    children:
                        widget.product['tags'].map<Widget>((tag) {
                          return Container(
                            margin: EdgeInsets.only(right: 5),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              tag,
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }).toList(),
                  ),

                  const SizedBox(height: Sizes.spaceBtwItems),
                  const Divider(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'SKU:',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),

                      Text(
                        '${widget.product['productSku']}',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),

                  const SizedBox(height: Sizes.spaceBtwItems),
                  const Divider(),

                  Text(
                    widget.product['productDescription'] ?? 'no description',
                    style: Theme.of(context).textTheme.bodySmall,
                    softWrap: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
