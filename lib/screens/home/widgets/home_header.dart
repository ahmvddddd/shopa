import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //avatar
        SizedBox(width: screenWidth * 0.3),

        //name
        Text('Chronometer', style: Theme.of(context).textTheme.headlineSmall),

        //cart
        GestureDetector(
          onTap: () {},
          child: Stack(
            children: [
              const Icon(Icons.shopping_cart, size: Sizes.iconMd),
              Positioned(
                right: -0.3,
                child: Container(
                  width: 15,
                  height: 15,
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: TColors.primary,
                  ),
                  child: Center(
                    child: Text(
                      '3',
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: Colors.white,
                        fontSize: 8,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
