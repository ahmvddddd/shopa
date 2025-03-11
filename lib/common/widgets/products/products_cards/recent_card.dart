import 'package:flutter/material.dart';
import '../../../../utils/constants/colors.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_function.dart';
import '../../custom_shapes/containers/rounded_container.dart';

class RecentCard extends StatelessWidget {
  final String profileImage;
  final String profileName;
  final String service;
  const RecentCard(
      {super.key,
      required this.profileImage,
      required this.profileName,
      required this.service,});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final dark = THelperFunctions.isDarkMode(context);
    return RoundedContainer(
      padding: const EdgeInsets.all(Sizes.xs),
      radius: Sizes.borderRadiusMd,
      backgroundColor: dark ?  TColors.white.withOpacity(0.1)
                : TColors.black.withOpacity(0.1),
                showBorder: true,
                borderColor: TColors.primary,
      width: screenWidth * 0.90,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              //image
              Container(
                height: screenHeight * 0.05,
                width: screenHeight * 0.05,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: dark ? Colors.black : Colors.white),
                child: Center(
                  child: Image.asset(
                    profileImage,
                  height: screenHeight * 0.045,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              //name and service
              const SizedBox(width: Sizes.xs,),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
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
              )
            ],
          ),

          //amount and duration
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\u20A615,350.00',
                style: Theme.of(context).textTheme.labelSmall!.copyWith(fontFamily: 'JosefinSans',),
              ),
            ],
          )
        ],
      ),
    );
  }
}
