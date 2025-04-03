import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../common/widgets/custom_shapes/containers/semi_curved_container.dart';
import '../../common/widgets/layouts/grid_layout.dart';
import '../../common/widgets/texts/section_heading.dart';
import '../../controllers/cart/add_to_cart_controller.dart';
import '../../controllers/sub_categories/sub_category_controller.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/helpers/helper_function.dart';
import '../../controllers/auth/userId_controller.dart';
import '../home/widgets/for_you.dart';
import '../product/widgets/products_details_screen.dart';

class ForYouProductsPage extends ConsumerStatefulWidget {
  const ForYouProductsPage({super.key});

  @override
  ConsumerState<ForYouProductsPage> createState() => _ForYouProductsPageState();
}

class _ForYouProductsPageState extends ConsumerState<ForYouProductsPage> {
  List<dynamic> forYouProducts = [];
  String currentUserId = '';
  final UserIdService userIdService = UserIdService();
  final String productTagUrl = dotenv.env['PRODUCTS_TAG_URL'] ?? 'https://defaulturl.com/api';
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
    getCurrentUserId();
    Future.microtask(() => ref.read(fetchProductProvider.notifier).fetchProducts('you'));
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
    final forYouProducts = ref.watch(fetchProductProvider);
    final cartController = ref.read(addToCartProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SectionHeading(title: 'For You', showActionButton: false),

        const SizedBox(height: Sizes.spaceBtwItems),
        forYouProducts.isLoading
            ? Center(child: CircularProgressIndicator())
            : forYouProducts.products.isEmpty
            ? ForYou()
            : GridLayout(
              crossAxisCount: 2,
              itemCount: forYouProducts.products.length,
              mainAxisExtent: screenHeight * 0.33,
              itemBuilder: (context, index) {
                final product = forYouProducts.products[index];
                final productId = product['_id'];
                final productName = product['productName'];
                final productPrice = product['productPrice'];
                Uint8List? imageBytes = decodeBase64Image(
                  product['productImages'][0],
                );
                String formattedProductPrice = NumberFormat(
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
                                  cartController.addToCart(
                                    context,
                                    currentUserId,
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
                                "\u20A6$formattedProductPrice",
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
