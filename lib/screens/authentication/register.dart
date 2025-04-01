import 'package:flutter/material.dart';
import '../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/helpers/helper_function.dart';
import 'widgets/signup_form.dart';

class SignupScreen extends StatelessWidget {
  final VoidCallback toggleScreen;
  const SignupScreen({super.key, required this.toggleScreen});

  @override
  Widget build(BuildContext context) {
   double screenWidth = MediaQuery.of(context).size.width;
   double screenHeight = MediaQuery.of(context).size.height;
   final dark = THelperFunctions.isDarkMode(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Sizes.spaceBtwItems),
            child: Column(
              children: [

                SizedBox(height: screenHeight * 0.10,),
                RoundedContainer(
                  height: screenHeight * 0.20,
                  radius: Sizes.cardRadiusMd,
                  backgroundColor: dark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.1),
                  child: Center(
                    child: Icon(Icons.lock,
                    color: TColors.primary,
                    size: screenHeight * 0.15
                    )
                  )
                ),
                const SizedBox(height: Sizes.spaceBtwItems),
                SizedBox(
                  width: screenWidth * 0.90,
                  child: Text(
                    'Create an account to shop quality products',
                    style: Theme.of(context).textTheme.labelMedium,
                    softWrap: true,
                    textAlign: TextAlign.center,
                  ),
                ),
      
                const SizedBox(height: Sizes.spaceBtwSections),
                const SignupUserForm(),
      
                const SizedBox(
                  height: Sizes.spaceBtwItems,
                ),
                SizedBox(
                  width: screenWidth * 0.90,
                  child: Text(
                    'Already a user ?',
                    style: Theme.of(context).textTheme.labelSmall,
                    softWrap: true,
                    textAlign: TextAlign.center,
                  ),
                ),
      
                //signup button
                const SizedBox(
                  height: Sizes.spaceBtwSections,
                ),
                Padding(
                  padding: const EdgeInsets.all(Sizes.spaceBtwItems),
                  child: SizedBox(
                      width: double.infinity,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Sizes.borderRadiusLg)
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent
                          ),
                            onPressed: toggleScreen,
                            child: Text('Signin',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall)),
                      ),
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

class SignupForm {
  const SignupForm();
}
