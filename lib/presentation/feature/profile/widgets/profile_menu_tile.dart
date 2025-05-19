import 'package:evntas/presentation/values/dimens.dart';
import 'package:flutter/material.dart';

class ProfileMenuTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  final Function()? onTap;

  const ProfileMenuTile({
    super.key,
    required this.icon,
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
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(Dimens.dimen_8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(Dimens.dimen_1 / Dimens.dimen_2),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 1),
              )
            ]),
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: color,
            ),
            SizedBox(width: Dimens.dimen_16),
            Text(
              text,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              size: Dimens.dimen_8,
              color: color,
            ),
          ],
        ),
      ),
    );
  }
}
