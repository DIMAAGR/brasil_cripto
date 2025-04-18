import 'package:flutter/material.dart';

abstract class AppColors {
  final Color background;
  final Color titleText;
  final Color notification;
  final Color white;
  final Color blue;
  final Color input;
  final Color inputSecondary;

  final Color green;
  final Color red;

  AppColors({
    required this.green,
    required this.red,
    required this.notification,
    required this.titleText,
    required this.background,
    required this.input,
    required this.inputSecondary,
  })  : white = const Color(0xFFFFFFFF),
        blue = const Color(0xFF246AFC);
}

class LightColors extends AppColors {
  LightColors()
      : super(
          red: const Color(0xFFFC0404),
          green: const Color(0xFF0FDB37),
          notification: const Color(0xFFFC1404),
          background: Colors.white,
          titleText: const Color(0xFF1D1D1D),
          input: const Color(0xFFEAEAEA),
          inputSecondary: const Color(0xFF1D1D1D),
        );
}

class DarkColors extends AppColors {
  DarkColors()
      : super(
          red: const Color(0xFFE74A4F),
          green: const Color(0xFF048404),
          notification: const Color(0xFFFC1404),
          background: const Color(0xFF1D1D1D),
          titleText: Colors.white,
          input: const Color(0xFF3A3A3A),
          inputSecondary: Colors.white,
        );
}
