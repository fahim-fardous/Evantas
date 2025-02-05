import 'package:flutter/material.dart';
import 'package:hello_flutter/presentation/base/base_route.dart';
import 'package:hello_flutter/presentation/feature/add_reminder/add_reminder_adaptive_ui.dart';
import 'package:hello_flutter/presentation/navigation/route_path.dart';

import 'add_reminder_argument.dart';

class AddReminderRoute extends BaseRoute<AddReminderArgument> {
  @override
  RoutePath routePath = RoutePath.createReminder;

  AddReminderRoute({required super.arguments});

  @override
  MaterialPageRoute toMaterialPageRoute() {
    return MaterialPageRoute(
      builder: (_) => AddReminderAdaptiveUi(
        argument: arguments,
      ),
    );
  }
}
