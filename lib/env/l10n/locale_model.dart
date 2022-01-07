import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wanandroid/env/l10n/locale_model_store.dart';

class LocaleModel extends ChangeNotifier {
  static LocaleModel of(BuildContext context) {
    return Provider.of<LocaleModel>(context, listen: false);
  }

  static LocaleModel listen(BuildContext context) {
    return Provider.of<LocaleModel>(context, listen: true);
  }

  Locale? _locale;

  LocaleModel({
    Locale? locale,
  }) : _locale = locale;

  Locale? get locale => _locale;

  set locale(Locale? locale) {
    if (_locale == locale) return;
    _locale = locale;
    notifyListeners();
    LocaleModelStore.save(this);
  }
}
