import 'package:flutter/foundation.dart';
import 'package:evntas/presentation/base/base_viewmodel.dart';
import 'package:evntas/presentation/feature/profile/route/profile_argument.dart';

class ProfileViewModel extends BaseViewModel<ProfileArgument> {

  final ValueNotifier<String> _message = ValueNotifier('Profile');

  ValueListenable<String> get message => _message;

  int count = 0;

  ProfileViewModel();

  @override
  void onViewReady({ProfileArgument? argument}) {
    super.onViewReady();
  }

  void onClick() {
     count++;
    _message.value = '${message.value}$count';
  }

}
