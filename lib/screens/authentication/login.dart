import 'package:flutter/material.dart';
import '../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/helpers/helper_function.dart';
import 'widgets/login_form.dart';

class SigninScreen extends StatelessWidget {
  final VoidCallback toggleScreen;
  const SigninScreen({super.key, required this.toggleScreen});

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
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    'Welcome, signin to your account and shop quality products',
                    style: Theme.of(context).textTheme.labelMedium,
                    softWrap: true,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                ),
            
                
            
                const SizedBox(height: Sizes.spaceBtwSections),
                const SigninForm(),
            
                const SizedBox(
                  height: Sizes.spaceBtwSections,
                ),
                SizedBox(
                  width: screenWidth * 0.90,
                  child: Text(
                    'Create An Account',
                    style: Theme.of(context).textTheme.labelMedium,
                    softWrap: true,
                    maxLines: 2,
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
                            child: Text('Signup',
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
