import 'dart:io';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:wanandroid/api/wan_api.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';
import 'package:wanandroid/widget/expendable_fab.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebController {
  WebViewController? _controller;

  attachController(WebViewController controller) {
    _controller = controller;
  }

  detachController(WebViewController controller) {
    _controller = controller;
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
  final List<WebViewCookie> _webViewCookies = [];

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
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
    return WebView(
      backgroundColor: Theme.of(context).colorScheme.background,
      gestureNavigationEnabled: true,
      allowsInlineMediaPlayback: true,
      initialUrl: widget.url,
      initialCookies: _webViewCookies,
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (WebViewController webViewController) {
        widget.controller.attachController(webViewController);
      },
      onPageStarted: (String url) {
        widget.onProgress(0.0);
      },
      onPageFinished: (String url) {
        widget.onProgress(null);
      },
      onProgress: (int progress) {
        widget.onProgress((progress / 100.0).clamp(0.0, 1.0));
      },
      navigationDelegate: (NavigationRequest request) {
        var uri = Uri.parse(request.url);
        if (uri.scheme == 'http' || uri.scheme == 'https') {
          return NavigationDecision.navigate;
        }
        return NavigationDecision.prevent;
      },
    );
  }

  Future<List<WebViewCookie>> _loadWebCookies() async {
    var cookies = await WanApi.cookies;
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
