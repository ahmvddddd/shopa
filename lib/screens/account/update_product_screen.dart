import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/widgets/appbar/appbar.dart';
import '../../common/widgets/custom_shapes/containers/button_container.dart';
import '../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../controllers/products/update_product_controller.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';

class UpdateProductPage extends ConsumerWidget {
  final String productId;

  const UpdateProductPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productState = ref.watch(updateProductProvider(productId));
    final controller = ref.read(updateProductProvider(productId).notifier);

    return Scaffold(
      appBar: TAppBar(
        title: Text(
          'Update Product',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        showBackArrow: true,
      ),
      bottomNavigationBar: ButtonContainer(
        onPressed: () => controller.updateProduct(),
        text: 'Update Product',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: Sizes.spaceBtwItems),

            _buildTextField(
              context: context,
              label: 'Product Name',
              value: productState.name,
              onChanged: (val) => controller.updateField("name", val),
            ),

            _buildTextField(
              context: context,
              label: 'Product Price',
              value: productState.price,
              onChanged: (val) => controller.updateField("price", val),
              keyboardType: TextInputType.number,
            ),

            _buildTextField(
              context: context,
              label: 'Product Description',
              value: productState.description,
              onChanged: (val) => controller.updateField("description", val),
            ),

            _buildTextField(
              context: context,
              label: 'Product Category',
              value: productState.category,
              onChanged: (val) => controller.updateField("category", val),
            ),

            _buildTextField(
              context: context,
              label: 'Tags (comma separated)',
              value: productState.tags,
              onChanged: (val) => controller.updateField("tags", val),
            ),

            _buildTextField(
              context: context,
              label: 'Product SKU',
              value: productState.sku,
              onChanged: (val) => controller.updateField("sku", val),
            ),

            const SizedBox(height: Sizes.spaceBtwSections),
            IconButton(
              onPressed: controller.pickImages,
              style: IconButton.styleFrom(
                padding: const EdgeInsets.all(Sizes.sm),
                backgroundColor: TColors.primary,
              ),
              icon: Icon(
                Icons.add_a_photo,
                color: Colors.white,
                size: Sizes.iconMd,
              ),
            ),

            productState.images.isNotEmpty
                ? Wrap(
                    spacing: 8,
                    children: productState.images.map((image) {
                      return RoundedContainer(
                        backgroundColor: Colors.transparent,
                        showBorder: true,
                        borderColor: TColors.primary,
                        child: Image.memory(
                          image,
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                      );
                    }).toList(),
                  )
                : Text("No images selected"),

            const SizedBox(height: Sizes.spaceBtwItems),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required BuildContext context,
    required String label,
    required String value,
    required Function(String) onChanged,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Sizes.spaceBtwItems),
      child: TextField(
        onChanged: onChanged,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: label,
          hintStyle: Theme.of(context).textTheme.labelSmall,
        ),
      ),
    );
  }
}
