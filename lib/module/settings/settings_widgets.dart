import 'package:flutter/material.dart';
import 'package:wanandroid/env/l10n/generated/l10n.dart';
import 'package:wanandroid/env/theme/theme_model.dart';
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
      leading: _themeIcon(context),
      title: _themeName(context),
      treading: RadioBox(
        value: ThemeModel.listen(context).themeMode == themeMode,
      ),
      onPressed: () {
        ThemeModel.of(context).themeMode = themeMode;
      },
    );
  }

  Text _themeName(BuildContext context) {
    switch (themeMode) {
      case ThemeMode.system:
        return Text(Strings.of(context).theme_mode_system);
      case ThemeMode.light:
        return Text(Strings.of(context).theme_mode_light);
      case ThemeMode.dark:
        return Text(Strings.of(context).theme_mode_dark);
    }
  }

  Icon _themeIcon(BuildContext context) {
    switch (themeMode) {
      case ThemeMode.system:
        return Icon(
          Icons.phone_android_rounded,
          color: Theme.of(context).colorScheme.primary,
        );
      case ThemeMode.light:
        return const Icon(
          Icons.light_mode_rounded,
          color: Colors.yellow,
        );
      case ThemeMode.dark:
        return Icon(
          Icons.dark_mode_rounded,
          color: Theme.of(context).colorScheme.onSurface,
        );
    }
  }
}
