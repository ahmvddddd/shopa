import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart' show Iconsax;
import 'package:shopa/common/widgets/layouts/grid_layout.dart' show GridLayout;

import '../../../common/widgets/custom_shapes/containers/semi_curved_container.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_function.dart';
import '../../product/product_details_screen.dart';

class ForYou extends StatefulWidget {
  const ForYou({super.key});

  @override
  State<ForYou> createState() => _ForYouState();
}

class _ForYouState extends State<ForYou> {
  final List<Map<String, dynamic>> forYouList = [
    {
      "image": Images.productImage1,
      "name": "Nike AirJordan",
      "price": "\u20a6123,000"
    },
    {
      "image": Images.productImage2,
      "name": "Nike AirMax",
      "price": "\u20a6110,000"
    },
    {
      "image": Images.hublot1,
      "name": "Hublot Geneive",
      "price": "\u20a6349,000"
    },
    {
      "image": Images.hublot2,
      "name": "Hublot Sportsman",
      "price": "\u20a6403,000"
    },
  ];

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return GridLayout(
      crossAxisCount: 2,
      itemCount: forYouList.length,
      mainAxisExtent: screenHeight * 0.30,
      itemBuilder: (context, index)  {
        return GestureDetector(
          onTap: () {
            Navigator.push(context, 
            MaterialPageRoute(builder: (context) => const ProductDetailsScreen()));
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
                      IconButton(onPressed: () {},
                      icon: Icon(Iconsax.heart,
                      color: Colors.white,
                      size: Sizes.iconSm,)),
          
                      IconButton(onPressed: () {},
                      icon: Icon(Iconsax.bag,
                      color: Colors.white,
                      size: Sizes.iconSm,))
                    ],
                  ),
              
                  Image.asset(forYouList[index]["image"],
                  height: screenHeight * 0.18,
                  width: screenWidth * 0.30,
                  ),
              
                  const SizedBox(height: Sizes.sm,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: screenWidth * 0.18,
                        child: Text(forYouList[index]["name"],
                        style: Theme.of(context).textTheme.labelSmall,
                        softWrap: true,
                        maxLines: 2,),
                      ),
                      Text(forYouList[index]["price"],
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(fontFamily: "JosefinSans", color: TColors.primary),),
                    ],
                  )
                ],
              ),
            )
          ),
        );
      }
    );
  }
}