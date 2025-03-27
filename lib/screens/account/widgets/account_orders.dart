import 'package:flutter/material.dart';
import '../../../common/widgets/custom_shapes/containers/semi_curved_container.dart';
import '../../../common/widgets/layouts/listvew.dart';
import '../../../common/widgets/texts/section_heading.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_function.dart';
import '../orders_screen.dart';

class AccountOrders extends StatefulWidget {
  const AccountOrders({super.key});

  @override
  State<AccountOrders> createState() => _AccountOrdersState();
}

class _AccountOrdersState extends State<AccountOrders> {
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
  ];
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return  Column(
      children: [
        SectionHeading(
          title: 'Orders',
          onPressed: () {
            Navigator.push(context, 
            MaterialPageRoute(builder: (context) => const OrdersScreen()));
          },
        ),

        const SizedBox(height: Sizes.sm,),
        HomeListView(
      sizedBoxHeight: screenHeight * 0.23,
      scrollDirection: Axis.horizontal,
      seperatorBuilder: (context, index) => const SizedBox(width: Sizes.sm),
      itemCount: ordersList.length,
      itemBuilder:
          (context, index) {
            return SemiCurvedContainer(
            backgroundColor: dark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.1),
            width: screenWidth * 0.30,
            child: Padding(
              padding: const EdgeInsets.all(Sizes.sm),
              child: Column(
                children: [
              
                  Image.asset(ordersList[index]["image"],
                  height: screenHeight * 0.12,
                  width: screenWidth * 0.23,
                  ),
              
                  const SizedBox(height: Sizes.sm,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(ordersList[index]["name"],
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: 10),
                      softWrap: true,
                      maxLines: 2,),
                      const SizedBox(height: Sizes.sm,),
                      Text(ordersList[index]["price"],
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(fontFamily: "JosefinSans", color: TColors.primary),),
                    ],
                  )
                ],
              ),
            )
          );
          }
        )
      ],
    );
  }
}



