import 'package:evntas/presentation/feature/image_viewer/enum/menu_item.dart';
import 'package:flutter/material.dart';

extension MenuItemExt on MenuItem {
  String get name {
    switch (this) {
      case MenuItem.details:
        return 'Details';
      case MenuItem.download:
        return 'Download';
      default:
        return 'Unknown';
    }
  }

  IconData get icon {
    switch (this) {
      case MenuItem.details:
        return Icons.info;
      case MenuItem.download:
        return Icons.download;
      default:
        return Icons.question_mark;
    }
  }
}
