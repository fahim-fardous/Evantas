import 'package:evntas/presentation/feature/auth/validator/email_validator.dart';
import 'package:evntas/presentation/localization/generated/app_localizations.dart';

extension EmailValidationErrorExt on EmailValidationError {
  String getLocalizedMessage(AppLocalizations localizations) {
    switch (this) {
      case EmailValidationError.empty:
        return localizations.login__login_form__email_field_empty;
      case EmailValidationError.invalid:
        return localizations.login__login_form__email_field_invalid_email_text;
    }
  }
}
