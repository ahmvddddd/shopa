import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class PCard extends StatelessWidget {
  final String watchImage;
  final String watchName;
  final String watchPrice;
  const PCard(
      {super.key,
      required this.watchImage,
      required this.watchName,
      required this.watchPrice});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: screenWidth * 0.40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Sizes.borderRadiusLg),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Image.asset(
                  watchImage,
                  height: screenHeight * 0.15,
                  fit: BoxFit.contain,
                ),
                const SizedBox(
                  height: Sizes.sm,
                ),
                 const Padding(padding: EdgeInsets.symmetric(horizontal: Sizes.spaceBtwSections),
                child: Divider(color: TColors.primary,thickness: 2,),),
                const SizedBox(
                  height: Sizes.xs,
                ),
                SizedBox(
                  width: screenWidth * 0.40,
                  child: Center(
                    child: Text(
                      watchName,
                      style: Theme.of(context).textTheme.labelSmall,
                      softWrap: true,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Text(
                  '\$$watchPrice',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                const SizedBox(height: Sizes.sm),
              ],
            ),

            //button
            SizedBox(
              width: double.infinity,
              child: Container(
                height: screenHeight * 0.04,
                padding: const EdgeInsets.all(Sizes.xs),
                decoration:  BoxDecoration(
                    color: TColors.primary,
                    borderRadius: BorderRadius.circular(Sizes.borderRadiusMd)),
                child: const Center(
                    child:
                        Icon(Iconsax.shopping_bag, size: Sizes.iconXs, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
