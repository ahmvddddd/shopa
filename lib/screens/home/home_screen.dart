import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart' show Iconsax;
import 'package:shopa/common/widgets/texts/section_heading.dart';

import '../../common/widgets/appbar/appbar.dart';
import '../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../utils/constants/sizes.dart';
import '../cart/cart_screen.dart';
import '../favorite/favorite_screen.dart';
import 'widgets/category_grid.dart';
import 'widgets/for_you.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
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
                    icon: Icon(Icons.favorite,
                    color: Colors.white,
                    size: Sizes.iconMd,)),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Sizes.spaceBtwItems),
            child: Column(
              children: [
                
                SearchContainer(
                  width: screenWidth * 0.90,
                  text: 'search',
                ),

                const SizedBox(height: Sizes.spaceBtwSections),
                const CategoryGrid(),

                const SizedBox(height: Sizes.spaceBtwSections),
                SectionHeading(
                  title: 'For You',
                  showActionButton: false,
                  ),
                const SizedBox(height: Sizes.spaceBtwSections), 
                const ForYou() 
                
              ]
            )
          )
        )
      )
    );
  }
}