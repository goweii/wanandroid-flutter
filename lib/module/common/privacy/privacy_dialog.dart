import 'dart:io';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanandroid/api/com/com_const.dart';
import 'package:wanandroid/entity/article_info.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';
import 'package:wanandroid/env/l10n/generated/l10n.dart';
import 'package:wanandroid/env/route/route_map.dart';
import 'package:wanandroid/env/route/router.dart';
import 'package:wanandroid/widget/main_button.dart';

class PrivacyDialog extends StatefulWidget {
  static const String spKeyPrivacyDialogShown = 'privacy_dialog_shown';

  static Future<void> show({required BuildContext context}) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool shown = sp.getBool(spKeyPrivacyDialogShown) ?? false;
    if (shown) return;
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      useSafeArea: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: const PrivacyDialog(),
        );
      },
    );
  }

  const PrivacyDialog({Key? key}) : super(key: key);

  @override
  _PrivacyDialogState createState() => _PrivacyDialogState();
}

class _PrivacyDialogState extends State<PrivacyDialog> {
  late TapGestureRecognizer _tapGestureRecognizer;

  @override
  void initState() {
    super.initState();
    _tapGestureRecognizer = TapGestureRecognizer();
  }

  @override
  void dispose() {
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String content = Strings.of(context).privacy_dialog_content;
    List<String> contents = content.split('%s');
    assert(contents.length == 2);
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 16,
                sigmaY: 16,
              ),
              child: Container(
                color: themeData.colorScheme.surface.withOpacity(0.6),
              ),
            ),
          ),
          Positioned.fill(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  title: Text(
                    Strings.of(context).privacy_policy,
                  ),
                  leading: const SizedBox(),
                  titleTextStyle:
                      themeData.appBarTheme.titleTextStyle?.copyWith(
                    color: themeData.colorScheme.onSurface,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: AppDimens.marginNormal,
                      right: AppDimens.marginNormal,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                style: themeData.textTheme.bodyText2?.copyWith(
                                  height: 1.6,
                                ),
                                children: [
                                  TextSpan(text: contents[0]),
                                  TextSpan(
                                    text: Strings.of(context)
                                        .privacy_dialog_content_s,
                                    style:
                                        themeData.textTheme.bodyText2?.copyWith(
                                      color: themeData.colorScheme.primary,
                                    ),
                                    recognizer: _tapGestureRecognizer
                                      ..onTap = _onOpenPrivacy,
                                  ),
                                  TextSpan(text: contents[1]),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: AppDimens.marginNormal),
                        Center(
                          child: MainButton(
                            child: Text(Strings.of(context).agree),
                            transitionDuration: null,
                            onPressed: _onAgree,
                          ),
                        ),
                        const SizedBox(height: AppDimens.marginHalf),
                        Center(
                          child: MainButton(
                            child: Text(Strings.of(context).disagree),
                            transitionDuration: null,
                            backgroundColor: themeData.colorScheme.error,
                            foregroundColor: themeData.colorScheme.onError,
                            onPressed: _onDisagree,
                          ),
                        ),
                        const SizedBox(height: AppDimens.marginNormal),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _onOpenPrivacy() {
    AppRouter.of(context).pushNamed(
      RouteMap.articlePage,
      arguments: ArticleInfo.fromUrl(ComConst.privacyPolicyUrl),
    );
  }

  Future<void> _onAgree() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setBool(PrivacyDialog.spKeyPrivacyDialogShown, true);
    Navigator.pop(context);
  }

  Future<void> _onDisagree() async {
    exit(0);
  }
}
