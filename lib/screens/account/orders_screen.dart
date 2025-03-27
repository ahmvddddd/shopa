import 'package:flutter/material.dart';
import '../../common/widgets/appbar/appbar.dart';
import '../../common/widgets/custom_shapes/containers/semi_curved_container.dart';
import '../../common/widgets/layouts/listvew.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/image_strings.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/helpers/helper_function.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
    final List<Map<String, dynamic>> ordersList = [
    {
      "image": Images.hublot5,
      "name": "Hublot Chronograph Magic",
      "price": "\u20a6550,000",
    },
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
      "image": Images.hublot1,
      "name": "Hublot Blach Magic",
      "price": "\u20a6310,000",
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
    {
      "image": Images.hublot4,
      "name": "Hublot Turillion Sorai",
      "price": "\u20a6110,000",
    },
  ];
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
      appBar: TAppBar(
        title: Text('Orders',
        style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true
      ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Sizes.spaceBtwItems),
            child: Column(
              children: [
                HomeListView(
      scrollDirection: Axis.vertical,
      scrollPhysics: const NeverScrollableScrollPhysics(),
      seperatorBuilder: (context, index) => const SizedBox(height: Sizes.sm),
      itemCount: ordersList.length,
      itemBuilder: (context, index) {
        return SemiCurvedContainer(
            backgroundColor: dark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.1),
            width: screenWidth * 0.35,
            child: Padding(
              padding: const EdgeInsets.all(Sizes.sm),
              child: Column(
                children: [
              
                  Image.asset(ordersList[index]["image"],
                  height: screenHeight * 0.14,
                  width: screenWidth * 0.30,
                  ),
              
                  const SizedBox(height: Sizes.sm,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: screenWidth * 0.18,
                        child: Text(ordersList[index]["name"],
                        style: Theme.of(context).textTheme.labelSmall,
                        softWrap: true,
                        maxLines: 2,),
                      ),
                      Text(ordersList[index]["price"],
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(fontFamily: "JosefinSans", color: TColors.primary),),
                    ],
                  )
                ],
              ),
            )
          );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
