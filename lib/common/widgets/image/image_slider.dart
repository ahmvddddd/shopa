import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';

class ImageSlider extends StatefulWidget {

  const ImageSlider({super.key});

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  final List<Map<String, String>> products = [
    {
      'image': Images.promoBanner1,
      'name': 'Burberry Men\s T-Shirt',
      'specs': 'L-83cm, W-45cm LB-0.88',
      'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'price': '\u20A612,000'
    },
    {
      'image': Images.promoBanner2,
      'name': 'Essetianls Me\'ns T-Shirts',
      'specs': 'L-83cm, W-45cm LB-0.88',
      'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'price': '\u20A615,000'
    },
    {
      'image': Images.promoBanner3,
      'name': 'Nike Air Max Shoes',
      'specs': 'L-14cm, W-5cm LB-0.97',
      'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'price': '\u20A6215,000'
    },
  ];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return  Column(
        children: [
          SizedBox(height: 20),
          CarouselSlider(
            options: CarouselOptions(
              height: screenHeight * 0.30,
              autoPlay: true,
              enlargeCenterPage: true,
              enableInfiniteScroll: true,
              viewportFraction: 0.8,
            ),
            items: products.map((products) {
              return Column(
                children: [
                  ClipRRect(
              borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      products['image']!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),

                  const SizedBox(height: Sizes.sm,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        products['name']!,
                        style: Theme.of(context).textTheme.labelLarge
                      ),
                      SizedBox(height: 5),
                      Text(
                        products['specs']!,
                        style: Theme.of(context).textTheme.labelMedium
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(Icons.note, size: Sizes.iconXs),
                          SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              products['description']!,
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(overflow: TextOverflow.ellipsis)
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        products['price']!,
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.bold)
                      ),
                    ],
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      );
  }
}

