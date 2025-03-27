// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:iconsax/iconsax.dart';
import '../../common/widgets/appbar/appbar.dart';
import '../../common/widgets/custom_shapes/containers/button_container.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/helpers/helper_function.dart';
import '../../controllers/auth/userId_controller.dart';

class PaymentScreen extends StatefulWidget {
  final List<dynamic> products;
  final double totalAmount;
  const PaymentScreen({
    super.key,
    required this.products,
    required this.totalAmount,
  });

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  // double _balance = 0.0;
  final _cardNumberController = TextEditingController();
  final _cvvController = TextEditingController();
  final _expiryMonthController = TextEditingController();
  final _expiryYearController = TextEditingController();
  final _amountController = TextEditingController();
  final storage = const FlutterSecureStorage();
  String currentUserId = '';
  final UserIdService userIdService = UserIdService();
  final String placeOrderUrl = dotenv.env['PLACE_ORDER'] ?? 'https://defaulturl.com/api';


  @override
  void initState() {
    super.initState();
  }

  Future<void> placeOrder() async {
    try {
      await getCurrentUserId();
      final response = await http.post(
        Uri.parse(placeOrderUrl),
        body: json.encode({
          "userId": currentUserId,
          "products": widget.products,
          "totalAmount": widget.totalAmount,
          "deliveryStatus": "success",
        }),
        headers: {
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Your order would arrive soon. Thank you',
            ),
          ),
        );
        clearCart();
      } else {
        print(response.body);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unable to place order, try again')),
      );
    }
  }

  Future<void> clearCart() async {
    try {
      await getCurrentUserId();
      final response = await http.post(
        Uri.parse('http://localhost:3000/api/clear'),
        body: json.encode({
          "userId": currentUserId,
        }),
        headers: {
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Your cart was cleared',
            ),
          ),
        );
      } else {
        print(response.body);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unable to clear cart, try again')),
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
    final dark = THelperFunctions.isDarkMode(context);
    // String accountBalance = NumberFormat('#,##0.00').format(_balance);
    return Scaffold(
      appBar: TAppBar(
        title: Text('Pay', style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
      ),
      bottomNavigationBar: ButtonContainer(onPressed: () {
        placeOrder();
      }, 
      text: 'Pay'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.spaceBtwItems),
          child: Column(
            children: [
              const SizedBox(height: Sizes.spaceBtwSections),
              //card number
              Container(
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(color: dark ? Colors.white : Colors.black),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: TextField(
                    controller: _cardNumberController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Iconsax.card, size: Sizes.iconSm),
                      hintText: 'Card Number',
                      hintStyle: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                ),
              ),

              //cvv
              const SizedBox(height: Sizes.spaceBtwItems),
              Container(
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(color: dark ? Colors.white : Colors.black),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: TextField(
                    controller: _cvvController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Iconsax.card, size: Sizes.iconSm),
                      hintText: 'CVV',
                      hintStyle: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                ),
              ),

              // expiry date
              const SizedBox(height: Sizes.spaceBtwItems),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: dark ? Colors.white : Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 0.0),
                        child: TextFormField(
                          expands: false,
                          controller: _expiryMonthController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: const Icon(
                              Iconsax.calendar,
                              size: Sizes.iconSm,
                            ),
                            hintText: 'Expiry Month',
                            hintStyle: Theme.of(context).textTheme.labelSmall,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: Sizes.spaceBtwInputFields),
                  Expanded(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: dark ? Colors.white : Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 0.0),
                        child: TextFormField(
                          expands: false,
                          controller: _expiryYearController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: const Icon(
                              Iconsax.calendar,
                              size: Sizes.iconSm,
                            ),
                            hintText: 'Expiry Year',
                            hintStyle: Theme.of(context).textTheme.labelSmall,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              //amount
              const SizedBox(height: Sizes.spaceBtwItems),
              Container(
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(color: dark ? Colors.white : Colors.black),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: TextFormField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.money, size: Sizes.iconSm),
                      hintText: 'Amount',
                      hintStyle: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: Sizes.spaceBtwItems),
            ],
          ),
        ),
      ),
    );
  }
}
