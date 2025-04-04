import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmText;
  final String cancelText;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;
  
  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.message,
    this.confirmText = "OK",
    this.cancelText = "Cancel",
    required this.onConfirm,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title,
          style: Theme.of(context).textTheme.labelLarge,),
      content: Text(message,
          style: Theme.of(context).textTheme.labelMedium,),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      actions: [
        TextButton(
          onPressed: () {
            if (onCancel != null) onCancel!();
            Navigator.of(context).pop();
          },
          child: Text(cancelText,
          style: Theme.of(context).textTheme.labelMedium,),
        ),
        ElevatedButton(
          onPressed: onConfirm,
          child: Text(confirmText,
          style: Theme.of(context).textTheme.labelMedium,),
        ),
      ],
    );
  }
}
