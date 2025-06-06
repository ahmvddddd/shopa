// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_function.dart';
import '../../custom_shapes/containers/rounded_container.dart';
import '../../icons/t_circular_icon.dart';
import '../../images/t_rounded_image.dart';
import '../../texts/product_title_text.dart';
import '../../texts/t_brand_title_text_with_verified_icon.dart';
import 'product_price_text.dart';

class TProductCardHorizontal extends StatelessWidget {
  const TProductCardHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Container(
      width: 310,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Sizes.productImageRadius),
          color: dark ? TColors.darkerGrey : TColors.lightContainer,
        ),
        child: Row(
          children: [
            //Thumbnail
            RoundedContainer(
              height: 120,
              padding: const EdgeInsets.all(Sizes.sm),
              backgroundColor: dark ? TColors.dark : TColors.light,
              child: Stack(
                children: [
                  //Thumbnail image
                  SizedBox(
                    height: 120,
                    width: 120,
                    child: TRoundedImage(imageUrl: Images.productImage3, applyImageRadius: true,)
                    ),

                    //sale tag
                  Positioned(
                    top: 12,
                    child: RoundedContainer(
                      radius: Sizes.sm,
                      backgroundColor: TColors.secondary.withOpacity(0.8),
                      padding: const EdgeInsets.symmetric(horizontal: Sizes.sm, vertical: Sizes.xs),
                      child: Text('25%', style: Theme.of(context).textTheme.labelLarge!.apply(color: TColors.black),),
                    ),
                  ),
    
                  //Favourite Icon Button
                  Positioned(
                    top: 0,
                    right: 0,
                    child: CircularIcon(icon: Iconsax.heart5, color: Colors.red,))
                
                ],
              ),
            ),

            ///Details
            SizedBox(
              width: 172,
              child: Padding(
                padding: const EdgeInsets.only(top: Sizes.sm, left: Sizes.sm),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TProductTitleText(title: 'Nike Air Jordans, quality branded footwear', smallSize: true),
                        SizedBox(height: Sizes.spaceBtwItems / 2,),
                        TBrandTitleTextWithVerifiedIcon(title: 'Nike'),
                      ]
                    ),

                    const Spacer(),
              
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //Pricing
                        Flexible(child: TProductPriceText(price: '250')),

                        //Add to cart
                        Container(
                    decoration: BoxDecoration(
                      color: TColors.dark,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Sizes.cardRadiusMd),
                        bottomRight: Radius.circular(Sizes.productImageRadius)
                      )
                    ),
                    child: SizedBox(
                      width: Sizes.iconLg * 1.2,
                      height: Sizes.iconLg * 1.2,
                      child: Center(child: const Icon(Iconsax.add, color: TColors.white))),
                  )
                      ],
                    )
                  ],
                ),
              ),
            )
          ]
        )
    );
  }
}