import 'package:evntas/presentation/theme/color/app_colors.dart';
import 'package:evntas/presentation/values/dimens.dart';
import 'package:flutter/material.dart';

class OutlinedTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final int? maxLines;
  final TextInputType? keyboardType;

  const OutlinedTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
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
      keyboardType: keyboardType,
      textInputAction: TextInputAction.next,
      maxLines: maxLines,

      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
    );
  }
}