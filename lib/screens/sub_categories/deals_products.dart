import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../../common/styles/shadows.dart';
import '../../../common/widgets/custom_shapes/containers/semi_curved_container.dart';
import '../../../common/widgets/layouts/listvew.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_function.dart';
import '../../controllers/sub_categories/sub_category_controller.dart';
import '../explore/widgets/deals.dart';
import '../../controllers/auth/userId_controller.dart';
import '../product/widgets/products_details_screen.dart';

class DealsProducts extends ConsumerStatefulWidget {
  const DealsProducts({super.key});

  @override
  ConsumerState<DealsProducts> createState() => _DealsProductsState();
}

class _DealsProductsState extends ConsumerState<DealsProducts> {
  String currentUserId = '';
  final UserIdService userIdService = UserIdService();
  final String productsTagUrl = dotenv.env['PRODUCTS_TAG_URL'] ?? 'https://defaulturl.com/api';
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
    final dealsList = ref.watch(fetchProductProvider);
    return 
    dealsList.isLoading
    ? const Center(child: CircularProgressIndicator())
            : dealsList.products.isEmpty
            ? Deals()
            : HomeListView(
      sizedBoxHeight: screenHeight * 0.23,
      scrollDirection: Axis.horizontal,
      seperatorBuilder: (context, index) => const SizedBox(width: Sizes.sm),
      itemCount: dealsList.products.length,
      itemBuilder:
          (context, index) {
            final product = dealsList.products[index];
                final productName = product['productName'];
                final productPrice = product['productPrice'];
                Uint8List? imageBytes = decodeBase64Image(
                  product['productImages'][0],
                  );
                String formatedProductPrice = NumberFormat(
                  '#,##0.00',
                ).format(productPrice);

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
              width: screenWidth * 0.90,
              backgroundColor:
                  dark
                      ? Colors.white.withOpacity(0.1)
                      : Colors.black.withOpacity(0.1),
              showBorder: true,
              boxShadow: [ShadowStyle.verticalProductShadow],
              borderColor: TColors.primary,
              padding: const EdgeInsets.all(Sizes.xs),
              child: Row(
                children: [
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
              
                  const SizedBox(width: Sizes.sm),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        productName,
                        style: Theme.of(context).textTheme.labelSmall,
                        softWrap: true,
                        maxLines: 2,
                      ),
                      Text(
                        "\u20A6$formatedProductPrice",
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontFamily: "JosefinSans",
                          color: TColors.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
                        ),
            );
          },
    );
  }
}
