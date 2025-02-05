import 'package:flutter/material.dart';
import 'package:hello_flutter/presentation/base/base_ui_state.dart';
import 'package:hello_flutter/presentation/feature/user_onboarding/model/onboarding_page.dart';
import 'package:hello_flutter/presentation/feature/user_onboarding/user_onboarding_view_model.dart';

class UserOnboardingMobilePortrait extends StatefulWidget {
  final UserOnboardingViewModel viewModel;

  const UserOnboardingMobilePortrait({required this.viewModel, super.key});

  @override
  State<StatefulWidget> createState() => UserOnboardingMobilePortraitState();
}

class UserOnboardingMobilePortraitState extends BaseUiState<UserOnboardingMobilePortrait> {
  final PageController _pageController = PageController(initialPage: 0);
  final int _currentPage= 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: valueListenableBuilder(
        listenable: widget.viewModel.message,
        builder: (context, value) {
          return InkWell(
            child: Text('UserOnboarding: $value'),
            onTap: () => widget.viewModel.onClick(),
          );
        },
      ),
    );
  }
}
