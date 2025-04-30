import 'package:flutter/material.dart';
import 'package:evntas/presentation/base/base_route.dart';
import 'package:evntas/presentation/navigation/route_path.dart';
import 'package:evntas/presentation/feature/issue_details/issue_details_adaptive_ui.dart';
import 'package:evntas/presentation/feature/issue_details/route/issue_details_argument.dart';

class IssueDetailsRoute extends BaseRoute<IssueDetailsArgument> {
  @override
  RoutePath routePath = RoutePath.issueDetails;

  IssueDetailsRoute({required super.arguments});

  @override
  MaterialPageRoute toMaterialPageRoute() {
    return MaterialPageRoute(
      builder: (_) => IssueDetailsAdaptiveUi(
        argument: arguments,
      ),
    );
  }
}
