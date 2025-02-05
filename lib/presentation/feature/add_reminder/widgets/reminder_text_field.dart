import 'package:flutter/material.dart';
import 'package:hello_flutter/presentation/common/extension/context_ext.dart';
import 'package:hello_flutter/presentation/theme/color/app_colors.dart';
import 'package:hello_flutter/presentation/values/dimens.dart';

class ReminderTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;

  const ReminderTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimens.dimen_8),
        ),
        labelText: labelText,
        hintText: hintText,
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
      ),
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
    );
  }
}
