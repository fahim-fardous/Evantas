import 'package:flutter/material.dart';
import 'package:hello_flutter/presentation/common/widget/asset_image_view.dart';
import 'package:hello_flutter/presentation/feature/user_onboarding/model/onboarding_page.dart';
import 'package:hello_flutter/presentation/values/dimens.dart';

class UserOnboardingPageView extends StatelessWidget {
  final OnboardingPage onboardingPage;

  const UserOnboardingPageView({
    super.key,
    required this.onboardingPage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Dimens.dimen_36),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(child: AssetImageView(fileName: onboardingPage.image, height: Dimens.dimen_300,)),
          SizedBox(height: Dimens.dimen_36),
          Text(
            onboardingPage.title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: Dimens.dimen_20),
          Text(
            onboardingPage.description,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ],
      ),
    );
  }
}
