import 'package:brasil_cripto/src/core/theme/colors.dart';
import 'package:brasil_cripto/src/core/theme/text_style.dart';
import 'package:flutter/material.dart';

abstract class AppTheme {
  static AppColors colors(BuildContext context) {
    return MediaQuery.of(context).platformBrightness == Brightness.dark ? DarkColors() : LightColors();
  }

  static bool isThemeDark(BuildContext context) {
    return MediaQuery.of(context).platformBrightness == Brightness.dark;
  }

  static bool isThemeLight(BuildContext context) {
    return MediaQuery.of(context).platformBrightness == Brightness.light;
  }

  static AppTextStyle get textStyle => AppTextStyle();

  static ThemeData light() {
    final colors = LightColors();
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: colors.background,
      appBarTheme: AppBarTheme(
        backgroundColor: colors.background,
        titleTextStyle: textStyle.title.copyWith(
          color: colors.titleText,
        ),
      ),
    );
  }

  static ThemeData dark() {
    final colors = DarkColors();
    return ThemeData(
      brightness: Brightness.dark,
      textTheme: TextTheme(
        titleMedium: textStyle.input.copyWith(
          color: colors.inputSecondary,
        ),
      ),
      scaffoldBackgroundColor: colors.background,
      appBarTheme: AppBarTheme(
        backgroundColor: colors.background,
        titleTextStyle: textStyle.title.copyWith(
          color: colors.titleText,
        ),
      ),
    );
  }
}
