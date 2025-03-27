import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart' show Iconsax;
import 'package:shopa/common/widgets/layouts/grid_layout.dart' show GridLayout;

import '../../../common/widgets/custom_shapes/containers/semi_curved_container.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_function.dart';

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
      "price": "Out of Stock"
    },
    {
      "image": Images.productImage2,
      "name": "Nike AirMax",
      "price": "Out of Stock"
    },
    {
      "image": Images.hublot1,
      "name": "Hublot Geneive",
      "price": "Out of Stock"
    },
    {
      "image": Images.hublot2,
      "name": "Hublot Sportsman",
      "price": "Out of Stock"
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
      mainAxisExtent: screenHeight * 0.33,
      itemBuilder: (context, index)  {
        return SemiCurvedContainer(
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
                    color: dark ? Colors.white : Colors.black,
                    size: Sizes.iconSm,)),
        
                    IconButton(onPressed: () {},
                    icon: Icon(Iconsax.bag,
                    color: dark ? Colors.white : Colors.black,
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
                      width: screenWidth * 0.16,
                      child: Text(forYouList[index]["name"],
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(overflow: TextOverflow.ellipsis),
                      softWrap: true,
                      maxLines: 3,),
                    ),
                    Text(forYouList[index]["price"],
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(fontFamily: "JosefinSans", color: TColors.primary),),
                  ],
                )
              ],
            ),
          )
        );
      }
    );
  }
}