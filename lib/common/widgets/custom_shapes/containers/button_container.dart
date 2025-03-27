import 'package:flutter/material.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_function.dart';
import 'rounded_container.dart';

class ButtonContainer extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final Color backgroundColor;
  const ButtonContainer({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor = TColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final dark = THelperFunctions.isDarkMode(context);
    return SizedBox(
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.all(Sizes.spaceBtwItems),
        color:
            dark
                ? TColors.white.withOpacity(0.1)
                : TColors.black.withOpacity(0.1),
        child: SizedBox(
          width: double.infinity,
          child: GestureDetector(
            onTap: onPressed,
            child: RoundedContainer(
              height: screenHeight * 0.05,
              padding: const EdgeInsets.all(Sizes.sm),
              backgroundColor: backgroundColor,
              child: Center(
                child: Text(
                  text,
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge!.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DoubleButtonContainer extends StatelessWidget {
  final VoidCallback? onPressed;
  final VoidCallback? onPressed2;
  final Widget child;
  final Color backgroundColor;
  final Widget child2;
  final Color backgroundColor2;
  const DoubleButtonContainer({
    super.key,
    this.onPressed,
    required this.child,
    required this.backgroundColor,
    required this.child2,
    required this.backgroundColor2,
    this.onPressed2,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final dark = THelperFunctions.isDarkMode(context);
    return SizedBox(
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.all(Sizes.spaceBtwItems),
        color:
            dark
                ? TColors.white.withOpacity(0.1)
                : TColors.black.withOpacity(0.1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: screenWidth * 0.55,
              child: GestureDetector(
                onTap: onPressed,
                child: RoundedContainer(
                  height: screenHeight * 0.05,
                  padding: const EdgeInsets.all(Sizes.sm),
                  backgroundColor: backgroundColor,
                  child: Center(child: child),
                ),
              ),
            ),

            SizedBox(
              width: screenWidth * 0.15,
              child: GestureDetector(
                onTap: onPressed2,
                child: RoundedContainer(
                  height: screenHeight * 0.05,
                  padding: const EdgeInsets.all(Sizes.sm),
                  backgroundColor: backgroundColor2,
                  child: Center(child: child2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
