import 'package:domain/repository/auth_repository.dart';
import 'package:domain/util/logger.dart';
import 'package:evntas/presentation/feature/auth/login/route/login_argument.dart';
import 'package:evntas/presentation/feature/auth/login/route/login_route.dart';
import 'package:evntas/presentation/localization/ui_text.dart';
import 'package:flutter/foundation.dart';
import 'package:evntas/presentation/base/base_viewmodel.dart';
import 'package:evntas/presentation/feature/home/bottom_navigation_item_type.dart';
import 'package:evntas/presentation/feature/home/route/home_argument.dart';

class HomeViewModel extends BaseViewModel<HomeArgument> {
  final ValueNotifier<String?> _userId = ValueNotifier(null);

  ValueListenable<String?> get userId => _userId;

  final List<NavigationItemType> navigationItems = NavigationItemType.values;

  static const int initialPageIndex = 0;

  final ValueNotifier<int> _currentPageIndex = ValueNotifier(initialPageIndex);

  ValueListenable<int> get currentPageIndex => _currentPageIndex;

  final AuthRepository authRepository;

  HomeViewModel({required this.authRepository});

  @override
  onViewReady({HomeArgument? argument}) {
    Logger.debug("HomeViewModel onViewReady");
    _userId.value = argument?.userId;

    _printUserSession();
  }

  void _printUserSession() async {
    final userSession = await authRepository.getCurrentUser();
    Logger.debug("User session: $userSession");
  }

  void onPageChanged(int index) {
    _currentPageIndex.value = index;
  }

  Future<void> onNavigationItemClicked(int index) async{
    if (NavigationItemType.values[index].isAuthenticationRequired()) {
      bool isUserLoggedIn = await authRepository.isSignedIn();
      if (!isUserLoggedIn) {
        showToast(
          uiText: FixedUiText(text: "Please login first"),
        );
        navigateToScreen(
          destination: LoginRoute(arguments: LoginArgument()),
          isClearBackStack: true,
        );
        return;
      }
    }
    _currentPageIndex.value = index;
  }

  onClickBack() {
    navigateBack();
  }
}
