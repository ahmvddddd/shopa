import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/widgets/appbar/appbar.dart';
import '../../common/widgets/custom_shapes/containers/button_container.dart';
import '../../common/widgets/custom_shapes/containers/semi_curved_container.dart';
import '../../controllers/cart/cart_products_controller.dart';
import '../../controllers/cart/clear_cart_controller.dart';
import '../../controllers/cart/remove_from_cart_controller.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/helpers/helper_function.dart';
import '../../controllers/auth/userId_controller.dart';
import '../../utils/constants/colors.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'widgets/cart_list.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  CartPageState createState() => CartPageState();
}

class CartPageState extends ConsumerState<CartScreen> {
  String currentUserId = '';
  final UserIdService userIdService = UserIdService();
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
  Future.microtask(() {
    ref.read(cartProductsProvider.notifier).fetchProducts();
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
    final dark = THelperFunctions.isDarkMode(context);
    final cartProductsController = ref.watch(cartProductsProvider);
    final removeController = ref.read(removeFromCartProvider);
    final clearController = ref.read(clearCartProvider);
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
              clearController.clearCart();
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
            cartProductsController.isLoading
                ? const Center(child: CircularProgressIndicator())
                : cartProductsController.cartItems.isEmpty
                ? Center(
                  child: Text(
                    'No items in your cart',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                )
                : ListView.separated(
                  itemCount: cartProductsController.cartItems.length,
                  separatorBuilder:
                      (context, index) => const SizedBox(height: Sizes.sm),
                  itemBuilder: (context, index) {
                    final item = cartProductsController.cartItems[index];
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
                          item['productName'] ?? 'no name',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        subtitle: Text(
                          '\u20A6${item['productPrice']}',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.cancel, color: Colors.red[900]),
                          onPressed: () {
                            removeController.removeFromCart(productId);
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