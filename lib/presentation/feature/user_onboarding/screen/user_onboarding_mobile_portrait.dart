import 'package:flutter/material.dart';
import 'package:evntas/presentation/base/base_ui_state.dart';
import 'package:evntas/presentation/common/widget/primary_button.dart';
import 'package:evntas/presentation/feature/user_onboarding/pages/onboarding_screen_pages.dart';
import 'package:evntas/presentation/feature/user_onboarding/user_onboarding_view_model.dart';
import 'package:evntas/presentation/feature/user_onboarding/widget/user_onboarding_page_view.dart';
import 'package:evntas/presentation/values/dimens.dart';

class UserOnboardingMobilePortrait extends StatefulWidget {
  final UserOnboardingViewModel viewModel;

  const UserOnboardingMobilePortrait({required this.viewModel, super.key});

  @override
  State<StatefulWidget> createState() => UserOnboardingMobilePortraitState();
}

class UserOnboardingMobilePortraitState
    extends BaseUiState<UserOnboardingMobilePortrait> {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(Dimens.dimen_16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ValueListenableBuilder(
                valueListenable: widget.viewModel.currentPage,
                builder: (context, page, _) => (page !=
                        OnboardingScreenPages.onboardingPages.length - 1)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => widget.viewModel.onSkipPressed(),
                            child: Text(
                              'Skip',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                            ),
                          )
                        ],
                      )
                    : const SizedBox.shrink(),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) =>
                      widget.viewModel.onPageChanged(index),
                  itemCount: OnboardingScreenPages.onboardingPages.length,
                  itemBuilder: (context, index) => UserOnboardingPageView(
                    onboardingPage:
                        OnboardingScreenPages.onboardingPages[index],
                  ),
                ),
              ),
              SizedBox(height: Dimens.dimen_16),
              ValueListenableBuilder(
                valueListenable: widget.viewModel.currentPage,
                builder: (context, page, child) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    OnboardingScreenPages.onboardingPages.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: page == index ? 12 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: page == index
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimens.dimen_16),
              ValueListenableBuilder<int>(
                valueListenable: widget.viewModel.currentPage,
                builder: (context, page, child) => (page ==
                        OnboardingScreenPages.onboardingPages.length - 1)
                    ? PrimaryButton(
                        label: 'Get Started',
                        onPressed: () => widget.viewModel.onGetStartedPressed(),
                        minWidth: double.infinity,
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
