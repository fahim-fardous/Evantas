import 'package:flutter/material.dart';
import 'package:evntas/presentation/base/base_route.dart';
import 'package:evntas/presentation/navigation/route_path.dart';
import 'package:evntas/presentation/feature/memory/memory_adaptive_ui.dart';
import 'package:evntas/presentation/feature/memory/route/memory_argument.dart';

class MemoryRoute extends BaseRoute<MemoryArgument> {
  @override
  RoutePath routePath = RoutePath.memory;

  MemoryRoute({required super.arguments});

  @override
  MaterialPageRoute toMaterialPageRoute() {
    return MaterialPageRoute(
      builder: (_) => MemoryAdaptiveUi(
        argument: arguments,
      ),
    );
  }
}
