import 'package:evntas/presentation/feature/memory/memory_view_model.dart';
import 'package:evntas/presentation/feature/memory/widget/memory_tiles.dart';
import 'package:evntas/presentation/values/dimens.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MemoryCardsSection extends StatelessWidget {
  final List<MemoryImageItem> images;
  final ValueChanged<int> onTapImage;
  final ValueChanged<String> onLongPressImage;
  final VoidCallback onAddMemoryTap;

  const MemoryCardsSection({
    required this.images,
    required this.onTapImage,
    required this.onLongPressImage,
    required this.onAddMemoryTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      return AddMemoryTile(
        height: Dimens.dimen_200,
        onTap: onAddMemoryTap,
      );
    }

    final List<_DateGroup> groups = _groupImagesByDate(images);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...List.generate(groups.length, (groupIndex) {
          final _DateGroup group = groups[groupIndex];
          return Padding(
            padding: EdgeInsets.only(
              bottom: groupIndex == groups.length - 1
                  ? Dimens.dimen_8
                  : Dimens.dimen_18,
            ),
            child: _buildDateGroup(context, group),
          );
        }),
        SizedBox(height: Dimens.dimen_8),
        _buildTotalText(context),
      ],
    );
  }

  Widget _buildDateGroup(BuildContext context, _DateGroup group) {
    final int itemCount = group.items.length + (group.isFirstGroup ? 1 : 0);
    final int crossAxisCount = 2;
    final int rowCount = (itemCount / crossAxisCount).ceil();
    final double heightPerItem = Dimens.dimen_210;
    final double spacing = Dimens.dimen_14;
    final double gridHeight =
        (rowCount * heightPerItem) + ((rowCount - 1) * spacing);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          group.title,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.75),
                fontWeight: FontWeight.w700,
                letterSpacing: 1.1,
              ),
        ),
        SizedBox(height: Dimens.dimen_10),
        SizedBox(
          height: gridHeight,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: itemCount,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: spacing,
              mainAxisSpacing: spacing,
              mainAxisExtent: heightPerItem,
            ),
            itemBuilder: (context, index) {
              if (index < group.items.length) {
                final _IndexedImage item = group.items[index];
                return MemoryImageTile(
                  imageUrl: item.image.url,
                  height: double.infinity,
                  borderRadius: Dimens.dimen_24,
                  onTap: () => onTapImage(item.originalIndex),
                  onLongPress: () => onLongPressImage(item.image.url),
                );
              }
              return AddMemoryTile(
                height: double.infinity,
                onTap: onAddMemoryTap,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTotalText(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Text(
      "${images.length} memories",
      style: textTheme.bodyMedium?.copyWith(
        color: colorScheme.primary.withValues(alpha: 0.65),
        fontWeight: FontWeight.w600,
      ),
    );
  }

  List<_DateGroup> _groupImagesByDate(List<MemoryImageItem> allImages) {
    final Map<String, List<_IndexedImage>> grouped = {};
    final List<String> order = [];
    final List<_IndexedImage> sortedImages = List.generate(
      allImages.length,
      (index) => _IndexedImage(originalIndex: index, image: allImages[index]),
    )..sort(
        (a, b) => b.image.createdAt.compareTo(a.image.createdAt),
      );

    for (final _IndexedImage indexedImage in sortedImages) {
      final MemoryImageItem image = indexedImage.image;
      final DateTime date = DateTime(
        image.createdAt.year,
        image.createdAt.month,
        image.createdAt.day,
      );
      final String key = date.toIso8601String();
      grouped.putIfAbsent(key, () {
        order.add(key);
        return [];
      });
      grouped[key]!.add(indexedImage);
    }

    return List.generate(order.length, (index) {
      final String key = order[index];
      return _DateGroup(
        title: _formatDateTitle(DateTime.parse(key)),
        items: grouped[key]!,
        isFirstGroup: index == 0,
      );
    });
  }

  String _formatDateTitle(DateTime date) {
    final DateTime today = DateTime.now();
    final DateTime normalizedToday = DateTime(today.year, today.month, today.day);
    final DateTime normalizedDate = DateTime(date.year, date.month, date.day);
    if (normalizedDate == normalizedToday) {
      return "TODAY";
    }
    return DateFormat('d MMMM, yyyy').format(date).toUpperCase();
  }
}

class _DateGroup {
  final String title;
  final List<_IndexedImage> items;
  final bool isFirstGroup;

  const _DateGroup({
    required this.title,
    required this.items,
    required this.isFirstGroup,
  });
}

class _IndexedImage {
  final int originalIndex;
  final MemoryImageItem image;

  const _IndexedImage({
    required this.originalIndex,
    required this.image,
  });
}
