import 'package:data/local/shared_preference/shared_pref_manager.dart';
import 'package:domain/model/google_user_data.dart';
import 'package:domain/model/user_response_data.dart';
import 'package:domain/repository/app_repository.dart';
import 'package:domain/repository/auth_repository.dart';
import 'package:evntas/presentation/feature/auth/login/route/login_argument.dart';
import 'package:evntas/presentation/feature/auth/login/route/login_route.dart';
import 'package:flutter/foundation.dart';
import 'package:evntas/presentation/base/base_viewmodel.dart';
import 'package:evntas/presentation/feature/profile/route/profile_argument.dart';

class ProfileViewModel extends BaseViewModel<ProfileArgument> {
  final AuthRepository authRepository;
  final AppRepository appRepository;

  ProfileViewModel({
    required this.authRepository,
    required this.appRepository,
  });

  final ValueNotifier<UserResponseData?> _userData = ValueNotifier(null);

  ValueNotifier<UserResponseData?> get userData => _userData;

  @override
  void onViewReady({ProfileArgument? argument}) {
    super.onViewReady();
    _fetchUserInfo();
  }

  Future<void> _fetchUserInfo() async {
    final userId = await appRepository.getUserId();
    final user = await loadData(authRepository.getUserById(userId));
    if (user == null) return;
    _userData.value = UserResponseData(
      id: user.id,
      email: user.email,
      name: user.name,
      photoUrl: user.photoUrl,
      fcmToken: user.fcmToken,
      role: user.role,
      userId: user.userId,
    );
  }

  Future<void> signOut() async {
    await loadData(authRepository.signOut());

    navigateToScreen(
      destination: LoginRoute(
        arguments: LoginArgument(),
      ),
      isClearBackStack: true,
    );
  }
}
