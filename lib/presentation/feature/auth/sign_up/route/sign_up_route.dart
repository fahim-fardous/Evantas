import 'package:flutter/material.dart';
import 'package:hello_flutter/presentation/base/base_route.dart';
import 'package:hello_flutter/presentation/navigation/route_path.dart';
import 'package:hello_flutter/presentation/feature/auth/sign_up/sign_up_adaptive_ui.dart';
import 'package:hello_flutter/presentation/feature/auth/sign_up/route/sign_up_argument.dart';

class SignUpRoute extends BaseRoute<SignUpArgument> {
  @override
  RoutePath routePath = RoutePath.signUp;

  SignUpRoute({required super.arguments});

  @override
  MaterialPageRoute toMaterialPageRoute() {
    return MaterialPageRoute(
      builder: (_) => SignUpAdaptiveUi(
        argument: arguments,
      ),
    );
  }
}
