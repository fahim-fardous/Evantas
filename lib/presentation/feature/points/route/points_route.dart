import 'package:flutter/material.dart';
import 'package:evntas/presentation/base/base_route.dart';
import 'package:evntas/presentation/navigation/route_path.dart';
import 'package:evntas/presentation/feature/points/points_adaptive_ui.dart';
import 'package:evntas/presentation/feature/points/route/points_argument.dart';

class PointsRoute extends BaseRoute<PointsArgument> {
  @override
  RoutePath routePath = RoutePath.points;

  PointsRoute({required super.arguments});

  @override
  MaterialPageRoute toMaterialPageRoute() {
    return MaterialPageRoute(
      builder: (_) => PointsAdaptiveUi(
        argument: arguments,
      ),
    );
  }
}
