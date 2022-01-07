import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanandroid/env/theme/theme_model.dart';

class ThemeModelStore {
  static const String keyThemeMode = "themeMode";

  static Future<ThemeModel> load() async {
    var sp = await SharedPreferences.getInstance();
    var themeModeName = sp.getString(keyThemeMode);
    var themeMode = ThemeMode.values.firstWhere(
      (value) => value.name == themeModeName,
      orElse: () => ThemeMode.system,
    );
    return ThemeModel(
      themeMode: themeMode,
      lightThemeData: null,
      darkThemeData: null,
    );
  }

  static Future<void> save(ThemeModel themeModel) async {
    var sp = await SharedPreferences.getInstance();
    sp.setString(keyThemeMode, themeModel.themeMode.name);
  }
}
