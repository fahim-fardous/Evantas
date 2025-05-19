import 'package:flutter/foundation.dart';
import 'package:evntas/presentation/base/base_viewmodel.dart';
import 'package:evntas/presentation/feature/profile_picture/route/profile_picture_argument.dart';

class ProfilePictureViewModel extends BaseViewModel<ProfilePictureArgument> {
  ProfilePictureViewModel();

  @override
  void onViewReady({ProfilePictureArgument? argument}) {
    super.onViewReady();
  }

  void onBackPress(){
    navigateBack();
  }
}
