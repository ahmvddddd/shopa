// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'dart:convert';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_function.dart';
import '../../custom_shapes/containers/button_container.dart';
import '../../custom_shapes/divider/custom_divider.dart';
import '../../layouts/listvew.dart';
import '../../texts/section_heading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ServiceProviderScreen extends StatefulWidget {
  final Map profiles;
  const ServiceProviderScreen({super.key, required this.profiles});

  @override
  State<ServiceProviderScreen> createState() => _ServiceProviderScreenState();
}

class _ServiceProviderScreenState extends State<ServiceProviderScreen> {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  // String? _currentUserId;

  @override
  void initState() {
    super.initState;
    getCurrentUserId();
  }

  Future<void> getCurrentUserId() async {
    try {
      final token = await _secureStorage.read(key: 'token');
      if (token != null) {
        // final decodedToken = parseJwt(token);
        setState(() {
          // _currentUserId = decodedToken['id'];
        });
      }
    } catch (e) {
      print('Error getting current user ID: $e');
    }
  }

  Map<String, dynamic> parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('Invalid token');
    }

    final payload = base64Url.decode(base64Url.normalize(parts[1]));
    final payloadMap =
        json.decode(utf8.decode(payload)) as Map<String, dynamic>;
    return payloadMap;
  }

  @override
  Widget build(BuildContext context) {
    final firstname = widget.profiles['firstname'];
    final lastname = widget.profiles['lastname'];
    final service = widget.profiles['service'];
    final bio = widget.profiles['bio'];
    final skills = widget.profiles['skills'];
    // .join(', ')

    final dark = THelperFunctions.isDarkMode(context);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: ButtonContainer(
          onPressed: () {},
          text: 'Hire',
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              //body
              Padding(
                padding: const EdgeInsets.all(Sizes.spaceBtwItems),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: Sizes.spaceBtwSections),

                    Column(
                      children: [
                        Text(
                          '$firstname $lastname',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        Text(
                          service,
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        Text(
                          'rating: 5.0',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        Text(
                          'location: 12, LA Boulevard W2 ABJ',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),

                    const SizedBox(height: Sizes.spaceBtwItems),
                    ElevatedButton(
                      onPressed: () { },
                      child: Text(
                        'Message',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),

                    //images
                    const CustomDivider(),

                    HomeListView(
                      sizedBoxHeight: screenHeight * 0.10,
                      scrollDirection: Axis.horizontal,
                      seperatorBuilder: (context, index) {
                        return const SizedBox(width: Sizes.sm);
                      },
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Container(
                            width: screenHeight * 0.10,
                            height: screenHeight * 0.13,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Sizes.borderRadiusLg),
                            ),
                            child: Image.asset(
                              Images.fashionDesigner,
                              fit: BoxFit.cover,
                            ));
                      },
                    ),

                    const CustomDivider(),

                    HomeListView(
                      sizedBoxHeight: screenHeight * 0.06,
                      scrollDirection: Axis.horizontal,
                      seperatorBuilder: (context, index) {
                        return const SizedBox(width: Sizes.sm);
                      },
                      itemCount: skills.length,
                      itemBuilder: (context, index) {
                        return null;
                      },
                    ),
                    const CustomDivider(),

                    Text(
                      bio,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),

                    const CustomDivider(),

                    const SectionHeading(
                      title: 'Certifications',
                      showActionButton: false,
                    ),
                    const SizedBox(
                      height: Sizes.sm,
                    ),
                    Container(
                      height: screenHeight * 0.055,
                      width: screenWidth * 0.325,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Sizes.borderRadiusMd),
                        color: dark
                            ? TColors.white.withOpacity(0.1)
                            : TColors.black.withOpacity(0.1),
                      ),
                      padding: const EdgeInsets.all(2),
                      child: Center(
                        child: Text(
                          'MCFE',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: Sizes.sm,
                    ),
                    SizedBox(
                      width: screenWidth * 0.90,
                      child: Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas at nunc tempus, semper nibh nec, lacinia nunc.',
                        style: Theme.of(context).textTheme.bodyMedium,
                        softWrap: true,
                      ),
                    ),
                    const SizedBox(
                      height: Sizes.sm,
                    ),
                    Container(
                      height: screenHeight * 0.055,
                      width: screenWidth * 0.325,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Sizes.borderRadiusMd),
                        color: dark
                            ? TColors.white.withOpacity(0.1)
                            : TColors.black.withOpacity(0.1),
                      ),
                      padding: const EdgeInsets.all(2),
                      child: Center(
                        child: Text(
                          'CSFP',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: Sizes.sm,
                    ),
                    SizedBox(
                      width: screenWidth * 0.90,
                      child: Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas at nunc tempus, semper nibh nec, lacinia nunc.',
                        style: Theme.of(context).textTheme.bodyMedium,
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
