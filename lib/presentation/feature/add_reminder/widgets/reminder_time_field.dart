import 'package:flutter/material.dart';
import 'package:evntas/presentation/theme/color/app_colors.dart';
import 'package:evntas/presentation/values/dimens.dart';

class ReminderTimeField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final Function(TimeOfDay) onTimeSelected;

  const ReminderTimeField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.onTimeSelected,
  });

  void _showTimePicker(BuildContext context) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((selectedTime) {
      if (selectedTime != null) {
        onTimeSelected(selectedTime);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimens.dimen_8),
        ),
        labelText: labelText,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimens.dimen_8),
          borderSide: BorderSide(
            color: AppColors.of(context).mainColor,
            width: Dimens.dimen_2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimens.dimen_8),
          borderSide: BorderSide(
            color: AppColors.of(context).outlineVariant,
            width: Dimens.dimen_2,
          ),
        ),
        suffixIcon: IconButton(
          icon: const Icon(Icons.alarm),
          onPressed: () => _showTimePicker(context),
        ),
      ),
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      readOnly: true,
    );
  }
}
