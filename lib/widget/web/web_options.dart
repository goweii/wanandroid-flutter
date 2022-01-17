import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:wanandroid/env/theme/theme_model.dart';

class WebOptions {
  static InAppWebViewGroupOptions groupOptions(BuildContext context) {
    ThemeMode themeMode = ThemeModel.listen(context).themeMode;
    return InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        transparentBackground: true,
        useShouldOverrideUrlLoading: true,
        useShouldInterceptAjaxRequest: true,
        useShouldInterceptFetchRequest: true,
        useOnLoadResource: true,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
        mixedContentMode: AndroidMixedContentMode.MIXED_CONTENT_ALWAYS_ALLOW,
        forceDark: themeMode == ThemeMode.system
            ? AndroidForceDark.FORCE_DARK_AUTO
            : themeMode == ThemeMode.light
                ? AndroidForceDark.FORCE_DARK_OFF
                : AndroidForceDark.FORCE_DARK_ON,
        overScrollMode: AndroidOverScrollMode.OVER_SCROLL_NEVER,
        thirdPartyCookiesEnabled: true,
      ),
      ios: IOSInAppWebViewOptions(
        sharedCookiesEnabled: true,
      ),
    );
  }
}
