import 'package:flutter/material.dart';
import 'package:shopa/screens/cart/cart_screen.dart';
import 'package:shopa/utils/constants/sizes.dart';
import '../../common/widgets/appbar/appbar.dart';
import '../../common/widgets/image/image_slider.dart';
import '../../common/widgets/texts/section_heading.dart';
import '../../utils/helpers/helper_function.dart';
import '../sub_categories/deals_products.dart';
import '../sub_categories/men_products.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return  SafeArea(
      child: Scaffold(
        appBar: TAppBar(
          title: SizedBox(width: 10),
          actions: [
            
            IconButton(onPressed: () {
              Navigator.push(context, 
              MaterialPageRoute(builder: (context) => const CartScreen()));
            }, 
                    icon: Icon(Icons.shopping_cart,
                    color: dark ? Colors.white : Colors.black,
                    size: Sizes.iconMd,)),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Sizes.spaceBtwItems),
            child: Column(
              children: [
                 ImageSlider(),

                 const SizedBox(height: Sizes.spaceBtwSections,),
                 const MenProductsPage(),
                  const SizedBox(
                height: Sizes.spaceBtwItems,
              ),
               const SectionHeading(
                title: 'Deal Of The Day',
                showActionButton: true,
              ),
              const SizedBox(height: Sizes.sm,),
              const DealsProducts(),
              
              ],
            ),
          ),
        ),
      ),
    );
  }
}