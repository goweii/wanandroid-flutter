import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanandroid/env/l10n/locale_model.dart';

class LocaleModelStore {
  static const String keyLocale = "locale";

  static Future<LocaleModel> load() async {
    var sp = await SharedPreferences.getInstance();
    var localeTag = sp.getString(keyLocale);
    var tags = localeTag?.split('-');
    if (tags == null || tags.length != 3) {
      return LocaleModel();
    }
    var languageCode = tags[0];
    if (languageCode.isEmpty) {
      return LocaleModel();
    }
    var countryCode = tags[1].isNotEmpty ? tags[1] : null;
    var scriptCode = tags[2].isNotEmpty ? tags[2] : null;
    return LocaleModel(
      locale: Locale.fromSubtags(
        languageCode: languageCode,
        countryCode: countryCode,
        scriptCode: scriptCode,
      ),
    );
  }

  static Future<void> save(LocaleModel localeModel) async {
    var sp = await SharedPreferences.getInstance();
    var languageCode = localeModel.locale?.languageCode ?? '';
    var countryCode = localeModel.locale?.countryCode ?? '';
    var scriptCode = localeModel.locale?.scriptCode ?? '';
    var localeTag = '$languageCode-$countryCode-$scriptCode';
    sp.setString(keyLocale, localeTag);
  }
}
