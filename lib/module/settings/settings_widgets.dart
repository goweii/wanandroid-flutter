import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/env/l10n/generated/l10n.dart';
import 'package:wanandroid/env/l10n/locale_model.dart';
import 'package:wanandroid/env/l10n/locale_ext.dart';
import 'package:wanandroid/env/theme/theme_mode_ext.dart';
import 'package:wanandroid/env/theme/theme_model.dart';
import 'package:wanandroid/widget/action_item.dart';
import 'package:wanandroid/widget/radio_box.dart';

class ThemeModeChoiceItem extends StatelessWidget {
  const ThemeModeChoiceItem({
    Key? key,
    required this.themeMode,
  }) : super(key: key);

  final ThemeMode themeMode;

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
  LanguageChoiceItem({
    Key? key,
    required Locale? locale,
  })  : _locale = locale,
        _logo = locale?.localeInfo?.locales.first.logo,
        super(key: key);

  final Locale? _locale;
  final String? _logo;

  @override
  Widget build(BuildContext context) {
    return ActionItem(
      backgroundColor: Theme.of(context).backgroundColor,
      leading: CachedNetworkImage(
        imageUrl: _logo ?? '',
        width: 24,
        height: 24,
        fit: BoxFit.contain,
        placeholder: (context, url) => const Icon(Icons.language_rounded),
        errorWidget: (context, url, error) =>
            const Icon(Icons.language_rounded),
      ),
      title: Text(_locale?.localeInfo?.languageName ??
          Strings.of(context).language_system),
      treading: RadioBox(
        value: LocaleModel.listen(context).locale == _locale,
      ),
      onPressed: () {
        LocaleModel.of(context).locale = _locale;
      },
    );
  }
}
