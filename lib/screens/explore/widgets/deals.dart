import 'package:flutter/material.dart';

import '../../../common/styles/shadows.dart';
import '../../../common/widgets/custom_shapes/containers/semi_curved_container.dart';
import '../../../common/widgets/layouts/listvew.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_function.dart';

class Deals extends StatefulWidget {
  const Deals({super.key});

  @override
  State<Deals> createState() => _DealsState();
}

class _DealsState extends State<Deals> {
  final List<Map<String, dynamic>> dealsList = [
    {
      "image": Images.productImage3,
      "name": "Nike AirJordan",
      "price": "\u20a6123,000",
    },
    {
      "image": Images.productImage4,
      "name": "Nike AirMax",
      "price": "\u20a6110,000",
    },
    {
      "image": Images.productImage1,
      "name": "Nike AirJordan",
      "price": "\u20a6123,000",
    },
    {
      "image": Images.productImage2,
      "name": "Nike AirMax",
      "price": "\u20a6110,000",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return HomeListView(
      sizedBoxHeight: screenHeight * 0.23,
      scrollDirection: Axis.horizontal,
      seperatorBuilder: (context, index) => const SizedBox(width: Sizes.sm),
      itemCount: dealsList.length,
      itemBuilder:
          (context, index) => SemiCurvedContainer(
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
                Image.asset(
                  dealsList[index]["image"],
                  width: screenWidth * 0.60,
                  height: screenWidth * 0.22,
                  fit: BoxFit.contain,
                ),

                const SizedBox(width: Sizes.sm),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: screenWidth * 0.18,
                      child: Text(
                        dealsList[index]["name"],
                        style: Theme.of(context).textTheme.labelSmall,
                        softWrap: true,
                        maxLines: 2,
                      ),
                    ),
                    Text(
                      dealsList[index]["price"],
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
  }
}
