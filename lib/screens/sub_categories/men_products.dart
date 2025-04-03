import 'dart:convert';
import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/auth/userId_controller.dart';
import '../../common/widgets/custom_shapes/containers/semi_curved_container.dart';
import '../../common/widgets/layouts/grid_layout.dart';
import '../../common/widgets/texts/section_heading.dart';
import '../../controllers/cart/add_to_cart_controller.dart';
import '../../controllers/sub_categories/sub_category_controller.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/helpers/helper_function.dart';
import '../home/widgets/for_you.dart';
import '../product/widgets/products_details_screen.dart';

class MenProductsPage extends ConsumerStatefulWidget {
  const MenProductsPage({super.key});

  @override
  ConsumerState<MenProductsPage> createState() => _MenProductsPageState();
}

class _MenProductsPageState extends ConsumerState<MenProductsPage> {
  String currentUserId = '';
  final UserIdService userIdService = UserIdService();

  @override
  void initState() {
    super.initState();
    getCurrentUserId();
    Future.microtask(() => ref.read(fetchProductProvider.notifier).fetchProducts('deal'));
  }

  Future<void> getCurrentUserId() async {
    final userId = await userIdService.getCurrentUserId();
    setState(() {
      currentUserId = userId!;
    });
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
    final subCategories = ref.watch(fetchProductProvider);
    final cartController = ref.read(addToCartProvider);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final dark = THelperFunctions.isDarkMode(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SectionHeading(title: "Men's Products", showActionButton: false),
        const SizedBox(height: Sizes.spaceBtwItems),
        subCategories.isLoading
        ? const Center(child: CircularProgressIndicator(),)
        : subCategories.products.isEmpty
              ? const ForYou()
              : GridLayout(
                  crossAxisCount: 2,
                  itemCount: subCategories.products.length,
                  mainAxisExtent: screenHeight * 0.33,
                  itemBuilder: (context, index) {
                    final product = subCategories.products[index];
                    final productId = product['_id'];
                    final productName = product['productName'];
                    final productPrice = product['productPrice'];
                    Uint8List? imageBytes = decodeBase64Image(product['productImages'][0]);
                    String formattedProductPrice = NumberFormat('#,##0.00').format(productPrice);

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProductDetailsScreen(product: product)),
                        );
                      },
                      child: SemiCurvedContainer(
                        backgroundColor: dark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.1),
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
                                    } ,
                                    icon: const Icon(Icons.shopping_cart, color: Colors.white, size: Sizes.iconSm),
                                  ),
                                ],
                              ),
                              imageBytes != null
                                  ? Image.memory(imageBytes, height: screenHeight * 0.18, width: screenWidth * 0.30, fit: BoxFit.cover)
                                  : const Placeholder(fallbackHeight: 100),
                              Text(product['productName'], textAlign: TextAlign.center),
                              Text("\u20A6$formattedProductPrice", style: TextStyle(color: TColors.primary)),
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
