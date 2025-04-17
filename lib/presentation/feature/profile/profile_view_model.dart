import 'package:domain/repository/auth_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:evntas/presentation/base/base_viewmodel.dart';
import 'package:evntas/presentation/feature/profile/route/profile_argument.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileViewModel extends BaseViewModel<ProfileArgument> {
  final AuthRepository authRepository;

  final ValueNotifier<GoogleSignInAccount?> _user = ValueNotifier(null);
  ValueNotifier<GoogleSignInAccount?> get user => _user;

  ProfileViewModel({required this.authRepository});

  @override
  void onViewReady({ProfileArgument? argument}) {
    super.onViewReady();
    fetchUserInfo();
  }

  Future<void> fetchUserInfo() async {
    final userInfo = await authRepository.getCurrentGoogleUser();

    if (userInfo != null) {
      _user.value = userInfo;
    }
  }

}
