import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../common/widgets/custom_shapes/containers/semi_curved_container.dart';
import '../../common/widgets/layouts/grid_layout.dart';
import '../../common/widgets/texts/section_heading.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/helpers/helper_function.dart';
import '../../controllers/auth/userId_controller.dart';
import '../home/widgets/for_you.dart';
import '../product/widgets/products_details_screen.dart';

class MenProductsPage extends StatefulWidget {
  const MenProductsPage({super.key});

  @override
  State<MenProductsPage> createState() => _MenProductsPageState();
}

class _MenProductsPageState extends State<MenProductsPage> {
  List<dynamic> menProducts = [];
  bool isLoading = true;
  String currentUserId = '';
  final UserIdService userIdService = UserIdService();
  final String productsTagUrl = dotenv.env['PRODUCTS_TAG_URL'] ?? 'https://defaulturl.com/api';
  final String addToCartUrl = dotenv.env['ADD_TO_CART'] ?? 'https://defaulturl.com/api';
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
    fetchProducts();
    getCurrentUserId();
  }

  Future<void> fetchProducts() async {
    try {
      String tag = 'deal';
      final response = await http.get(
        Uri.parse('$productsTagUrl$tag'),
      );
      if (response.statusCode == 200) {
        setState(() {
          menProducts = json.decode(response.body);
          isLoading = false;
        });
      } else {
        ScaffoldMessenger(
          child: SnackBar(content: Text('Could not load products. Try again')),
        );
      }
    } catch (e) {
      ScaffoldMessenger(
        child: SnackBar(content: Text('Could not load products. Try again')),
      );
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SectionHeading(title: 'Men\'s Product', showActionButton: false),

        const SizedBox(height: Sizes.spaceBtwItems),

        isLoading
            ? const Center(child: CircularProgressIndicator())
            : menProducts.isEmpty
            ? ForYou()
            : GridLayout(
              crossAxisCount: 2,
              itemCount: menProducts.length,
              mainAxisExtent: screenHeight * 0.33,
              itemBuilder: (context, index) {
                final product = menProducts[index];
                final productId = product['_id'];
                final productName = product['productName'];
                final productPrice = product['productPrice'];
                Uint8List? imageBytes = decodeBase64Image(
                  product['productImages'][0],
                );
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
                                  addToCart(
                                    productId,
                                    productName,
                                    productPrice,
                                  );
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
                              : Placeholder(
                                fallbackHeight: screenHeight * 0.18,
                              ),

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
      ],
    );
  }
}
