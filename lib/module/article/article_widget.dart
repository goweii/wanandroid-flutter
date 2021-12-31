import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:wanandroid/api/wan_store.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';
import 'package:wanandroid/env/theme/theme_model.dart';
import 'package:wanandroid/widget/expendable_fab.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebController {
  InAppWebViewController? _controller;

  attachController(InAppWebViewController controller) {
    _controller = controller;
  }

  detachController() {
    _controller = null;
  }

  Future<bool> canGoBack() async {
    if (_controller == null) {
      return false;
    }
    return await _controller!.canGoBack();
  }

  Future<bool> canGoForward() async {
    if (_controller == null) {
      return false;
    }
    return await _controller!.canGoForward();
  }

  Future<void> goBack() async {
    await _controller?.goBack();
  }

  Future<void> goForward() async {
    await _controller?.goForward();
  }
}

class Web extends StatefulWidget {
  const Web({
    Key? key,
    required this.url,
    required this.onProgress,
    required this.controller,
  }) : super(key: key);

  final String? url;
  final ValueChanged<double?> onProgress;
  final WebController controller;

  @override
  State<Web> createState() => _WebState();
}

class _WebState extends State<Web> {
  final GlobalKey _globalKey = GlobalKey();

  final List<WebViewCookie> _webViewCookies = [];

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      //WebView.platform = SurfaceAndroidWebView();
    }
    _loadWebCookies().then((value) {
      setState(() {
        _webViewCookies.addAll(value);
      });
    });
  }

  @override
  void dispose() {
    _webViewCookies.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeMode themeMode = ThemeModel.listen(context).themeMode;
    return InAppWebView(
      key: _globalKey,
      initialUrlRequest: URLRequest(url: Uri.parse(widget.url!)),
      initialOptions: InAppWebViewGroupOptions(
        crossPlatform: InAppWebViewOptions(
          transparentBackground: true,
        ),
        android: AndroidInAppWebViewOptions(
          useHybridComposition: true,
          forceDark: themeMode == ThemeMode.system
              ? AndroidForceDark.FORCE_DARK_AUTO
              : themeMode == ThemeMode.light
                  ? AndroidForceDark.FORCE_DARK_OFF
                  : AndroidForceDark.FORCE_DARK_ON,
          overScrollMode: AndroidOverScrollMode.OVER_SCROLL_ALWAYS,
        ),
        ios: IOSInAppWebViewOptions(),
      ),
      //initialCookies: _webViewCookies,
      onWebViewCreated: (InAppWebViewController controller) {
        widget.controller.attachController(controller);
      },
      onProgressChanged: (controller, progress) {
        widget.onProgress((progress / 100.0).clamp(0.0, 1.0));
      },
      onLoadStart: (controller, url) {
        widget.onProgress(0.0);
      },
      onLoadStop: (controller, url) {
        widget.onProgress(null);
      },
      shouldOverrideUrlLoading: (controller, navigationAction) async {
        var scheme = navigationAction.request.url?.scheme;
        if (scheme == 'http' || scheme == 'https') {
          return NavigationActionPolicy.ALLOW;
        }
        return NavigationActionPolicy.CANCEL;
      },
      
    );
  }

  Future<List<WebViewCookie>> _loadWebCookies() async {
    var cookies = await WanStore().cookies;
    List<WebViewCookie> webCookies = [];
    for (var cookie in cookies) {
      if (cookie.domain == null || cookie.domain!.isEmpty) {
        continue;
      }
      webCookies.add(WebViewCookie(
        name: cookie.name,
        value: cookie.value,
        domain: cookie.domain!,
      ));
    }
    return webCookies;
  }
}

class FabMenu extends StatelessWidget {
  const FabMenu({
    Key? key,
    required this.onBackPress,
    required this.progress,
  }) : super(key: key);

  final VoidCallback onBackPress;
  final double? progress;

  @override
  Widget build(BuildContext context) {
    return ExpendableFab(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.marginNormal,
        vertical: AppDimens.bottomBarHeight + AppDimens.marginNormal,
      ),
      mainFabBuilder: (context, f) {
        return Fab(
          icon: CircularPercentIndicator(
            radius: AppDimens.iconButtonSize,
            percent: progress ?? 0.0,
            lineWidth: 3.0,
            backgroundColor: Colors.transparent,
            circularStrokeCap: CircularStrokeCap.round,
            center: Icon(
              f == 0.0 ? Icons.arrow_back_ios_new_rounded : Icons.close_rounded,
            ),
            progressColor: progress != null
                ? Theme.of(context).colorScheme.primary
                : Colors.transparent,
          ),
          tip: '',
          onPressed: onBackPress,
        );
      },
      actionFabs: [
        Fab(
          icon: const Icon(Icons.favorite_rounded),
          tip: 'Collect',
          onPressed: () {},
        ),
        Fab(
          icon: const Icon(Icons.share),
          tip: 'Shard',
          onPressed: () {},
        ),
        Fab(
          icon: const Icon(Icons.open_in_browser_rounded),
          tip: 'Browser',
          onPressed: () {},
        ),
      ],
    );
  }
}
