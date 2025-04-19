import 'package:flutter/material.dart';
import 'package:evntas/presentation/base/base_route.dart';
import 'package:evntas/presentation/feature/settings/route/settings_argument.dart';
import 'package:evntas/presentation/feature/settings/settings_adaptive_ui.dart';
import 'package:evntas/presentation/navigation/route_path.dart';

class SettingsRoute extends BaseRoute<SettingsArgument> {
  @override
  RoutePath routePath = RoutePath.setting;

  SettingsRoute({required super.arguments});

  @override
  MaterialPageRoute toMaterialPageRoute() {
    return MaterialPageRoute(
      builder: (_) => SettingsAdaptiveUi(argument: super.arguments),
    );
  }
}
