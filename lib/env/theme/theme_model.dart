import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wanandroid/env/theme/theme_model_store.dart';
import 'package:wanandroid/env/theme/themes.dart';

class ThemeModel with ChangeNotifier {
  static ThemeModel of(BuildContext context) {
    return Provider.of<ThemeModel>(context, listen: false);
  }

  static ThemeModel listen(BuildContext context) {
    return Provider.of<ThemeModel>(context, listen: true);
  }

  ThemeMode _themeMode;
  ThemeData _lightThemeData;
  ThemeData _darkThemeData;

  ThemeModel({
    ThemeMode? themeMode,
    ThemeData? lightThemeData,
    ThemeData? darkThemeData,
  })  : _themeMode = themeMode ?? ThemeMode.system,
        _lightThemeData = lightThemeData ?? Themes.light(),
        _darkThemeData = darkThemeData ?? Themes.dark();

  ThemeMode get themeMode => _themeMode;

  set themeMode(ThemeMode themeMode) {
    if (_themeMode == themeMode) return;
    _themeMode = themeMode;
    notifyListeners();
    ThemeModelStore.save(this);
  }

  ThemeData get lightTheme => _lightThemeData;

  set lightTheme(ThemeData themeData) {
    if (_lightThemeData == themeData) return;
    _lightThemeData = themeData;
    notifyListeners();
    ThemeModelStore.save(this);
  }

  ThemeData get darkTheme => _darkThemeData;

  set darkTheme(ThemeData themeData) {
    if (_darkThemeData == themeData) return;
    _darkThemeData = themeData;
    notifyListeners();
    ThemeModelStore.save(this);
  }
}
