import 'package:flutter/material.dart';
import '../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../common/widgets/layouts/listvew.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_function.dart';
import '../../product/product_details_screen.dart';

class CartList extends StatefulWidget {
  const CartList({super.key});

  @override
  State<CartList> createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  final List<Map<String, dynamic>> cartList = [
    {
      "image": Images.productImage1,
      "name": "Nike AirJordan",
      "price": "\u20a6123,000",
      "unit": "2"
    },
    {
      "image": Images.productImage2,
      "name": "Nike AirMax",
      "price": "\u20a6110,000",
      "unit": "1"
    },
    {
      "image": Images.hublot1,
      "name": "Hublot Geneive",
      "price": "\u20a6349,000",
      "unit": "3"
    },
    {
      "image": Images.hublot2,
      "name": "Hublot Sportsman",
      "price": "\u20a6403,000",
      "unit": "1"
    },
  ];
  
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return HomeListView(
      scrollDirection: Axis.vertical,
      scrollPhysics: const NeverScrollableScrollPhysics(),
      seperatorBuilder: (context, index) => const SizedBox(height: Sizes.sm),
      itemCount: cartList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(context, 
            MaterialPageRoute(builder: (context) => const ProductDetailsScreen()));
          },
          child: Stack(
            children: [
              RoundedContainer(
                height: screenHeight * 0.18,
                backgroundColor: dark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.1),
                padding: const EdgeInsets.all(Sizes.sm),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RoundedContainer(
                      height: screenHeight * 0.15,
                      width: screenWidth * 0.25,
                      backgroundColor: TColors.darkerGrey,
                      showBorder: true,
                      borderColor: TColors.primary,
                      child: Image.asset(cartList[index]["image"],
                      height: screenHeight * 0.15,
                      width: screenWidth * 0.25,
                      fit: BoxFit.contain,),
                    ),
              
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(cartList[index]["name"],
                            style: Theme.of(context).textTheme.labelMedium,
                            softWrap: true,
                            maxLines: 2,),
                        
                            const SizedBox(height: Sizes.xs,),
                            Row(
                              children: [
                                Text('unit:',
                              style: Theme.of(context).textTheme.labelSmall,),
                              const SizedBox(width: Sizes.sm,),
                                Text(cartList[index]["unit"],
                              style: Theme.of(context).textTheme.labelSmall!.copyWith(fontWeight: FontWeight.bold),),
                              ],
                            ),
                          ],
                        ),
                        
                        Text(cartList[index]["price"],
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(color: TColors.primary),),
                      ],
                    )
              
                  ],
                ),
              ),
          
          
              Positioned(
                      right: 50,
                      top: 60,
                      child: Icon(Icons.cancel,
                      color: Colors.red[900])
                    )
            ],
          ),
        );
      }
          );
  }
}