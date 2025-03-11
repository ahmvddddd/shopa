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
    this.backgroundColor = TColors.primary
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final dark = THelperFunctions.isDarkMode(context);
    return SizedBox(
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.all(Sizes.spaceBtwItems),
        color: dark ?  TColors.white.withOpacity(0.1)
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
                              child: Text(text,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(color: Colors.white))),
                        ),
          ),
        ),
      ),
    );
  }
}
