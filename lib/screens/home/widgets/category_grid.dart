import 'package:flutter/material.dart';
import '../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../common/widgets/layouts/grid_layout.dart';
import '../../../utils/constants/colors.dart';

class CategoryGrid extends StatefulWidget {
  const CategoryGrid({super.key});

  @override
  State<CategoryGrid> createState() => _CategoryGridState();
}

class _CategoryGridState extends State<CategoryGrid> {
  final List<String> categoryText = [
    "Accessories", "Bags", "Jewelry", "Shirts", "Shoes", "Watches", 
  ];

  
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    
    return GridLayout(
      crossAxisCount: 3,
      itemCount: categoryText.length,
      mainAxisExtent: screenHeight * 0.14,
      itemBuilder: (context, index)  {
        return RoundedContainer(
          backgroundColor: TColors.primary.withOpacity(0.5),
          height: screenHeight * 0.14,
          width: screenWidth * 0.20,
          child: Center(
            child: Text(categoryText[index],
            style: Theme.of(context).textTheme.labelSmall!.copyWith(color: Colors.white),),
          )
        );
      }
    );
  }
}