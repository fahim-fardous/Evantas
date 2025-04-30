import 'package:flutter/material.dart';
import 'package:evntas/presentation/base/base_route.dart';
import 'package:evntas/presentation/navigation/route_path.dart';
import 'package:evntas/presentation/feature/issue_list/issue_list_adaptive_ui.dart';
import 'package:evntas/presentation/feature/issue_list/route/issue_list_argument.dart';

class IssueListRoute extends BaseRoute<IssueListArgument> {
  @override
  RoutePath routePath = RoutePath.issueList;

  IssueListRoute({required super.arguments});

  @override
  MaterialPageRoute toMaterialPageRoute() {
    return MaterialPageRoute(
      builder: (_) => IssueListAdaptiveUi(
        argument: arguments,
      ),
    );
  }
}
