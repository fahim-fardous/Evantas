import 'package:evntas/presentation/feature/memory/widget/memory_image_shimmer_placeholder.dart';
import 'package:evntas/presentation/util/constants.dart';
import 'package:evntas/presentation/values/dimens.dart';
import 'package:flutter/material.dart';

class MemoryImageTile extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double borderRadius;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const MemoryImageTile({
    required this.imageUrl,
    required this.height,
    required this.borderRadius,
    required this.onTap,
    required this.onLongPress,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: colorScheme.primary.withValues(alpha: 0.06),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: Dimens.dimen_12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Image.network(
          imageUrl.isNotEmpty ? imageUrl : Constants.emptyPlaceholderUrl,
          fit: BoxFit.cover,
          width: double.infinity,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return const MemoryImageShimmerPlaceholder();
          },
          errorBuilder: (context, error, stackTrace) {
            return ColoredBox(
              color: colorScheme.primary.withValues(alpha: 0.08),
              child: Icon(
                Icons.broken_image_outlined,
                color: colorScheme.primary.withValues(alpha: 0.6),
              ),
            );
          },
        ),
      ),
    );
  }
}

class AddMemoryTile extends StatelessWidget {
  final double height;
  final VoidCallback onTap;

  const AddMemoryTile({
    required this.height,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimens.dimen_24),
          border: Border.all(
            color: colorScheme.primary.withValues(alpha: 0.2),
            width: Dimens.dimen_2,
          ),
          color: colorScheme.surface.withValues(alpha: 0.7),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: Dimens.dimen_44,
              height: Dimens.dimen_44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: colorScheme.primary.withValues(alpha: 0.35),
                  width: Dimens.dimen_2,
                ),
              ),
              child: Icon(
                Icons.add,
                color: colorScheme.primary.withValues(alpha: 0.75),
              ),
            ),
            SizedBox(height: Dimens.dimen_10),
            Text(
              "Add memory",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: colorScheme.primary.withValues(alpha: 0.55),
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
