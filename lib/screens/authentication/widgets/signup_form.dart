import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import '../../../controllers/auth/signup_controller.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_function.dart';
import '../../../utils/validators/validation.dart';

class SignupUserForm extends ConsumerWidget {
  const SignupUserForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signinState = ref.watch(signupControllerProvider);
    final signupController = ref.read(signupControllerProvider.notifier);
    final dark = THelperFunctions.isDarkMode(context);
    final formKey = GlobalKey<FormState>();
    final firstnameController = TextEditingController();
    final lastnameController = TextEditingController();
    final usernameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    final hidePassword = ValueNotifier<bool>(true);
    final hideConfirmPassword = ValueNotifier<bool>(true);

    return Form(
          key: formKey,
      child: Column(
        children: [
          // username field
          const SizedBox(height: Sizes.spaceBtwItems),
          BuildTextfield(
            controller: firstnameController,
            icon: Iconsax.user,
            hint: 'firstname',
            validator: (value) {
              Validator.validateTextField(value);
              return null;
            }
          ),

          //lastname
          const SizedBox(
            height: Sizes.spaceBtwItems,
          ),
          BuildTextfield(
            controller: lastnameController,
            icon: Iconsax.user,
            hint: 'lastname',
            validator: (value) {
              Validator.validateTextField(value);
              return null;
            }
          ),

          const SizedBox(
            height: Sizes.spaceBtwItems,
          ),
          // Username Field
          BuildTextfield(
            controller: usernameController,
            icon: Iconsax.user,
            hint: 'username',
            validator: (value) {
              Validator.validateTextField(value);
              return null;
            }
          ),
          const SizedBox(height: Sizes.spaceBtwItems),
          // Email Field
          BuildTextfield(
            controller: emailController,
            icon: Iconsax.direct,
            hint: 'email',
            isEmail: true,
            validator: (value) {
             Validator.validateEmail(value);
             return null;
             }
          ),

          // Password field
          const SizedBox(height: Sizes.spaceBtwItems),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Sizes.borderRadiusLg),
              color: dark ? TColors.dark : TColors.light,
            ),
            child: ValueListenableBuilder<bool>(
              valueListenable: hidePassword,
              builder: (context, value, child) {
                return TextFormField(
                  controller: passwordController,
                  obscureText: value,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: const Icon(Iconsax.password_check),
                    hintText: 'password',
                    hintStyle: Theme.of(context).textTheme.labelSmall,
                    suffixIcon: IconButton(
                      onPressed: () => hidePassword.value = !value,
                      icon: Icon(value ? Iconsax.eye_slash : Iconsax.eye),
                    ),
                  ),
                  validator: (value) {
                    Validator.validatePassword(value);
                    return null;
                    }
                );
              },
            ),
          ),

          // Confirm Password field
          const SizedBox(height: Sizes.spaceBtwItems),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Sizes.borderRadiusLg),
              color: dark ? TColors.dark : TColors.light,
            ),
            child: ValueListenableBuilder<bool>(
              valueListenable: hideConfirmPassword,
              builder: (context, value, child) {
                return TextFormField(
                  controller: confirmPasswordController,
                  obscureText: value,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: const Icon(Iconsax.password_check),
                    hintText: 'password',
                    hintStyle: Theme.of(context).textTheme.labelSmall,
                    suffixIcon: IconButton(
                      onPressed: () => hideConfirmPassword.value = !value,
                      icon: Icon(value ? Iconsax.eye_slash : Iconsax.eye),
                    ),
                  ),
                  validator: (value) {
                    if (value != passwordController.text) {
                      return 'passwords do not match';
                    }
                    return null;
                  }
                );
              },
            ),
          ),


          // Sign-in button
          const SizedBox(height: Sizes.spaceBtwSections),
          signinState.isLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(Sizes.spaceBtwItems),
                  child: SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: TColors.primary,
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          signupController.signup(
                            context,
                            firstnameController.text,
                            lastnameController.text,
                            usernameController.text,
                            emailController.text,
                            passwordController.text);
                        }
                        
                      },
                      child: Text(
                        'Signup',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  ),
                ),
          if (signinState.error != null)
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                signinState.error!,
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );
  }
}


class BuildTextfield extends StatelessWidget {
  const BuildTextfield(
      {super.key,
      required this.controller,
      required this.icon,
      required this.hint,
      this.isEmail = false,  this.validator
      });

  final TextEditingController controller;
  final IconData icon;
  final String hint;
  final bool isEmail;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Container(
      decoration: BoxDecoration(
        color: dark ? TColors.dark : TColors.light,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            size: Sizes.iconSm,
            color: dark ? TColors.light : TColors.dark,
          ),
          contentPadding: const EdgeInsets.all(2),
          border: InputBorder.none,
          hintText: hint,
          hintStyle: Theme.of(context).textTheme.labelSmall,
        ),
        validator: validator,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      ),
    );
  }
}
