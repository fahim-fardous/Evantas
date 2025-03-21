import 'package:flutter/material.dart';
import 'package:hello_flutter/presentation/base/base_adaptive_ui.dart';
import 'package:hello_flutter/presentation/feature/auth/sign_up/binding/sign_up_binding.dart';
import 'package:hello_flutter/presentation/feature/auth/sign_up/route/sign_up_argument.dart';
import 'package:hello_flutter/presentation/feature/auth/sign_up/sign_up_view_model.dart';
import 'package:hello_flutter/presentation/feature/auth/sign_up/route/sign_up_route.dart';
import 'package:hello_flutter/presentation/feature/auth/sign_up/screen/sign_up_mobile_portrait.dart';
import 'package:hello_flutter/presentation/feature/auth/sign_up/screen/sign_up_mobile_landscape.dart';

class SignUpAdaptiveUi extends BaseAdaptiveUi<SignUpArgument, SignUpRoute> {
  const SignUpAdaptiveUi({super.argument, super.key});

  @override
  State<StatefulWidget> createState() => SignUpAdaptiveUiState();
}

class SignUpAdaptiveUiState extends BaseAdaptiveUiState<SignUpArgument, SignUpRoute, SignUpAdaptiveUi, SignUpViewModel, SignUpBinding> {
  @override
  SignUpBinding binding = SignUpBinding();

  @override
  StatefulWidget mobilePortraitContents(BuildContext context) {
    return SignUpMobilePortrait(viewModel: viewModel);
  }

  @override
  StatefulWidget mobileLandscapeContents(BuildContext context) {
    return SignUpMobileLandscape(viewModel: viewModel);
  }
}
