import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/api/com/com_const.dart';
import 'package:wanandroid/entity/article_info.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';
import 'package:wanandroid/env/l10n/generated/l10n.dart';
import 'package:wanandroid/env/l10n/locale_model.dart';
import 'package:wanandroid/env/l10n/locale_ext.dart';
import 'package:wanandroid/env/l10n/localization.dart';
import 'package:wanandroid/env/mvvm/data_provider.dart';
import 'package:wanandroid/env/provider/login.dart';
import 'package:wanandroid/env/route/route_map.dart';
import 'package:wanandroid/env/route/router.dart';
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
      body: SizedBox.expand(
        child: Align(
          alignment: Alignment.topCenter,
          child: OrientationBuilder(builder: (context, orientaton) {
            var isPortrait = orientaton == Orientation.portrait;
            return Container(
              constraints: BoxConstraints(
                maxWidth: isPortrait
                    ? double.infinity
                    : AppDimens.gridMaxCrossAxisExtent,
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ActionItem(
                      leading:
                          ThemeModel.listen(context).themeMode.getIcon(context),
                      title: Text(Strings.of(context).choice_theme_mode),
                      tip:
                          ThemeModel.listen(context).themeMode.getName(context),
                      children: ThemeMode.values
                          .map((e) => ThemeModeChoiceItem(themeMode: e))
                          .toList(),
                    ),
                    DataConsumer<LocaleModel>(builder: (context, localeModel) {
                      var localeInfo = localeModel.locale?.localeInfo;
                      var logo = localeInfo?.locales.first.logo;
                      return ActionItem(
                        leading: CachedNetworkImage(
                          imageUrl: logo ?? '',
                          width: 24,
                          height: 24,
                          fit: BoxFit.contain,
                          placeholder: (context, url) =>
                              const Icon(Icons.language_rounded),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.language_rounded),
                        ),
                        title: Text(Strings.of(context).choice_language),
                        tip: Text(
                          localeInfo?.languageName ??
                              Strings.of(context).language_system,
                        ),
                        children: <Locale?>[
                          null,
                          ...Localization.supportedLocales,
                        ].map((e) => LanguageChoiceItem(locale: e)).toList(),
                      );
                    }),
                    ActionItem(
                      leading: const Icon(Icons.privacy_tip_outlined),
                      title: Text(Strings.of(context).privacy_policy),
                      onPressed: () {
                        AppRouter.of(context).pushNamed(
                          RouteMap.articlePage,
                          arguments:
                              ArticleInfo.fromUrl(ComConst.privacyPolicyUrl),
                        );
                      },
                    ),
                    ActionItem(
                      leading: const Icon(Icons.info_outline_rounded),
                      title: Text(Strings.of(context).about_title),
                      onPressed: () {
                        AppRouter.of(context).pushNamed(RouteMap.aboutPage);
                      },
                    ),
                    if (LoginState.listen(context).isLogin) ...[
                      const SizedBox(height: AppDimens.marginLarge),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: AppDimens.marginNormal,
                        ),
                        child: MainButton(
                          child: Text(Strings.of(context).logout),
                          onPressed: _logout,
                        ),
                      ),
                    ],
                    const SizedBox(height: AppDimens.marginLarge),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Future<dynamic> _logout() async {
    await _repo.logout();
  }
}
