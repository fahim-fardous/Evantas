import 'package:flutter/material.dart';
import 'package:evntas/presentation/feature/event_list/event_list_adaptive_ui.dart';
import 'package:evntas/presentation/feature/memory/memory_adaptive_ui.dart';
import 'package:evntas/presentation/feature/profile/profile_adaptive_ui.dart';
import 'package:evntas/presentation/localization/generated/app_localizations.dart';

enum NavigationItemType {
  eventList,
  memories,
  profile;

  IconData get icon {
    switch (this) {
      case NavigationItemType.eventList:
        return Icons.home_outlined;
      case NavigationItemType.profile:
        return Icons.face_outlined;
      case NavigationItemType.memories:
        return Icons.photo_album_outlined;
    }
  }

  IconData get selectedIcon {
    switch (this) {
      case NavigationItemType.eventList:
        return Icons.home;
      case NavigationItemType.profile:
        return Icons.face;
      case NavigationItemType.memories:
        return Icons.photo_album;
    }
  }

  Widget get page {
    switch (this) {
      case NavigationItemType.eventList:
        return const EventListAdaptiveUi();
      case NavigationItemType.profile:
        return const ProfileAdaptiveUi();
      case NavigationItemType.memories:
        return const MemoryAdaptiveUi();
    }
  }

  String getLocalizedName(AppLocalizations localizations) {
    switch (this) {
      case NavigationItemType.eventList:
        return localizations.navigation_item__home;
      case NavigationItemType.profile:
        return localizations.profile;
      case NavigationItemType.memories:
        return localizations.memories;
      default:
        return '';
    }
  }

  bool isAuthenticationRequired() {
    switch (this) {
      case NavigationItemType.eventList:
        return false;
      case NavigationItemType.profile:
        return true;
      case NavigationItemType.memories:
        return true;
    }
  }
}
