// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../common/widgets/appbar/appbar.dart';
import 'package:intl/intl.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../../common/widgets/custom_shapes/containers/button_container.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_function.dart';
import '../../../controllers/auth/userId_controller.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => ProductDetailsState();
}

class ProductDetailsState extends State<ProductDetailsScreen> {
  String selectedImage = '';
  String currentUserId = '';
  final UserIdService userIdService = UserIdService();
   final String addToCartUrl = dotenv.env['ADD_TO_CART'] ?? 'https://defaulturl.com/api';

  @override
  void initState() {
    super.initState();
    getCurrentUserId();
  }

  Uint8List? decodeBase64Image(String base64String) {
    try {
      return base64Decode(base64String);
    } catch (e) {
      return null;
    }
  }

  Future<void> addToCart(
    String productId,
    String productName,
    double productPrice,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(addToCartUrl),
        body: json.encode({
          "userId": currentUserId,
          "productId": productId,
          "productName": productName,
          "productPrice": productPrice,
          "quantity": 1,
        }),
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Item added to cart')));
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not add item to cart. Try again'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not add item to cart. Try again')),
      );
    }
  }

  Future<void> getCurrentUserId() async {
    final userId = await userIdService.getCurrentUserId();
    setState(() {
      currentUserId = userId!;
    });
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
    String formattedProductPrice = NumberFormat(
      '#,##0.00',
    ).format(widget.product['productPrice']);
    final productId = widget.product['_id'];
    final productName = widget.product['productName'];
    final productPrice = widget.product['productPrice'];

    return Scaffold(
      bottomNavigationBar: ButtonContainer(
        onPressed: () {
          addToCart(productId, productName, productPrice);
        },
        text: 'Add to cart',
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
                        '\u20A6$formattedProductPrice',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: Sizes.spaceBtwItems),
                  const Divider(),
                  const SizedBox(height: Sizes.sm),

                  // Product Description
                  Text(
                    widget.product['productDescription'] ?? 'no description',
                    style: Theme.of(context).textTheme.bodySmall,
                    softWrap: true,
                  ),

                  const SizedBox(height: Sizes.spaceBtwItems),
                  const Divider(),
                  const SizedBox(height: Sizes.sm),

                  Wrap(
                    children:
                        widget.product['tags'].map<Widget>((tag) {
                          return Container(
                            margin: EdgeInsets.only(right: 5),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: TColors.primary,
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
                  const SizedBox(height: Sizes.sm),

                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas at nunc tempus, semper nibh nec, lacinia nunc. Vestibulum sollicitudin fringilla sapien et vulputate.',
                    style: Theme.of(context).textTheme.bodySmall,
                    softWrap: true,
                  ),

                  const SizedBox(height: Sizes.spaceBtwItems),
                  const Divider(),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
