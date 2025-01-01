import 'dart:ui';

import 'package:hello_flutter/presentation/theme/app_theme.dart';
import 'package:hello_flutter/presentation/theme/color/app_colors.dart';
import 'package:hello_flutter/presentation/theme/color/light_app_colors.dart';

class LightAppTheme extends AppTheme {
  @override
  AppColors appColors = LightAppColors();

  @override
  Brightness brightness = Brightness.light;
}
