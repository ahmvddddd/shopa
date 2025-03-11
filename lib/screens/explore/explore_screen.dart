import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopa/common/widgets/image/promo_slider.dart' show PromoSlider;
import 'package:shopa/screens/cart/cart_screen.dart';
import 'package:shopa/utils/constants/sizes.dart';
import '../../common/widgets/appbar/appbar.dart';
import '../../common/widgets/texts/section_heading.dart';
import '../../utils/constants/image_strings.dart';
import '../favorite/favorite_screen.dart';
import 'widgets/deals.dart';
import 'widgets/product_view.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        appBar: TAppBar(
          title: SizedBox(width: 10),
          actions: [
            
            IconButton(onPressed: () {
              Navigator.push(context, 
              MaterialPageRoute(builder: (context) => const CartScreen()));
            }, 
                    icon: Icon(Iconsax.bag,
                    color: Colors.white,
                    size: Sizes.iconMd,)),

          const SizedBox(width: Sizes.xs,),
            IconButton(onPressed: () {
              Navigator.push(context, 
              MaterialPageRoute(builder: (context) => const FavoriteScreen()));
            }, 
                    icon: Icon(Iconsax.heart,
                    color: Colors.white,
                    size: Sizes.iconMd,)),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Sizes.spaceBtwItems),
            child: Column(
              children: [
                const PromoSlider(
                    imageList: [
                      Images.promoBanner2,
                      Images.funiture,
                      Images.fashionDesigner,
                    ],
                  ),

                  const SizedBox(height: Sizes.spaceBtwSections,),
                  const ProductView(),

                  const SizedBox(
                height: Sizes.spaceBtwItems,
              ),
               const SectionHeading(
                title: 'Deal Of The Day',
                showActionButton: true,
              ),
              const SizedBox(height: Sizes.sm,),
              const Deals(),
              
              ],
            ),
          ),
        ),
      ),
    );
  }
}