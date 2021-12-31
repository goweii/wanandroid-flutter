import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wanandroid/api/wan_api.dart';
import 'package:wanandroid/bus/bus.dart';
import 'package:wanandroid/bus/events/login_event.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';
import 'package:wanandroid/env/l10n/generated/l10n.dart';
import 'package:wanandroid/env/theme/theme_model.dart';
import 'package:wanandroid/module/settings/settings_widgets.dart';
import 'package:wanandroid/widget/action_item.dart';
import 'package:wanandroid/widget/main_button.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isLogin = false;

  @override
  void initState() {
    super.initState();
    WanApi.isLogin.then((value) => setState(() => _isLogin = value));
    Bus().on<LoginEvent>().listen((event) {
      setState(() {
        _isLogin = event.login;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.of(context).settings_title),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            ActionItem(
              leading: _themeIcon(),
              title: Text(Strings.of(context).choice_theme_mode),
              tip: _themeName(),
              children: const [
                ThemeModeChoiceItem(
                  themeMode: ThemeMode.system,
                ),
                ThemeModeChoiceItem(
                  themeMode: ThemeMode.light,
                ),
                ThemeModeChoiceItem(
                  themeMode: ThemeMode.dark,
                ),
              ],
            ),
            if (_isLogin) ...[
              const SizedBox(height: AppDimens.marginLarge),
              MainButton(
                child: Text(Strings.of(context).logout),
                onPressed: () {
                  WanApi.clearLogin().then((value) {
                    Bus().send(LoginEvent(false));
                  });
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  Text _themeName() {
    var mode = ThemeModel.listen(context).themeMode;
    switch (mode) {
      case ThemeMode.system:
        return Text(Strings.of(context).theme_mode_system);
      case ThemeMode.light:
        return Text(Strings.of(context).theme_mode_light);
      case ThemeMode.dark:
        return Text(Strings.of(context).theme_mode_dark);
    }
  }

  Icon _themeIcon() {
    var mode = ThemeModel.listen(context).themeMode;
    switch (mode) {
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
