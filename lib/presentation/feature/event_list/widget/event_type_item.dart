import 'package:flutter/material.dart';
import 'package:evntas/presentation/theme/color/app_colors.dart';
import 'package:evntas/presentation/values/dimens.dart';

class EventTypeItem extends StatelessWidget {
  final bool isSelected;
  final String name;

  const EventTypeItem({
    super.key,
    required this.isSelected,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final mainColor = AppColors.of(context).mainColor;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Dimens.dimen_14,
        vertical: Dimens.dimen_10,
      ),
      decoration: BoxDecoration(
        color: isSelected
            ? mainColor
            : isDark
                ? Theme.of(context).colorScheme.surface.withOpacity(.42)
                : Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(Dimens.dimen_100),
        border: Border.all(
          color: isSelected
              ? Colors.transparent
              : Theme.of(context).colorScheme.outlineVariant.withOpacity(
                    isDark ? .35 : .5,
                  ),
        ),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: mainColor.withOpacity(isDark ? .35 : .25),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ]
            : [],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: Dimens.dimen_8,
            height: Dimens.dimen_8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected
                  ? Colors.white
                  : Theme.of(context).colorScheme.outline.withOpacity(.6),
            ),
          ),
          SizedBox(width: Dimens.dimen_8),
          Text(
            name,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: isSelected
                      ? Colors.white
                      : Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
    );
  }
}
