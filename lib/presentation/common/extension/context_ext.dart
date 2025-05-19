import 'package:flutter/material.dart';
import 'package:evntas/presentation/localization/generated/app_localizations.dart';

extension ContextExtension on BuildContext {
  AppLocalizations get localizations => AppLocalizations.of(this)!;
}
