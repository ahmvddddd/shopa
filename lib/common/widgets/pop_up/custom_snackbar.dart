import 'package:flutter/material.dart';
import '../../../utils/constants/sizes.dart';
import '../custom_shapes/containers/rounded_container.dart';

class CustomSnackbar {
  static void show({
    required BuildContext context,
    required String title,
    required String message,
    required Color backgroundColor,
    required IconData icon,
    int durationInSeconds = 4,
    // String? actionLabel,
    // VoidCallback? onActionPressed,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            RoundedContainer(
              backgroundColor: Colors.white.withOpacity(0.1),
              padding: const EdgeInsets.all(Sizes.xs),
              child: Icon(icon, size: Sizes.iconMd, color: Colors.white),
            ),
            const SizedBox(width: Sizes.xs),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge!.copyWith(color: Colors.white),
                ),
                SizedBox(
                  width: 300,
                  child: Text(
                    message,
                    style: Theme.of(
                      context,
                    ).textTheme.labelMedium!.copyWith(color: Colors.white),
                    softWrap: true,
                    maxLines: 3,
                  ),
                ),
              ],
            ),
          ],
        ),
        duration: Duration(seconds: durationInSeconds),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(Sizes.cardRadiusLg),
            bottomLeft: Radius.circular(Sizes.cardRadiusLg),
          ),
        ),
        // action:
        //     actionLabel != null && onActionPressed != null
        //         ? SnackBarAction(
        //           label: actionLabel,
        //           textColor: Colors.white,
        //           onPressed: onActionPressed,
        //         )
        //         : null,
      ),
    );
  }
}
