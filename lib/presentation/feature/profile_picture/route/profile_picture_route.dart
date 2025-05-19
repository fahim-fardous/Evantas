import 'package:flutter/material.dart';
import 'package:evntas/presentation/base/base_route.dart';
import 'package:evntas/presentation/navigation/route_path.dart';
import 'package:evntas/presentation/feature/profile_picture/profile_picture_adaptive_ui.dart';
import 'package:evntas/presentation/feature/profile_picture/route/profile_picture_argument.dart';

class ProfilePictureRoute extends BaseRoute<ProfilePictureArgument> {
  @override
  RoutePath routePath = RoutePath.profilePicture;

  ProfilePictureRoute({required super.arguments});

  @override
  MaterialPageRoute toMaterialPageRoute() {
    return MaterialPageRoute(
      builder: (_) => ProfilePictureAdaptiveUi(
        argument: arguments,
      ),
    );
  }
}
