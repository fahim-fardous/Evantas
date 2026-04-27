import 'package:evntas/presentation/theme/color/app_colors.dart';
import 'package:evntas/presentation/values/dimens.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MemoryBottomActions extends StatelessWidget {
  final ValueChanged<ImageSource> onUpload;

  const MemoryBottomActions({
    required this.onUpload,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = AppColors.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _BottomActionButton(
          icon: Icons.camera_alt_outlined,
          onTap: () => onUpload(ImageSource.camera),
          backgroundColor: appColors.mainColor.withValues(alpha: 0.16),
        ),
        SizedBox(width: Dimens.dimen_20),
        _BottomActionButton(
          icon: Icons.image_outlined,
          onTap: () => onUpload(ImageSource.gallery),
          backgroundColor: appColors.secondary.withValues(alpha: 0.16),
        ),
      ],
    );
  }
}

class _BottomActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color backgroundColor;

  const _BottomActionButton({
    required this.icon,
    required this.onTap,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(Dimens.dimen_16),
      child: Container(
        width: Dimens.dimen_74,
        height: Dimens.dimen_58,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimens.dimen_16),
          color: backgroundColor,
          border: Border.all(
            color: colorScheme.primary.withValues(alpha: 0.12),
          ),
        ),
        child: Icon(
          icon,
          color: colorScheme.primary.withValues(alpha: 0.72),
        ),
      ),
    );
  }
}
