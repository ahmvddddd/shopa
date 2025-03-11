import 'package:flutter/material.dart';

import '../../common/widgets/appbar/appbar.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
import 'widgets/account_menu.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: TAppBar(
        title: Text('Settings',
        style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(Sizes.spaceBtwItems),
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.30),
                const AccountMenu(),

                const SizedBox(height: Sizes.spaceBtwSections),
                TextButton(
                  onPressed: () {},
                  child:Text(
                      "Logout",
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(color: TColors.primary),
                    ),
                )
              ],
            )
          ),
        ),
      ),
    );
  }
}