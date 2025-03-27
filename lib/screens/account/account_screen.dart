import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../common/widgets/appbar/appbar.dart';
import '../../common/widgets/list_tile/settings_menu_tile.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
import '../product/products_page.dart';
import '../sub_categories/user_orders.dart';
import 'upload_product_screen.dart';
import 'widgets/account_menu.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String firstname = '';
  String lastname = '';
  bool admin = false;
  FlutterSecureStorage storage = FlutterSecureStorage();
  final String userUrl = dotenv.env['USER_URL'] ?? 'https://defaulturl.com/api';

  @override
  void initState() {
    super.initState();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    try {
      final token = await storage.read(key: 'token');
      final response = await http.get(
        Uri.parse(userUrl),
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          firstname = data['firstname'];
          lastname = data['lastname'];
          admin = data['admin'];
        });
      } else {
        print(response.body);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unable to load this page, try again')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          'Account',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(Sizes.spaceBtwItems),
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.10),

                Text(
                  'Hi, $firstname $lastname',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),

                const SizedBox(height: Sizes.spaceBtwItems),
                admin
                    ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UploadProductScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Add new product',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ),

                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductsPage(),
                              ),
                            );
                          },
                          child: Text(
                            'categories',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ),
                      ],
                    )
                    : SizedBox.shrink(),
                const SizedBox(height: Sizes.spaceBtwItems),

                const SizedBox(height: Sizes.spaceBtwSections),
                SettingsMenuTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UserOrdersPage(),
                      ),
                    );
                  },
                  icon: Icons.circle,
                  title: "History",
                  subTitle: "Recent Orders",
                  trailing: const Icon(Icons.arrow_right, size: Sizes.iconMd),
                ),

                const SizedBox(height: Sizes.sm),
                const AccountMenu(),

                const SizedBox(height: Sizes.spaceBtwSections),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Logout",
                    style: Theme.of(
                      context,
                    ).textTheme.labelMedium!.copyWith(color: TColors.primary),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
