import 'package:flutter/material.dart';
import 'package:evntas/presentation/base/base_route.dart';
import 'package:evntas/presentation/feature/auth/login/login_adaptive_ui.dart';
import 'package:evntas/presentation/feature/auth/login/route/login_argument.dart';
import 'package:evntas/presentation/navigation/route_path.dart';

class LoginRoute extends BaseRoute<LoginArgument> {
  @override
  RoutePath routePath = RoutePath.login;

  LoginRoute({required super.arguments});

  @override
  MaterialPageRoute toMaterialPageRoute() {
    return MaterialPageRoute(builder: (_) => const LoginAdaptiveUi());
  }
}
