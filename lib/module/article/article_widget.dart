import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';
import 'package:wanandroid/env/theme/theme_model.dart';
import 'package:wanandroid/widget/expendable_fab.dart';

class WebShareInfo {
  final String? url;
  final String? title;
  final String? desc;
  final List<String>? imgs;

  WebShareInfo({
    required this.url,
    required this.title,
    required this.desc,
    required this.imgs,
  });

  WebShareInfo.fromJson(Map<String, dynamic> json)
      : url = null,
        title = json['title'] as String,
        desc = json['desc'] as String,
        imgs = json['imgs'] as List<String>;
}

class WebController {
  InAppWebViewController? _controller;

  attachController(InAppWebViewController controller) {
    _controller = controller;
  }

  detachController() {
    _controller = null;
  }

  Future<String?> getTitle() async {
    return await _controller?.getTitle();
  }

  Future<Uri?> getUrl() async {
    return await _controller?.getUrl();
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

  Future<WebShareInfo?> getShareInfo() async {
    if (_controller == null) {
      return null;
    }
    String js = """
javascript:(
  function getShareInfo() {
    var map = {};
    map["title"] = document.title;
    map["desc"] = document.querySelector('meta[name="description"]').getAttribute('content');
    var imgElements = document.getElementsByTagName("img");
    var imgs = [];
    for(var i = 0 ; i < imgElements.length; i++){
      var imgEle = imgElements[i];
      var w = imgEle.naturalWidth;
      var h = imgEle.naturalHeight;
      if(w > 200 && h > 100){
        imgs.push(imgEle.src);
      }
    }
    map["imgs"] = imgs;
    return JSON.stringify(map);;
  }
)()
""";
    try {
      dynamic result = await _controller?.evaluateJavascript(source: js);
      var json = jsonDecode(result) as Map<String, dynamic>;
      return WebShareInfo.fromJson(json);
    } catch (_) {
      return WebShareInfo(
        url: (await getUrl())?.toString(),
        title: await getTitle(),
        desc: null,
        imgs: null,
      );
    }
  }

  Future<void> goTop() async {
    String js = """
javascript:(
  function(){
    var timer = null;
    cancelAnimationFrame(timer);
    var startTime = +new Date();
    var b = document.body.scrollTop || document.documentElement.scrollTop;
    var d = 500;
    var c = b;
    var timer = requestAnimationFrame(function func(){
      var t = d - Math.max(0,startTime - (+new Date()) + d);
      document.documentElement.scrollTop = document.body.scrollTop = t * (-c) / d + b;
      timer = requestAnimationFrame(func);
      if(t == d){
        cancelAnimationFrame(timer);
      }
    });
  }
)() 
""";
    await _controller?.evaluateJavascript(source: js);
  }
}

class Web extends StatefulWidget {
  const Web({
    Key? key,
    required this.url,
    required this.controller,
    this.onProgress,
    this.onUpdateVisitedHistory,
  }) : super(key: key);

  final String? url;
  final ValueChanged<double?>? onProgress;
  final ValueChanged<String?>? onUpdateVisitedHistory;
  final WebController controller;

  @override
  State<Web> createState() => _WebState();
}

class _WebState extends State<Web> {
  final GlobalKey _globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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
      onWebViewCreated: (InAppWebViewController controller) {
        widget.controller.attachController(controller);
      },
      onUpdateVisitedHistory: (controller, url, androidIsReload) {
        widget.onUpdateVisitedHistory?.call(url?.toString());
      },
      onProgressChanged: (controller, progress) {
        if (progress > 95) {
          widget.onProgress?.call(null);
        } else {
          widget.onProgress?.call((progress / 100.0).clamp(0.0, 1.0));
        }
      },
      onLoadStart: (controller, url) {
        widget.onProgress?.call(0.0);
      },
      onLoadStop: (controller, url) {
        widget.onProgress?.call(null);
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
}

class FabMenu extends StatelessWidget {
  const FabMenu({
    Key? key,
    required this.onBackPress,
    required this.progress,
    required this.actions,
  }) : super(key: key);

  final VoidCallback onBackPress;
  final double? progress;
  final List<Fab> actions;

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
            center: Transform.rotate(
              angle: f * math.pi * 0.5,
              child: const Icon(Icons.arrow_back_ios_new_rounded),
            ),
            progressColor: progress != null
                ? Theme.of(context).colorScheme.primary
                : Colors.transparent,
          ),
          tip: '',
          onPressed: onBackPress,
        );
      },
      actionFabs: actions,
    );
  }
}
