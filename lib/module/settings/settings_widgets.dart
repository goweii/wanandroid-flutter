import 'package:flutter/material.dart';
import 'package:wanandroid/env/l10n/generated/l10n.dart';
import 'package:wanandroid/env/l10n/locale_model.dart';
import 'package:wanandroid/env/theme/theme_mode_ext.dart';
import 'package:wanandroid/env/theme/theme_model.dart';
import 'package:wanandroid/env/l10n/locale_ext.dart';
import 'package:wanandroid/widget/action_item.dart';
import 'package:wanandroid/widget/radio_box.dart';

class ThemeModeChoiceItem extends StatelessWidget {
  const ThemeModeChoiceItem({
    Key? key,
    required this.themeMode,
    this.onChoice,
  }) : super(key: key);

  final ThemeMode themeMode;
  final ValueChanged? onChoice;

  @override
  Widget build(BuildContext context) {
    return ActionItem(
      backgroundColor: Theme.of(context).backgroundColor,
      leading: themeMode.getIcon(context),
      title: themeMode.getName(context),
      treading: RadioBox(
        value: ThemeModel.listen(context).themeMode == themeMode,
      ),
      onPressed: () {
        ThemeModel.of(context).themeMode = themeMode;
      },
    );
  }
}

class LanguageChoiceItem extends StatelessWidget {
  const LanguageChoiceItem({
    Key? key,
    required this.locale,
    this.onChoice,
  }) : super(key: key);

  final Locale? locale;
  final ValueChanged? onChoice;

  @override
  Widget build(BuildContext context) {
    return ActionItem(
      backgroundColor: Theme.of(context).backgroundColor,
      title: Text(locale?.localeInfo?.languageName ??
          Strings.of(context).language_system),
      treading: RadioBox(
        value: LocaleModel.listen(context).locale == locale,
      ),
      onPressed: () {
        LocaleModel.of(context).locale = locale;
      },
    );
  }
}
