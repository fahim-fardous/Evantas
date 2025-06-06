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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(Dimens.dimen_2),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.of(context).mainColor
                : Colors.transparent,
            borderRadius: BorderRadius.circular(Dimens.dimen_50),
          ),
        ),
        SizedBox(height: Dimens.dimen_2),
        Text(
          name,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color:
                    isSelected ? AppColors.of(context).mainColor : Colors.grey,
              ),
        )
      ],
    );
  }
}
