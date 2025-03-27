import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../common/widgets/appbar/appbar.dart';
import '../../common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../common/widgets/layouts/grid_layout.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/helpers/helper_function.dart';
import 'products_category_admin.dart';
import 'widgets/image_view.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  ProductsPageState createState() => ProductsPageState();
}

class ProductsPageState extends State<ProductsPage> {
  List<dynamic> categories = [];
  List<dynamic> allProducts = [];
  List<dynamic> filteredProducts = [];
  TextEditingController searchController = TextEditingController();

  final String baseUrl = dotenv.env['CATEGORY_URL'] ?? 'https://defaulturl.com/api';

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    final response = await http.get(
      Uri.parse(baseUrl),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        categories = data;
        allProducts = data.expand((category) => category['products']).toList();
      });
    } else {
      throw Exception('Failed to load categories');
    }
  }

  void filterProducts(String query) {
  setState(() {
    filteredProducts = allProducts.where((product) {
      final productName = product['productName'].toString().toLowerCase();
      final productPrice = product['productPrice'].toString().toLowerCase();
      final List<dynamic> tags = product['tags'] ?? []; // Ensure tags is a list
      final searchQuery = query.toLowerCase();

      // Convert tags to lowercase for comparison
      final tagMatch = tags.any((tag) => tag.toString().toLowerCase().contains(searchQuery));

      return productName.contains(searchQuery) ||
          productPrice.contains(searchQuery) ||
          tagMatch;
    }).toList();
  });
}


  @override
  Widget build(BuildContext context) {
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
            TextField(
              controller: searchController,
              onChanged: filterProducts,
              decoration: InputDecoration(
                hintText: 'Search by name or price...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: Sizes.spaceBtwItems),
            if (searchController.text.isNotEmpty && filteredProducts.isNotEmpty)
              Expanded(
                child: ListView.separated(
                  itemCount: filteredProducts.length,
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: Sizes.sm);
                  },
                  itemBuilder: (context, index) {
                    final product = filteredProducts[index];
                    String productPrice = NumberFormat(
                      '#,##0.00',
                    ).format(product['productPrice']);
                    return RoundedContainer(
                      padding: const EdgeInsets.all(Sizes.sm),
                      backgroundColor:
                          dark
                              ? Colors.white.withOpacity(0.1)
                              : Colors.black.withOpacity(0.1),
                      child: ListTile(
                        leading: Text(product['productName'],
                        style: Theme.of(context).textTheme.labelSmall,),
                        trailing: Text('\u20A6$productPrice',
                        style: Theme.of(context).textTheme.labelSmall,),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ImageView(product: product),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              )
            else
              Expanded(
                child:
                    categories.isEmpty
                        ? Center(child: CircularProgressIndicator())
                        : GridLayout(
                          crossAxisCount: 3,
                          mainAxisExtent: screenHeight * 0.14,
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            final category =
                                categories[index]['productCategory'];

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => ProductsCategoryAdmin(
                                          category: category,
                                          products:
                                              categories[index]['products'],
                                        ),
                                  ),
                                );
                              },
                              child: RoundedContainer(
                                backgroundColor: TColors.primary,
                                height: screenHeight * 0.10,
                                width: screenWidth * 0.20,
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
