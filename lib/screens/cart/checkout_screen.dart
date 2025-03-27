import 'package:flutter/material.dart';

import '../../common/widgets/appbar/appbar.dart';
import '../../common/widgets/custom_shapes/containers/button_container.dart';
import '../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../common/widgets/texts/section_heading.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/helpers/helper_function.dart';
// import '../payment/payment_screen.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return SafeArea(
      child: Scaffold(
        appBar: TAppBar(
          title: Text(
            'Checkout',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          showBackArrow: true,
        ),
        bottomNavigationBar: ButtonContainer(
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => const PaymentScreen()),
            // );
          },
          text: 'Checkout',
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Sizes.spaceBtwItems),
            child: Column(
              children: [
                RoundedContainer(
                  backgroundColor:
                      dark
                          ? Colors.white.withOpacity(0.1)
                          : Colors.black.withOpacity(0.1),
                  padding: const EdgeInsets.all(Sizes.sm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionHeading(title: 'Address', showActionButton: false),

                      const SizedBox(height: Sizes.sm),
                      Row(
                        children: [
                          Icon(Icons.location_on, color: Colors.red[900]),
                          Text(
                            '234, White Heart Lane THSP. KU',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ],
                      ),

                      const SizedBox(height: Sizes.sm),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(width: 10),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'Change',
                              style: Theme.of(context).textTheme.labelSmall!
                                  .copyWith(color: TColors.primary),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: Sizes.spaceBtwItems),
                SectionHeading(title: 'Promo Code', showActionButton: false),

                const SizedBox(height: Sizes.sm),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter promo code',
                    hintStyle: Theme.of(context).textTheme.labelSmall,
                    border: InputBorder.none,
                  ),
                ),

                const SizedBox(height: Sizes.spaceBtwSections),
                RoundedContainer(
                  backgroundColor:
                      dark
                          ? Colors.white.withOpacity(0.1)
                          : Colors.black.withOpacity(0.1),
                  padding: const EdgeInsets.all(Sizes.xs),
                  child: Column(
                    children: [

                      const SizedBox(height: Sizes.spaceBtwItems),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Subtotal:',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          Text(
                            '\u20A6152,799',
                            style: Theme.of(context).textTheme.labelMedium!.copyWith(fontFamily: "JosefinSans",),
                          ),
                        ],
                      ),

                      const SizedBox(height: Sizes.spaceBtwItems),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Items:',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          Text(
                            '5',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ],
                      ),

                      const SizedBox(height: Sizes.spaceBtwItems),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total:',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          Text(
                            '\u20A6152,799',
                            style: Theme.of(context).textTheme.labelMedium!
                                .copyWith(fontFamily: "JosefinSans", color: TColors.success),
                          ),
                        ],
                      ),

                      const SizedBox(height: Sizes.sm),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
