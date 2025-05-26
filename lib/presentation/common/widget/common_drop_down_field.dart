import 'package:flutter/material.dart';

class CommonDropDownField extends StatelessWidget {
  final String title;
  final String description;
  final String positiveButtonLabel;
  final String negativeButtonLabel;
  final Function()? onNegativeButtonPressed;
  final Function() onPositiveButtonPressed;

  const CommonDropDownField({
    super.key,
    required this.title,
    required this.description,
    required this.positiveButtonLabel,
    required this.negativeButtonLabel,
    this.onNegativeButtonPressed,
    required this.onPositiveButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(description),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(negativeButtonLabel),
        ),
        TextButton(
          onPressed: onPositiveButtonPressed,
          child: Text(
            positiveButtonLabel,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
          ),
        ),
      ],
    );
  }
}
