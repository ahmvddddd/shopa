import 'package:flutter/material.dart';
import '../../common/widgets/appbar/appbar.dart';
import '../../common/widgets/custom_shapes/containers/payment_button.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/image_strings.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/helpers/helper_function.dart';
import 'widgets/product_specifications.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String selectedImage = '';
  List<String> images = [
    Images.hublot1,
    Images.hublot2,
    Images.hublot3,
    Images.hublot4,
  ];

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        bottomNavigationBar: const PaymentButton(
          text: 'Add to bag'
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              height: screenHeight * 0.28,
              decoration: BoxDecoration(
                  color: dark ? TColors.dark : TColors.light,
                  image: DecorationImage(
                    image: selectedImage.isEmpty
                        ? const AssetImage(
                            Images.hublot1,
                          )
                        : AssetImage(selectedImage),
                    fit: BoxFit.contain,
                  )),
              child: const Column(
                children: [
                  SizedBox(height: Sizes.xs),
                  TAppBar(
                    showBackArrow: true,
                  ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(Sizes.spaceBtwItems),
                child: Column(children: [
                  SizedBox(
                    height: 70,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: images.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedImage = images[index];
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(Sizes.sm),
                              child: Container(
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Sizes.borderRadiusLg),
                                    color: dark ? TColors.dark : TColors.light,
                                  ),
                                  child: Image.asset(images[index],
                                      height: 60, fit: BoxFit.contain)),
                            ),
                          );
                        }),
                  ),

                  //name and price
                  const SizedBox(height: Sizes.spaceBtwItems),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Hublot Black Magic',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '\u20A6350,000',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),

                  const SizedBox(
                    height: Sizes.spaceBtwItems,
                  ),
                  const Divider(),

                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas at nunc tempus, semper nibh nec, lacinia nunc.',
                    style: Theme.of(context).textTheme.bodySmall,
                    softWrap: true,
                  ),

                  const SizedBox(
                    height: Sizes.spaceBtwItems,
                  ),
                  const Divider(),

                  const ProductSpecifications(),

                  const SizedBox(
                    height: Sizes.spaceBtwItems,
                  ),
                  const Divider(),

                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas at nunc tempus, semper nibh nec, lacinia nunc.',
                    style: Theme.of(context).textTheme.labelSmall,
                    softWrap: true,
                  ),
                ])),
          ],
        )));
  }
}

