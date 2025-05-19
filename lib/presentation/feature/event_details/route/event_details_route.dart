import 'package:flutter/material.dart';
import 'package:evntas/presentation/base/base_route.dart';
import 'package:evntas/presentation/navigation/route_path.dart';
import 'package:evntas/presentation/feature/event_details/event_details_adaptive_ui.dart';
import 'package:evntas/presentation/feature/event_details/route/event_details_argument.dart';

class EventDetailsRoute extends BaseRoute<EventDetailsArgument> {
  @override
  RoutePath routePath = RoutePath.eventDetails;

  EventDetailsRoute({required super.arguments});

  @override
  MaterialPageRoute toMaterialPageRoute() {
    return MaterialPageRoute(
      builder: (_) => EventDetailsAdaptiveUi(
        argument: arguments,
      ),
    );
  }
}
