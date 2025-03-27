// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/widgets/appbar/appbar.dart';
import 'package:intl/intl.dart';
import '../../common/widgets/custom_shapes/containers/semi_curved_container.dart';
import '../../common/widgets/layouts/grid_layout.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/helpers/helper_function.dart';
import '../../controllers/auth/userId_controller.dart';
import 'package:http/http.dart' as http;
import 'widgets/products_details_screen.dart';

class ProductsCategoryScreen extends ConsumerStatefulWidget {
  final String category;
  final List<dynamic> products;

  const ProductsCategoryScreen({
    super.key,
    required this.category,
    required this.products,
  });

  @override
  ConsumerState<ProductsCategoryScreen> createState() =>
      _ProductsCategoryScreenState();
}

class _ProductsCategoryScreenState extends ConsumerState<ProductsCategoryScreen> {
  String currentUserId = '';
  final UserIdService userIdService = UserIdService();
  Uint8List? decodeBase64Image(String base64String) {
    try {
      return base64Decode(base64String);
    } catch (e) {
      return null;
    }
  }

  

  @override
  void initState() {
    super.initState();
    getCurrentUserId();
  }

  Future<void> addToCart(
    String productId,
    String productName,
    double productPrice,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/api/add'),
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
        print('success');
      } else {
        print(response.body);
      }
    } catch (e) {
      print(e.toString());
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          widget.category,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.spaceBtwItems),
          child: GridLayout(
            crossAxisCount: 2,
            itemCount: widget.products.length,
            mainAxisExtent: screenHeight * 0.35,
            itemBuilder: (context, index) {
              final product = widget.products[index];
              Uint8List? imageBytes = decodeBase64Image(
                product['productImages'][0],
              );
              final productId = product['_id'];
              final productName = product['productName'];
              final productPrice = product['productPrice'];
              String formatedProductPrice = NumberFormat(
                '#,##0.00',
              ).format(product['productPrice']);
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailsScreen(product: product),
                    ),
                  );
                },
                child: SemiCurvedContainer(
                  backgroundColor:
                      dark
                          ? Colors.white.withOpacity(0.1)
                          : Colors.black.withOpacity(0.1),
                  width: screenWidth * 0.35,
                  child: Padding(
                    padding: const EdgeInsets.all(Sizes.sm),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(width: 10),

                            IconButton(
                              onPressed: () {
                                print(
                                  'uid$currentUserId, pid$productId, pName$productName, pPrice$productPrice',
                                );
                                addToCart(productId, productName, productPrice);
                              },
                              icon: Icon(
                                Icons.shopping_cart,
                                color: Colors.white,
                                size: Sizes.iconSm,
                              ),
                            ),
                          ],
                        ),

                        imageBytes != null
                            ? Image.memory(
                              imageBytes,
                              height: screenHeight * 0.18,
                              width: screenWidth * 0.30,
                              fit: BoxFit.cover,
                            )
                            : Placeholder(fallbackHeight: screenHeight * 0.18),

                        const SizedBox(height: Sizes.sm),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              product['productName'],
                              style: Theme.of(context).textTheme.labelMedium,
                              softWrap: true,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "\u20A6$formatedProductPrice",
                              style: Theme.of(
                                context,
                              ).textTheme.labelLarge!.copyWith(
                                fontFamily: "JosefinSans",
                                color: TColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
