import 'package:flutter/material.dart';
import 'package:evntas/presentation/theme/color/app_colors.dart';
import 'package:evntas/presentation/values/dimens.dart';

class ReminderDateField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final Function(DateTime) onDateSelected;

  const ReminderDateField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.onDateSelected,
  });

  void _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    ).then((selectedDate) {
      if (selectedDate != null) {
        onDateSelected(selectedDate);
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
          icon: const Icon(Icons.calendar_month),
          onPressed: () => _showDatePicker(context),
        ),
      ),
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      readOnly: true,
    );
  }
}
