import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wanandroid/env/l10n/locale_model.dart';

class LocaleModelProvider extends ChangeNotifierProvider<LocaleModel> {
  LocaleModelProvider({
    Key? key,
    required LocaleModel localeModel,
  }) : super(
          key: key,
          create: (context) => localeModel,
        );
}
