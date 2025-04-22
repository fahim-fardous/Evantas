import 'package:domain/repository/auth_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:evntas/presentation/base/base_viewmodel.dart';
import 'package:evntas/presentation/feature/edit_profile/route/edit_profile_argument.dart';

class EditProfileViewModel extends BaseViewModel<EditProfileArgument> {
  final AuthRepository authRepository;

  EditProfileViewModel({required this.authRepository});

  @override
  void onViewReady({EditProfileArgument? argument}) {
    super.onViewReady();
  }

  void onBackPressed(){
    navigateBack();
  }

}
