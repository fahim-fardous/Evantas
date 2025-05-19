import 'package:domain/repository/app_repository.dart';
import 'package:domain/repository/auth_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:evntas/presentation/base/base_viewmodel.dart';
import 'package:evntas/presentation/feature/auth/login/route/login_argument.dart';
import 'package:evntas/presentation/feature/auth/validator/email_validator.dart';
import 'package:evntas/presentation/feature/auth/validator/password_validator.dart';
import 'package:evntas/presentation/feature/home/route/home_argument.dart';
import 'package:evntas/presentation/feature/home/route/home_route.dart';
import 'package:evntas/presentation/localization/text_id.dart';
import 'package:evntas/presentation/localization/ui_text.dart';

class LoginViewModel extends BaseViewModel<LoginArgument> {
  final AuthRepository authRepository;
  final AppRepository appRepository;

  LoginViewModel({
    required this.authRepository,
    required this.appRepository,
  });

  final ValueNotifier<String?> _email = ValueNotifier(null);

  ValueListenable<String?> get email => _email;

  final ValueNotifier<String?> _password = ValueNotifier(null);

  ValueListenable<String?> get password => _password;

  EmailValidationError? get emailValidationError =>
      EmailValidator.getValidationError(email.value);

  PasswordValidationError? get passwordValidationError =>
      PasswordValidator.getValidationError(password.value);

  void onEmailChanged(String value) {
    _email.value = value;
  }

  void onPasswordChanged(String value) {
    _password.value = value;
  }

  Future<void> onLoginButtonClicked() async {
    showToast(uiText: FixedUiText(text: "Please try with Google"));
  }

  onForgotPasswordButtonClicked() {}

  onForgotPasswordButtonLongPressed() {}

  Future<void> signInWithGoogle() async {
    final userData = await loadData(authRepository.signInWithGoogle());

    await appRepository.setUserId(userData.id);

    final user = await authRepository.getUserById(userData.id);

    if(user == null){
      await authRepository.addUser(userData);
    }

    navigateToScreen(
      destination: HomeRoute(arguments: HomeArgument(userId: '123')),
      isClearBackStack: true,
    );
  }
}
