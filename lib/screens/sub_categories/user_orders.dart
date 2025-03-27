import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../common/widgets/appbar/appbar.dart';
import '../../common/widgets/custom_shapes/containers/semi_curved_container.dart';
import '../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/helpers/helper_function.dart';
import '../../controllers/auth/userId_controller.dart';

class UserOrdersPage extends StatefulWidget {
  const UserOrdersPage({super.key,});

  @override
  UserOrdersPageState createState() => UserOrdersPageState();
}

class UserOrdersPageState extends State<UserOrdersPage> {
  List orders = [];
  bool isLoading = true;String currentUserId = '';
  final UserIdService userIdService = UserIdService();
  final String fetchUserOrdersUrl = dotenv.env['FETCH_USER_ORDERS'] ?? 'https://defaulturl.com/api';

  @override
  void initState() {
    super.initState();
    fetchUserOrders();
  }

  Future<void> fetchUserOrders() async {
    await getCurrentUserId();
    final String apiUrl = '$fetchUserOrdersUrl$currentUserId';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        setState(() {
          orders = json.decode(response.body);
          isLoading = false;
        });
      } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unable to load this page. Try again'))
      );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unable to load this page. Try again'))
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: TAppBar(
        title: Text('Orders',
        style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.spaceBtwItems),
        child: isLoading
              ? Center(child: CircularProgressIndicator())
                  : orders.isEmpty
                      ? Center(child: Text('No orders found'))
                      : RoundedContainer(
            backgroundColor: dark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.1),
            padding: const EdgeInsets.all(Sizes.spaceBtwItems),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: orders.length,
                                itemBuilder: (context, index) {
                                  var order = orders[index];
                                  var products = order['products'] as List;
                                  String totalAmount = NumberFormat('#,##0.00',).format(order['totalAmount']);
                                  
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Order ID:' ,
                                              style: Theme.of(context).textTheme.labelMedium),
                                          Text('${order['_id']}',
                                              style: Theme.of(context).textTheme.labelMedium),
                                        ],
                                      ),

                                      const SizedBox(height: Sizes.sm),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Total:',
                                              style: Theme.of(context).textTheme.labelMedium),
                                          Text('\u20A6$totalAmount',
                                              style: Theme.of(context).textTheme.labelMedium),
                                        ],
                                      ),

                                      const SizedBox(height: Sizes.sm),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Status:',
                                              style: Theme.of(context).textTheme.labelMedium),
                                          Text('${order['deliveryStatus']}',
                                              style: Theme.of(context).textTheme.labelMedium),
                                        ],
                                      ),

                                      SizedBox(height: Sizes.md),
                                      SizedBox(
                                        height: screenHeight * 0.20,
                                        child: ListView.separated(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: products.length,
                                          separatorBuilder: (context, index) {
                                            return const SizedBox(width: Sizes.sm,);
                                          },
                                          itemBuilder: (context, productIndex) {
                                            var product = products[productIndex];
                                  String productPrice = NumberFormat('#,##0.00',).format(product['productPrice']);
                        
                                            return SemiCurvedContainer(
                                              width: screenWidth * 0.30,
                                              backgroundColor: dark ? Colors.black : Colors.white,
                                              padding: const EdgeInsets.all(Sizes.sm),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Text(product['productName'],
                                                  style: Theme.of(context).textTheme.labelMedium,
                                                  textAlign: TextAlign.center,
                                                  softWrap: true,
                                                  maxLines: 2,),

                                                  const SizedBox(height: Sizes.sm,),
                                                  Text(
                                                      '\u20A6$productPrice',
                                                  style: Theme.of(context).textTheme.labelLarge!.copyWith(fontFamily: "JosefinSans", color: TColors.primary),),

                                                  const SizedBox(height: Sizes.md,),
                                                  Text('${product['quantity']} X',
                                                  style: Theme.of(context).textTheme.labelLarge!.copyWith( color: TColors.success),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(Sizes.spaceBtwItems),
                                        child: Divider(color: TColors.primary,),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
      ),
    );
  }
}
