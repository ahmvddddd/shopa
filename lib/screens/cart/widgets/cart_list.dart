import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../common/widgets/appbar/appbar.dart';
import '../../../common/widgets/custom_shapes/containers/button_container.dart';
import '../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../common/widgets/custom_shapes/containers/semi_curved_container.dart';
import '../../../common/widgets/texts/section_heading.dart';
import '../../../controllers/cart/checkout_controller.dart';
import '../../../controllers/cart/place_order_controller.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_function.dart';
import '../../../controllers/auth/userId_controller.dart';

class CheckoutPage extends ConsumerStatefulWidget {
  final String userId;

  const CheckoutPage({super.key, required this.userId});

  @override
  CheckoutPageState createState() => CheckoutPageState();
}

class CheckoutPageState extends ConsumerState<CheckoutPage> {
  String currentUserId = '';
  TextEditingController addressController = TextEditingController();
  final UserIdService userIdService = UserIdService();

  @override
  void initState() {
    super.initState();
  Future.microtask(() {
    ref.watch(checkoutProvider.notifier).fetchOrderTotal(context);
  });
  }

  Future<void> getCurrentUserId() async {
    final userId = await userIdService.getCurrentUserId();
    setState(() {
      currentUserId = userId!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final checkoutController = ref.watch(checkoutProvider);
    final plaOrderController = ref.read(placeOrderProvider);
    double shipping = 10000;
    double total = checkoutController.totalAmount + shipping;
    String grandTotal = NumberFormat('#,##0.00').format(total);
    String shippingFee = NumberFormat('#,##0.00').format(shipping);
    String subTotal = NumberFormat('#,##0.00').format(checkoutController.totalAmount);
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          'Checkout',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        showBackArrow: true,
      ),
      bottomNavigationBar: ButtonContainer(
        onPressed: () {
          plaOrderController.placeOrder(
            context,
          checkoutController.cartItems,
          checkoutController.totalAmount,
          );
        },
        text: 'Proceed',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.spaceBtwItems),
          child:
          Column(
            children: [
              ListView.separated(
                shrinkWrap: true,
                itemCount: checkoutController.cartItems.length,
                physics: NeverScrollableScrollPhysics(),
                separatorBuilder:
                    (context, index) => const SizedBox(height: Sizes.sm),
                itemBuilder: (context, index) {
                  final item = checkoutController.cartItems[index];
                  return checkoutController.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : checkoutController.cartItems.isEmpty
                      ? Center(
                        child: Text(
                          'Your cart is empty',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      )
                      : SemiCurvedContainer(
                        backgroundColor:
                            dark
                                ? Colors.white.withOpacity(0.1)
                                : Colors.black.withOpacity(0.1),
                        child: ListTile(
                          leading: Text(
                            '${item['quantity']}X',
                            style: Theme.of(context).textTheme.bodyMedium!
                                .copyWith(color: TColors.success),
                          ),
                          title: Text(
                            item['productName'],
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          subtitle: Text(
                            '\u20A6${item['productPrice']}',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                      );
                },
              ),

              const SizedBox(height: Sizes.spaceBtwSections),
              RoundedContainer(
                backgroundColor:
                    dark
                        ? Colors.white.withOpacity(0.1)
                        : Colors.black.withOpacity(0.1),
                padding: const EdgeInsets.all(Sizes.sm),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SectionHeading(
                      title: 'Delivery Address',
                      showActionButton: false,
                    ),

                    const SizedBox(height: Sizes.spaceBtwItems),
                    Padding(
                      padding: const EdgeInsets.only(left: 0.0),
                      child: TextField(
                        maxLines: 3,
                        minLines: 1,
                        controller: addressController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.location_on,
                            size: Sizes.iconSm,
                            color: Colors.red,
                          ),
                          hintText: 'Enter Address',
                          hintStyle: Theme.of(context).textTheme.labelSmall,
                        ),
                      ),
                    ),
                    const SizedBox(height: Sizes.sm),
                  ],
                ),
              ),

              const SizedBox(height: Sizes.spaceBtwSections),
              RoundedContainer(
                backgroundColor:
                    dark
                        ? Colors.white.withOpacity(0.1)
                        : Colors.black.withOpacity(0.1),
                padding: const EdgeInsets.all(Sizes.sm),
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
                          '\u20A6$subTotal',
                          style: Theme.of(context).textTheme.labelMedium!
                              .copyWith(fontFamily: "JosefinSans"),
                        ),
                      ],
                    ),

                    const SizedBox(height: Sizes.spaceBtwItems),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Shipping:',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        Text(
                          '\u20A6$shippingFee',
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
                          '\u20A6$grandTotal',
                          style: Theme.of(
                            context,
                          ).textTheme.labelLarge!.copyWith(
                            fontFamily: "JosefinSans",
                            color: TColors.success,
                          ),
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
    );
  }
}
