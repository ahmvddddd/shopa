import 'package:flutter/material.dart';
import '../../common/widgets/appbar/appbar.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/helpers/helper_function.dart';
import '../cart/cart_screen.dart';
import '../product/widgets/category_gridview.dart';
import '../sub_categories/for_you_products.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return SafeArea(
      child: Scaffold(
        appBar: TAppBar(
          title: SizedBox(width: 10),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartScreen()),
                );
              },
              icon: Icon(
                Icons.shopping_cart,
                color: dark ? Colors.white : Colors.black,
                size: Sizes.iconMd,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Sizes.spaceBtwItems),
            child: Column(
              children: [
                const CategoryGridview(),

                const SizedBox(height: Sizes.spaceBtwSections),
                const ForYouProductsPage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
