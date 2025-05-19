import 'dart:io';

import 'package:data/di/data_module.dart';
import 'package:data/local/shared_preference/shared_pref_manager.dart';
import 'package:data/repository/app_repository_impl.dart';
import 'package:domain/di/di_module.dart';
import 'package:domain/repository/app_repository.dart';
import 'package:domain/util/logger.dart';
import 'package:flutter/material.dart';
import 'package:evntas/presentation/app/app_viewmodel.dart';
import 'package:evntas/presentation/base/base_ui_state.dart';
import 'package:evntas/presentation/base/screen_util/screen_util_builder.dart';
import 'package:evntas/presentation/localization/extension/language_localization_ext.dart';
import 'package:evntas/presentation/localization/generated/app_localizations.dart';
import 'package:evntas/presentation/navigation/app_router.dart';
import 'package:evntas/presentation/theme/dark_app_theme.dart';
import 'package:evntas/presentation/theme/extension/app_theme_mode_ext.dart';
import 'package:evntas/presentation/theme/light_app_theme.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends BaseUiState<MyApp> {
  final DataModule _dataModule = DataModule();
  late AppViewModel viewModel;

  @override
  void initState() {
    super.initState();
    final AppRepository appRepository = AppRepositoryImpl(
      sharedPrefManager: SharedPrefManager(),
    );
    DiModule().registerSingleton(appRepository);
    viewModel = AppViewModel(
      appRepository: appRepository,
    );
    DiModule().registerSingleton(viewModel);
    _dataModule.injectDependencies();
  }

  @override
  void dispose() {
    DiModule().unregisterSingleton<AppRepository>();
    DiModule().unregisterSingleton<AppViewModel>();
    _dataModule.removeDependencies();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String currentLocale = Platform.localeName;
    Logger.debug("current locale: $currentLocale");

    return valueListenableBuilder(
      listenable: viewModel.selectedThemeMode,
      builder: (context, selectedTheme) {
        return valueListenableBuilder(
          listenable: viewModel.selectedLanguage,
          builder: (context, languageState) {
            return MaterialApp(
              theme: LightAppTheme().getThemeData(),
              darkTheme: DarkAppTheme().getThemeData(),
              themeMode: selectedTheme.materialThemeMode,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: supportedLanguages,
              locale: languageState.toLanguage,
              builder: (context, child) {
                return ScreenUtilBuilder(child: child);
              },
              debugShowCheckedModeBanner: false,
              onGenerateRoute: AppRouter.generateRoute,
            );
          },
        );
      },
    );
  }
}
