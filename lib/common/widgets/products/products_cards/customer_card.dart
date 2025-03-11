import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_function.dart';
import '../../custom_shapes/containers/rounded_container.dart';

class CustomerCard extends StatelessWidget {
  final String profileImage;
  final String profileName;
  const CustomerCard(
      {super.key, required this.profileImage, required this.profileName});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double xSAvatarHeight = screenHeight * 0.055;
    double horizontalCardHeight = screenHeight * 0.20;
    double cardHeight = screenHeight * 0.28;
    double cardWidth = screenWidth * 0.35;
    final dark = THelperFunctions.isDarkMode(context);
    return RoundedContainer(
      height: cardHeight * 0.85,
      width: cardWidth,
      padding: const EdgeInsets.all(Sizes.sm),
      backgroundColor: dark ?  TColors.white.withOpacity(0.1)
                : TColors.black.withOpacity(0.1),
      showBorder: true,
      borderColor: TColors.primary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RoundedContainer(
                width: horizontalCardHeight * 0.5,
                height: horizontalCardHeight * 0.5,
                radius: 100,
                backgroundColor: dark ? Colors.black : Colors.white,
                padding: const EdgeInsets.all(2),
                child: Center(
                  child: Image.asset(
                    profileImage,
                    fit: BoxFit.contain,
                    height: horizontalCardHeight * 0.45,
                  ),
                ),
              ),

              //name
              const SizedBox(
                height: Sizes.sm,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    profileName,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  const Icon(
                    Iconsax.verify,
                    color: Colors.amber,
                    size: Sizes.iconSm,
                  )
                ],
              ),
            ],
          ),

          //button
          const SizedBox(
            height: Sizes.sm,
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              height: xSAvatarHeight * 0.90,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Sizes.borderRadiusMd),
                  color: TColors.primary),
              padding: const EdgeInsets.all(Sizes.xs),
              child: Center(
                child: Text(
                  'View',
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
