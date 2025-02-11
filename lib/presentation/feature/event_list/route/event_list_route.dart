import 'package:flutter/material.dart';
import 'package:evntas/presentation/base/base_route.dart';
import 'package:evntas/presentation/navigation/route_path.dart';
import 'package:evntas/presentation/feature/event_list/event_list_adaptive_ui.dart';
import 'package:evntas/presentation/feature/event_list/route/event_list_argument.dart';

class EventListRoute extends BaseRoute<EventListArgument> {
  @override
  RoutePath routePath = RoutePath.eventList;

  EventListRoute({required super.arguments});

  @override
  MaterialPageRoute toMaterialPageRoute() {
    return MaterialPageRoute(
      builder: (_) => EventListAdaptiveUi(
        argument: arguments,
      ),
    );
  }
}
