import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../common/widgets/custom_shapes/containers/semi_curved_container.dart';
import '../../../common/widgets/layouts/grid_layout.dart';
import '../../../common/widgets/layouts/listvew.dart';
import '../../../controllers/products/products_category_controller.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_function.dart';
import '../category_products_page.dart';
import 'products_details_screen.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

class CategoryGridview extends ConsumerStatefulWidget {
  const CategoryGridview({super.key});

  @override
  CategoryGridviewState createState() => CategoryGridviewState();
}

class CategoryGridviewState extends ConsumerState<CategoryGridview> {
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
    return Column(
      children: [
        // Search Bar
        TextField(
          onChanged: (value) {
            ref.read(searchQueryProvider.notifier).state =
                value; // Update state
            controller.filterProducts(value);
          },
          decoration: InputDecoration(
            hintText: 'Search by name or price...',
            hintStyle: Theme.of(context).textTheme.labelSmall,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        const SizedBox(height: Sizes.spaceBtwItems),

        // Conditional UI Display Logic
        state.isLoading
            ? Center(child: CircularProgressIndicator())
            : searchQuery.isNotEmpty && state.filteredProducts.isNotEmpty
                ? HomeListView(
                  itemCount: state.filteredProducts.length,
                  scrollDirection: Axis.vertical,
                  scrollPhysics: const NeverScrollableScrollPhysics(),
                  seperatorBuilder:
                      (context, index) =>
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
                            builder:
                                (context) => ProductDetailsScreen(
                                  product: product,
                                ),
                          ),
                        );
                      },
                      child: SemiCurvedContainer(
                        padding: const EdgeInsets.all(Sizes.sm),
                        backgroundColor:
                            dark
                                ? Colors.white.withOpacity(0.1)
                                : Colors.black.withOpacity(0.1),
                        child: ListTile(
                          leading: Text(
                            product['productName'],
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          trailing: Text(
                            '₦$productPrice',
                            style: Theme.of(context).textTheme.labelSmall,
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
                            builder:
                                (context) => CategoryProductsPage(
                                  category: category,
                                  products:
                                      state.categories[index]['products'],
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
                            style: Theme.of(context).textTheme.labelSmall!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  },
                ),
      ],
    );
  }
}
