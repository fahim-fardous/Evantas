import 'package:data/local/shared_preference/shared_pref_manager.dart';
import 'package:domain/model/google_user_data.dart';
import 'package:domain/model/issue.dart';
import 'package:domain/model/user_response_data.dart';
import 'package:domain/repository/app_repository.dart';
import 'package:domain/repository/auth_repository.dart';
import 'package:domain/repository/issue_repository.dart';
import 'package:domain/repository/profile_repository.dart';
import 'package:evntas/presentation/feature/auth/login/route/login_argument.dart';
import 'package:evntas/presentation/feature/auth/login/route/login_route.dart';
import 'package:evntas/presentation/feature/edit_profile/route/edit_profile_argument.dart';
import 'package:evntas/presentation/feature/edit_profile/route/edit_profile_route.dart';
import 'package:evntas/presentation/feature/issue_list/route/issue_list_argument.dart';
import 'package:evntas/presentation/feature/issue_list/route/issue_list_route.dart';
import 'package:evntas/presentation/feature/profile_picture/route/profile_picture_argument.dart';
import 'package:evntas/presentation/feature/profile_picture/route/profile_picture_route.dart';
import 'package:evntas/presentation/localization/ui_text.dart';
import 'package:flutter/foundation.dart';
import 'package:evntas/presentation/base/base_viewmodel.dart';
import 'package:evntas/presentation/feature/profile/route/profile_argument.dart';
import 'package:flutter/material.dart';

class ProfileViewModel extends BaseViewModel<ProfileArgument> {
  final AuthRepository authRepository;
  final AppRepository appRepository;
  final ProfileRepository profileRepository;
  final IssueRepository issueRepository;

  ProfileViewModel({
    required this.authRepository,
    required this.appRepository,
    required this.profileRepository,
    required this.issueRepository,
  });

  final ValueNotifier<UserResponseData?> _userData = ValueNotifier(null);

  ValueNotifier<UserResponseData?> get userData => _userData;

  final ValueNotifier<int> _issueCount = ValueNotifier(0);

  ValueNotifier<int> get issueCount => _issueCount;

  @override
  void onViewReady({ProfileArgument? argument}) {
    super.onViewReady();
    _fetchUserInfo();
    fetchIssues();
  }

  Future<void> _fetchUserInfo() async {
    final userId = await appRepository.getUserId();
    if (userId == null) {
      showToast(
        uiText: FixedUiText(
          text: "Please login first",
        ),
      );
      return;
    }

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

  Future<void> onEditProfilePressed() async {
    final userId = await appRepository.getUserId();
    if (userId == null) {
      showToast(
        uiText: FixedUiText(
          text: "Please login first",
        ),
      );
      return;
    }
    navigateToScreen(
      destination: EditProfileRoute(
        arguments: EditProfileArgument(userId: userId),
      ),
      onPop: () => _fetchUserInfo(),
    );
  }

  Future<void> signOut() async {
    await appRepository.clearAll();
    await loadData(authRepository.signOut());
    navigateToScreen(
      destination: LoginRoute(
        arguments: LoginArgument(),
      ),
      isClearBackStack: true,
    );
  }

  void onSeeProfilePicture(String photoUrl) {
    navigateToScreen(
      destination: ProfilePictureRoute(
        arguments: ProfilePictureArgument(
          profilePhotoUrl: photoUrl,
        ),
      ),
    );
  }

  Future<void> selectProfilePicture() async {
    final userId = await appRepository.getUserId();
    if (userId == null) {
      showToast(
        uiText: FixedUiText(
          text: "Please login first",
        ),
      );
      return;
    }
    await loadData(profileRepository.updateProfilePhoto(userId));
    _fetchUserInfo();
  }

  Future<void> fetchIssues() async {
    final issues = await issueRepository.fetchIssues();

    if (issues.isNotEmpty) {
      _issueCount.value = issues.length;
    }
  }

  void onIssuesPressed() {
    navigateToScreen(
      destination: IssueListRoute(
        arguments: IssueListArgument(),
      ),
    );
  }
}
