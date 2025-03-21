import 'package:flutter/foundation.dart';
import 'package:hello_flutter/presentation/base/base_viewmodel.dart';
import 'package:hello_flutter/presentation/feature/auth/sign_up/route/sign_up_argument.dart';

class SignUpViewModel extends BaseViewModel<SignUpArgument> {

  final ValueNotifier<String> _message = ValueNotifier('SignUp');

  ValueListenable<String> get message => _message;

  int count = 0;

  SignUpViewModel();

  @override
  void onViewReady({SignUpArgument? argument}) {
    super.onViewReady();
  }

  void onClick() {
     count++;
    _message.value = '${message.value}$count';
  }

}
