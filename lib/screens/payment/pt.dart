// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';
// import '../../common/widgets/appbar/appbar.dart';
// import '../../common/widgets/custom_shapes/containers/button_container.dart';
// import '../../utils/constants/sizes.dart';

// class PaymentScreen extends StatelessWidget {
//   const PaymentScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//       appBar: TAppBar(
//                         title: Text('Pay',
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .headlineMedium),
//                         showBackArrow: true,
//                       ),
//                       bottomNavigationBar: ButtonContainer(
//                         onPressed: () {},
//                         text: 'Pay',
//                       ),
//         body: Padding(
//           padding: const EdgeInsets.all(Sizes.spaceBtwItems),
//           child: Column(
//             children: [
//               const SizedBox(height: Sizes.spaceBtwItems,),
              
//                 TextFormField(
//                   decoration: InputDecoration(
//                     hintText: 'card number',
//                     hintStyle: Theme.of(context).textTheme.labelSmall,
//                     border: InputBorder.none,
//                   ),
//                 ),
        
//                 const SizedBox(height: Sizes.spaceBtwItems,),
//                 TextFormField(
//                   decoration: InputDecoration(
//                     hintText: 'cvv',
//                     hintStyle: Theme.of(context).textTheme.labelSmall,
//                     border: InputBorder.none,
//                   ),
//                 ),
        
//                 const SizedBox(height: Sizes.spaceBtwItems),
//               Row(
//                 children: [
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 0.0),
//                       child: TextFormField(
//                         expands: false,
//                         keyboardType: TextInputType.number,
//                         decoration: InputDecoration(
//                           border: InputBorder.none,
//                           prefixIcon: const Icon(
//                             Iconsax.calendar,
//                             size: Sizes.iconSm,
//                           ),
//                           hintText: 'Expiry Month',
//                           hintStyle: Theme.of(context).textTheme.labelSmall,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: Sizes.spaceBtwInputFields),
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 0.0),
//                       child: TextFormField(
//                         expands: false,
//                         keyboardType: TextInputType.number,
//                         decoration: InputDecoration(
//                           border: InputBorder.none,
//                           prefixIcon: const Icon(
//                             Iconsax.calendar,
//                             size: Sizes.iconSm,
//                           ),
//                           hintText: 'Expiry Year',
//                           hintStyle: Theme.of(context).textTheme.labelSmall,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
        
                
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }