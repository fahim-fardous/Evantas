import 'package:flutter/material.dart';
import 'package:hello_flutter/presentation/base/base_route.dart';
import 'package:hello_flutter/presentation/navigation/route_path.dart';
import 'package:hello_flutter/presentation/feature/add_event/add_event_adaptive_ui.dart';
import 'package:hello_flutter/presentation/feature/add_event/route/add_event_argument.dart';

class AddEventRoute extends BaseRoute<AddEventArgument> {
  @override
  RoutePath routePath = RoutePath.addEvent;

  AddEventRoute({required super.arguments});

  @override
  MaterialPageRoute toMaterialPageRoute() {
    return MaterialPageRoute(
      builder: (_) => AddEventAdaptiveUi(
        argument: arguments,
      ),
    );
  }
}
