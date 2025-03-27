import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../common/widgets/appbar/appbar.dart';
import '../../common/widgets/custom_shapes/containers/button_container.dart';
import '../../common/widgets/custom_shapes/containers/semi_curved_container.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/helpers/helper_function.dart';
import '../../controllers/auth/userId_controller.dart';
import '../../utils/constants/colors.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'widgets/cart_list.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  CartPageState createState() => CartPageState();
}

class CartPageState extends State<CartScreen> {
  List<dynamic> cartItems = [];
  bool isLoading = true;
  String currentUserId = '';
  final UserIdService userIdService = UserIdService();
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final String fetchCartProductsUrl = dotenv.env['FETCH_CART_PRODUCTS'] ?? 'https://defaulturl.com/api';
  final String removeFromCartUrl = dotenv.env['REMOVE_FROM_CART'] ?? 'https://defaulturl.com/api';
  final String clearCartUrl = dotenv.env['CLEAR_CART'] ?? 'https://defaulturl.com/api';

  @override
  void initState() {
    super.initState();
    fetchCartProducts();
  }

  Future<void> fetchCartProducts() async {
    await getCurrentUserId();
    final url = Uri.parse('$fetchCartProductsUrl$currentUserId');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          cartItems = data['cart'];
          isLoading = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Unable to load cart products. Try again')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unable to load cart products. Try again')),
      );
    }
  }

  Future<void> removeFromCart(String productId) async {
    final token = await storage.read(key: 'token');
    if (token == null) return;
    try {
      final response = await http.post(
        Uri.parse(removeFromCartUrl),
        body: json.encode({"productId": productId}),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Item removed from cart')));
        fetchCartProducts();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to remove item from cart. Try again')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to remove item from cart. Try again')),
      );
    }
  }

  Future<void> clearCart() async {
    try {
      await getCurrentUserId();
      final response = await 
      http.post(
        Uri.parse(clearCartUrl),
        body: json.encode({"userId": currentUserId}),
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Your cart was cleared')));
        fetchCartProducts();
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
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          'Your Cart',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        showBackArrow: true,
        actions: [
          IconButton(
            onPressed: () {
              clearCart();
            },
            icon: Icon(Icons.delete, color: Colors.red[900], size: Sizes.iconMd),
          ),
        ],
      ),
      bottomNavigationBar: ButtonContainer(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CheckoutPage(userId: currentUserId),
            ),
          );
        },
        text: 'Checkout',
      ),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.spaceBtwItems),
        child:
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : cartItems.isEmpty
                ? Center(
                  child: Text(
                    'No items in your cart',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                )
                : ListView.separated(
                  itemCount: cartItems.length,
                  separatorBuilder:
                      (context, index) => const SizedBox(height: Sizes.sm),
                  itemBuilder: (context, index) {
                    final item = cartItems[index];
                    final productId = item['productId'];
                    return SemiCurvedContainer(
                      radius: Sizes.cardRadiusMd,
                      backgroundColor:
                          dark
                              ? Colors.white.withOpacity(0.1)
                              : Colors.black.withOpacity(0.1),
                      padding: const EdgeInsets.all(Sizes.xs),
                      child: ListTile(
                        leading: Text(
                          '${item['quantity']}X',
                          style: Theme.of(context).textTheme.bodySmall!
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
                        trailing: IconButton(
                          icon: Icon(Icons.cancel, color: Colors.red[900]),
                          onPressed: () {
                            removeFromCart(productId);
                            fetchCartProducts();
                          },
                        ),
                      ),
                    );
                  },
                ),
      ),
    );
  }
}
