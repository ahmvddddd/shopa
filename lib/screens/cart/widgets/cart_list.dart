import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../../common/widgets/appbar/appbar.dart';
import '../../../common/widgets/custom_shapes/containers/button_container.dart';
import '../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../common/widgets/custom_shapes/containers/semi_curved_container.dart';
import '../../../common/widgets/texts/section_heading.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_function.dart';
import '../../../controllers/auth/userId_controller.dart';
import '../../payment/payment_screen.dart';

class CheckoutPage extends StatefulWidget {
  final String userId;

  const CheckoutPage({super.key, required this.userId});

  @override
  CheckoutPageState createState() => CheckoutPageState();
}

class CheckoutPageState extends State<CheckoutPage> {
  List<dynamic> cartItems = [];
  double totalAmount = 0.0;
  bool isLoading = true;
  String errorMessage = '';
  String currentUserId = '';
  TextEditingController addressController = TextEditingController();
  final UserIdService userIdService = UserIdService();
  final String fetchOrderTotalUrl = dotenv.env['FETCH_ORDER_TOTAL'] ?? 'https://defaulturl.com/api';
  final String placeOrderUrl = dotenv.env['PLACE_ORDER'] ?? 'https://defaulturl.com/api';

  @override
  void initState() {
    super.initState();
    fetchOrderTotal();
  }

  Future<void> fetchOrderTotal() async {
    final url = Uri.parse(
      '$fetchOrderTotalUrl${widget.userId}',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          totalAmount = data['totalAmount'];
          cartItems = data['items'];
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = jsonDecode(response.body)['message'];
          isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        errorMessage = 'Failed to load checkout details';
        isLoading = false;
      });
    }
  }

  Future<void> placeOrder(List<dynamic> products, double totalAmount) async {
    try {
      await getCurrentUserId();
      final response = await http.post(
        Uri.parse(placeOrderUrl),
        body: json.encode({
          "userId": currentUserId,
          "products": products,
          "totalAmount": totalAmount,
          "deliveryStatus": "pending",
        }),
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Your order has been placed. Proceed to payment page',
            ),
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => PaymentScreen(
                  products: cartItems,
                  totalAmount: totalAmount,
                ),
          ),
        );
      } else if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Your order has been placed. Proceed to payment page',
            ),
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => PaymentScreen(
                  products: cartItems,
                  totalAmount: totalAmount,
                ),
          ),
        );
      } else {
        print(response.body);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unable to place order, try again')),
      );
    }
  }

  Future<void> getCurrentUserId() async {
    final userId = await userIdService.getCurrentUserId();
    setState(() {
      currentUserId = userId!;
    });
  }

  @override
  Widget build(BuildContext context) {
    double shipping = 10000;
    double total = totalAmount + shipping;
    String grandTotal = NumberFormat('#,##0.00').format(total);
    String shippingFee = NumberFormat('#,##0.00').format(shipping);
    String subTotal = NumberFormat('#,##0.00').format(totalAmount);
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
          placeOrder(cartItems, totalAmount);
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
                itemCount: cartItems.length,
                physics: NeverScrollableScrollPhysics(),
                separatorBuilder:
                    (context, index) => const SizedBox(height: Sizes.sm),
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : cartItems.isEmpty
                      ? Center(
                        child: Text(
                          'Your cart is empty',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      )
                      : errorMessage.isNotEmpty
                      ? Center(child: Text(errorMessage))
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
