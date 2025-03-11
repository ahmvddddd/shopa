import 'package:flutter/material.dart';
import '../../common/widgets/appbar/appbar.dart';
import '../../common/widgets/custom_shapes/containers/button_container.dart';
import '../../utils/constants/sizes.dart';
import 'checkout_screen.dart';
import 'widgets/cart_list.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: TAppBar(
          title: Text('Cart',
          style: Theme.of(context).textTheme.headlineSmall,),
          showBackArrow: true,
        ),
        bottomNavigationBar: ButtonContainer(
          onPressed: () {
              Navigator.push(context, 
              MaterialPageRoute(builder: (context) => const CheckoutScreen()));
              },
          text: 'Checkout',
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Sizes.spaceBtwItems),
            child: Column(
              children: [
              const CartList(),
              ]
            ),
          ),
        ),
        ),
    );
  }
}