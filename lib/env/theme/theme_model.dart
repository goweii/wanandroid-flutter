import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wanandroid/env/theme/themes.dart';

class ThemeModel with ChangeNotifier {
  static ThemeModel of(BuildContext context) {
    return Provider.of<ThemeModel>(context, listen: false);
  }

  static ThemeModel listen(BuildContext context) {
    return Provider.of<ThemeModel>(context, listen: true);
  }

  ThemeData _lightThemeData = Themes.light();

  ThemeData get lightTheme => _lightThemeData;

  set lightTheme(ThemeData themeData) {
    _lightThemeData = themeData;
    notifyListeners();
  }

  ThemeData _darkThemeData = Themes.dark();

  ThemeData get darkTheme => _darkThemeData;

  set darkTheme(ThemeData themeData) {
    _darkThemeData = themeData;
    notifyListeners();
  }

  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  set themeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }
}
