import 'package:evntas/presentation/values/dimens.dart';
import 'package:flutter/material.dart';

class MemoryHeader extends StatelessWidget {
  final VoidCallback onAddMemoryTap;

  const MemoryHeader({
    required this.onAddMemoryTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                "Memory",
                style: textTheme.headlineMedium?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
