import 'package:evntas/presentation/values/dimens.dart';
import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final int value;
  final String title;

  const InfoCard({
    super.key,
    required this.value,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(
              Dimens.dimen_1 / Dimens.dimen_10,
            ),
        borderRadius: BorderRadius.circular(Dimens.dimen_10),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: Dimens.dimen_16,
        vertical: Dimens.dimen_8,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '$value',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: Dimens.dimen_20,
                ),
          ),
          SizedBox(height: Dimens.dimen_4),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
          ),
        ],
      ),
    );
  }
}
