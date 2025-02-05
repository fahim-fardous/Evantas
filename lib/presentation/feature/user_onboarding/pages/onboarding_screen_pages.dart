import 'package:hello_flutter/presentation/feature/user_onboarding/model/onboarding_page.dart';

class OnboardingScreenPages {
  static final List<OnboardingPage> onboardingPages = [
    OnboardingPage(
      title: 'Team Dinner',
      description: 'Arrange your team dinner with Evntas',
      image: 'image1',
    ),
    OnboardingPage(
      title: 'Development',
      description: 'Arrange your team discussion or meeting with Evntas',
      image: 'image2',
    ),
    OnboardingPage(
      title: 'Birthday',
      description: 'Arrange your colleagues birthday with Evntas',
      image: 'image3',
    ),
    OnboardingPage(
      title: 'Special',
      description: 'Arrange your special event with Evntas',
      image: 'image4',
    ),
  ];
}