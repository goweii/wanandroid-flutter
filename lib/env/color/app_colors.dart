import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color blueLight = Color(0xFF73a3f5);
  static const Color blue = Color(0xFF4282f4);
  static const Color blueDark = Color(0xFF3365BD);

  static const Color greenLight = Color(0xFF67db9d);
  static const Color green = Color(0xFF3cdc86);
  static const Color greenDark = Color(0xFF219F5C);

  static const Color orangeLight = Color(0xFFf78c65);
  static const Color orange = Color(0xFFf86734);
  static const Color orangeDark = Color(0xFFC34A1F);

  static const int _greyPrimaryValue = 0xFF7A7A7A;
  static const MaterialColor grey = MaterialColor(
    _greyPrimaryValue,
    <int, Color>{
      50: Color(0xFFF5F5F5),
      100: Color(0xFFEEEEEE),
      200: Color(0xFFD0D0D0),
      300: Color(0xFFB0B0B0),
      400: Color(0xFF9E9E9E),
      500: Color(_greyPrimaryValue),
      600: Color(0xFF555555),
      700: Color(0xFF333333),
      800: Color(0xFF232323),
      900: Color(0xFF121212),
    },
  );
}
