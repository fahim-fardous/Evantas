import 'package:flutter/material.dart';
import 'package:evntas/presentation/base/base_route.dart';
import 'package:evntas/presentation/navigation/route_path.dart';
import 'package:evntas/presentation/feature/edit_profile/edit_profile_adaptive_ui.dart';
import 'package:evntas/presentation/feature/edit_profile/route/edit_profile_argument.dart';

class EditProfileRoute extends BaseRoute<EditProfileArgument> {
  @override
  RoutePath routePath = RoutePath.editProfile;

  EditProfileRoute({required super.arguments});

  @override
  MaterialPageRoute toMaterialPageRoute() {
    return MaterialPageRoute(
      builder: (_) => EditProfileAdaptiveUi(
        argument: arguments,
      ),
    );
  }
}
