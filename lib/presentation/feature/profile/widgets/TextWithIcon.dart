import 'package:evntas/presentation/values/dimens.dart';
import 'package:flutter/material.dart';

class TextWithIcon extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function() onTap;

  const TextWithIcon({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          _buildCircularIcon(context),
          SizedBox(width: Dimens.dimen_16),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildCircularIcon(BuildContext context) {
    return ClipOval(
      child: Container(
        color: Colors.grey[300],
        padding: EdgeInsets.all(Dimens.dimen_6),
        child: Icon(icon),
      ),
    );
  }
}
