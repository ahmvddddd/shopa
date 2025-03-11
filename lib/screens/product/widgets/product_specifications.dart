import 'package:flutter/material.dart';

class ProductSpecifications extends StatelessWidget {
  const ProductSpecifications({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children:[
          const Text('\u2022'),
          Text('2023/2024',
          style: Theme.of(context).textTheme.labelSmall,),
          ]),
        Row(children:[
          const Text('\u2022'),
          Text('120g',
          style: Theme.of(context).textTheme.labelSmall,),
          ]),
        Row(children:[
          const Text('\u2022'),
          Text(' 45mm',
          style: Theme.of(context).textTheme.labelSmall,),
          ]),
        Row(children:[
          const Text('\u2022'),
          Text('10mm Screen Diameter',
          style: Theme.of(context).textTheme.labelSmall,),
          ]),
        Row(children:[
          const Text('\u2022'),
          Text('Rubber strap and  silver case',
          style: Theme.of(context).textTheme.labelSmall,),
          ]),
        Row(children:[
          const Text('\u2022'),
          Text('Chronograph watch',
          style: Theme.of(context).textTheme.labelSmall,),
          ]),
        Row(children:[
          const Text('\u2022'),
          Text('Id 1234567890ABC',
          style: Theme.of(context).textTheme.labelSmall,),
          ]),
          Row(children:[
          const Text('\u2022'),
          Text('Recyclable',
          style: Theme.of(context).textTheme.labelSmall,),
          ]),
      ],
    );
  }
}