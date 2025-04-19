import 'package:flutter/material.dart';
import 'package:evntas/presentation/base/base_route.dart';
import 'package:evntas/presentation/navigation/route_path.dart';
import 'package:evntas/presentation/feature/profile/profile_adaptive_ui.dart';
import 'package:evntas/presentation/feature/profile/route/profile_argument.dart';

class ProfileRoute extends BaseRoute<ProfileArgument> {
  @override
  RoutePath routePath = RoutePath.profile;

  ProfileRoute({required super.arguments});

  @override
  MaterialPageRoute toMaterialPageRoute() {
    return MaterialPageRoute(
      builder: (_) => ProfileAdaptiveUi(
        argument: arguments,
      ),
    );
  }
}
