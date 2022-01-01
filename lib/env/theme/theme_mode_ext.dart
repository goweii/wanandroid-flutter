import 'package:flutter/material.dart';
import 'package:wanandroid/env/l10n/generated/l10n.dart';

extension ThemeModeExt on ThemeMode {

  Text getName(BuildContext context) {
    switch (this) {
      case ThemeMode.system:
        return Text(Strings.of(context).theme_mode_system);
      case ThemeMode.light:
        return Text(Strings.of(context).theme_mode_light);
      case ThemeMode.dark:
        return Text(Strings.of(context).theme_mode_dark);
    }
  }

  Icon getIcon(BuildContext context) {
    switch (this) {
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