import 'package:flutter/material.dart';
import 'package:evntas/presentation/base/base_route.dart';
import 'package:evntas/presentation/navigation/route_path.dart';
import 'package:evntas/presentation/feature/add_issue/add_issue_adaptive_ui.dart';
import 'package:evntas/presentation/feature/add_issue/route/add_issue_argument.dart';

class AddIssueRoute extends BaseRoute<AddIssueArgument> {
  @override
  RoutePath routePath = RoutePath.addIssue;

  AddIssueRoute({required super.arguments});

  @override
  MaterialPageRoute toMaterialPageRoute() {
    return MaterialPageRoute(
      builder: (_) => AddIssueAdaptiveUi(
        argument: arguments,
      ),
    );
  }
}
