import 'package:flutter/material.dart';
import 'package:hello_flutter/presentation/base/base_route.dart';
import 'package:hello_flutter/presentation/navigation/route_path.dart';
import 'package:hello_flutter/presentation/feature/memory_details/memory_details_adaptive_ui.dart';
import 'package:hello_flutter/presentation/feature/memory_details/route/memory_details_argument.dart';

class MemoryDetailsRoute extends BaseRoute<MemoryDetailsArgument> {
  @override
  RoutePath routePath = RoutePath.memoryDetails;

  MemoryDetailsRoute({required super.arguments});

  @override
  MaterialPageRoute toMaterialPageRoute() {
    return MaterialPageRoute(
      builder: (_) => MemoryDetailsAdaptiveUi(
        argument: arguments,
      ),
    );
  }
}
