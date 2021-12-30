import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:wanandroid/env/l10n/generated/l10n.dart';

class Localization {
  static Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates = [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    Strings.delegate,
  ];

  static Iterable<Locale> supportedLocales = Strings.delegate.supportedLocales;

  static Locale? localeResolutionCallback(locale, supportedLocales) {
    if (locale != null) Strings.load(locale);
    return locale;
  }
}
