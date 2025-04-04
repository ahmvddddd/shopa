import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../common/widgets/appbar/appbar.dart';
import '../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../common/widgets/layouts/grid_layout.dart';
import '../../controllers/products/products_category_controller.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/helpers/helper_function.dart';
import 'products_category_admin.dart';
import 'widgets/image_view.dart';

class CategoryGridViewAdmin extends ConsumerStatefulWidget {
  const CategoryGridViewAdmin({super.key});

  @override
  ConsumerState<CategoryGridViewAdmin> createState() => _CategoryGridViewAdminState();
}

class _CategoryGridViewAdminState extends ConsumerState<CategoryGridViewAdmin> {

  final searchQueryProvider = StateProvider<String>((ref) => '');
  
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(categoryProductsProvider.notifier).fetchCategories());
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(categoryProductsProvider);
    final controller = ref.read(categoryProductsProvider.notifier);
    final searchQuery = ref.watch(searchQueryProvider);
    final dark = THelperFunctions.isDarkMode(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          'Products',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.spaceBtwItems),
        child: Column(
          children: [
            // Search Bar
            TextField(
              onChanged: (value) {
                ref.read(searchQueryProvider.notifier).state = value; // Update state
                controller.filterProducts(value);
              },
              decoration: InputDecoration(
                hintText: 'Search by name or price...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: Sizes.spaceBtwItems),

            
            state.isLoading
                ? Expanded(child: Center(child: CircularProgressIndicator()))
                : Expanded(
                    child: searchQuery.isNotEmpty &&
                            state.filteredProducts.isNotEmpty
                        ? ListView.separated(
                            itemCount: state.filteredProducts.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: Sizes.sm),
                            itemBuilder: (context, index) {
                              final product = state.filteredProducts[index];
                              String productPrice = NumberFormat(
                                '#,##0.00',
                              ).format(product['productPrice']);
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ImageView(product: product),
                                    ),
                                  );
                                },
                                child: RoundedContainer(
                                  padding: const EdgeInsets.all(Sizes.sm),
                                  backgroundColor: dark
                                      ? Colors.white.withOpacity(0.1)
                                      : Colors.black.withOpacity(0.1),
                                  child: ListTile(
                                    leading: Text(
                                      product['productName'],
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                    ),
                                    trailing: Text(
                                      '₦$productPrice',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : GridLayout(
                            crossAxisCount: 3,
                            mainAxisExtent: screenHeight * 0.10,
                            itemCount: state.categories.length,
                            itemBuilder: (context, index) {
                              final category =
                                  state.categories[index]['productCategory'];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ProductsCategoryAdmin(
                                        category: category,
                                        products: state.categories[index]
                                            ['products'],
                                      ),
                                    ),
                                  );
                                },
                                child: RoundedContainer(
                                  backgroundColor: TColors.primary,
                                  height: screenHeight * 0.10,
                                  width: screenWidth * 0.16,
                                  child: Center(
                                    child: Text(
                                      category,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall!
                                          .copyWith(color: Colors.white),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
          ],
        ),
      ),
    );

  }
}