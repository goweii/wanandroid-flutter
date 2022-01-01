import 'package:flutter/material.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';
import 'package:wanandroid/env/l10n/generated/l10n.dart';
import 'package:wanandroid/env/provider/login.dart';
import 'package:wanandroid/env/theme/theme_mode_ext.dart';
import 'package:wanandroid/env/theme/theme_model.dart';
import 'package:wanandroid/module/settings/settings.repo.dart';
import 'package:wanandroid/module/settings/settings_widgets.dart';
import 'package:wanandroid/widget/action_item.dart';
import 'package:wanandroid/widget/main_button.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final SettingsRepo _repo = SettingsRepo();

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
              leading: ThemeModel.listen(context).themeMode.getIcon(context),
              title: Text(Strings.of(context).choice_theme_mode),
              tip: ThemeModel.listen(context).themeMode.getName(context),
              children: ThemeMode.values
                  .map((e) => ThemeModeChoiceItem(themeMode: e))
                  .toList(),
            ),
            if (LoginState.listen(context).isLogin) ...[
              const SizedBox(height: AppDimens.marginLarge),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: AppDimens.marginNormal * 3,
                ),
                child: MainButton(
                  child: Text(Strings.of(context).logout),
                  onPressed: _logout,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<dynamic> _logout() async {
    await _repo.logout();
  }
}
