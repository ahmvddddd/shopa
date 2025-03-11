import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';

class NumericKeyboard extends StatefulWidget {
  final TextEditingController controller;

  const NumericKeyboard({super.key, required this.controller});

  @override
  State<NumericKeyboard> createState() => _NumericKeyboardState();
}

class _NumericKeyboardState extends State<NumericKeyboard> {
  final List<String> _keys = ['1', '2', '3', '4', '5', '6', '7', '8', '9', 'C', '0', '<'];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return GridView.builder(
      shrinkWrap: true,
      itemCount: _keys.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 3.0,
        crossAxisSpacing: 3.0,
        mainAxisExtent: screenHeight * 0.10
      ),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            _onKeyTap(_keys[index]);
          },
          child: Container(
          margin: const EdgeInsets.all(8.0),
          height: screenHeight * 0.10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: TColors.primary.withOpacity(0.8),
          ),
            child: Center(
              child: Text(
                _keys[index],
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.white),
              ),
            ),
          ),
        );
      },
    );
  }

 

  // Handle key tap actions
  void _onKeyTap(String key) {
    if (key == 'C') {
      widget.controller.clear();
    } else if (key == '<') {
      if (widget.controller.text.isNotEmpty) {
        widget.controller.text = widget.controller.text.substring(0, widget.controller.text.length - 1);
      }
    } else {
      widget.controller.text += key;
    }
  }
}

 