import 'package:domain/model/user_response_data.dart';
import 'package:domain/repository/app_repository.dart';
import 'package:domain/repository/auth_repository.dart';
import 'package:domain/repository/profile_repository.dart';
import 'package:evntas/presentation/localization/ui_text.dart';
import 'package:flutter/foundation.dart';
import 'package:evntas/presentation/base/base_viewmodel.dart';
import 'package:evntas/presentation/feature/edit_profile/route/edit_profile_argument.dart';

class EditProfileViewModel extends BaseViewModel<EditProfileArgument> {
  final AuthRepository authRepository;
  final AppRepository appRepository;
  final ProfileRepository profileRepository;

  final ValueNotifier<UserResponseData?> _userData = ValueNotifier(null);

  ValueNotifier<UserResponseData?> get userData => _userData;

  EditProfileViewModel({
    required this.authRepository,
    required this.appRepository,
    required this.profileRepository,
  });

  @override
  void onViewReady({EditProfileArgument? argument}) {
    super.onViewReady();
    _fetchUserInfo(argument?.userId);
  }

  Future<void> _fetchUserInfo(String? userId) async {
    final user = await loadData(authRepository.getUserById(userId!));
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

  Future<void> onSavePressed(String userId, String name, String email) async {
    if (name == "" && email == "") {
      showToast(
        uiText: FixedUiText(
          text: "Please fill up at least one field",
        ),
      );
      return;
    }
    await loadData(
      profileRepository.updateProfile(
        UserResponseData(
          id: _userData.value?.id ?? 0,
          name: name == "" ? _userData.value!.name : name,
          email: email == "" ? _userData.value!.email : email,
          photoUrl: _userData.value?.photoUrl ?? '',
          fcmToken: _userData.value?.fcmToken ?? '',
          role: _userData.value?.role ?? '',
          userId: userId,
        ),
      ),
    );

    navigateBack();
  }

  void onBackPressed() {
    navigateBack();
  }
}
