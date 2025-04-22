import 'package:evntas/presentation/values/dimens.dart';
import 'package:flutter/material.dart';

class BoxWithTextAndArrow extends StatelessWidget {
  final String text;
  final Color color;
  final Function()? onTap;

  const BoxWithTextAndArrow({
    super.key,
    required this.text,
    this.color = Colors.grey,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(Dimens.dimen_16),
        decoration: BoxDecoration(
          border: Border.all(color: color, width: Dimens.dimen_1),
          borderRadius: BorderRadius.circular(Dimens.dimen_8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: color),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: color,
            ),
          ],
        ),
      ),
    );
  }
}
