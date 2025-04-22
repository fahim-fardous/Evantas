import 'package:domain/model/app_info.dart';
import 'package:domain/model/app_language.dart';
import 'package:domain/model/app_theme_mode.dart';
import 'package:domain/model/google_user_data.dart';

abstract class AppRepository {
  Future<AppLanguage> getApplicationLocale();

  Future<AppThemeMode> getApplicationThemeMode();

  Future<void> saveApplicationLocale(AppLanguage appLanguage);

  Future<void> saveApplicationThemeMode(AppThemeMode themeMode);

  Future<AppInfo> getAppInfo();

  Future<bool> isOnBoardingComplete();

  Future<void> setOnBoardingComplete(bool isOnBoardingComplete);

  Future<void> setUserId(String id);

  Future<String> getUserId();
  
  Future<void> clearAll();
}
