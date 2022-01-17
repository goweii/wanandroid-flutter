import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:wanandroid/widget/web/web_controller.dart';
import 'package:wanandroid/widget/web/web_options.dart';

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
    return InAppWebView(
      key: _globalKey,
      initialUrlRequest: _initialUrlRequest,
      initialOptions: WebOptions.groupOptions(context),
      onWebViewCreated: _onWebViewCreated,
      onUpdateVisitedHistory: _onUpdateVisitedHistory,
      onProgressChanged: _onProgressChanged,
      onLoadStart: _onLoadStart,
      onLoadStop: _onLoadStop,
      shouldOverrideUrlLoading: _shouldOverrideUrlLoading,
      onConsoleMessage: _onConsoleMessage,
    );
  }

  URLRequest? get _initialUrlRequest {
    if (widget.url == null) return null;
    return URLRequest(url: Uri.parse(widget.url!));
  }

  _onWebViewCreated(InAppWebViewController controller) {
    widget.controller.attachController(controller);
  }

  _onUpdateVisitedHistory(
    InAppWebViewController controller,
    Uri? url,
    bool? androidIsReload,
  ) {
    widget.onUpdateVisitedHistory?.call(url?.toString());
  }

  _onLoadStart(InAppWebViewController controller, Uri? uri) {
    widget.onProgress?.call(0.0);
  }

  _onLoadStop(InAppWebViewController controller, Uri? uri) {
    widget.onProgress?.call(null);
  }

  _onProgressChanged(InAppWebViewController controller, int progress) {
    if (progress > 95) {
      widget.onProgress?.call(null);
    } else {
      widget.onProgress?.call((progress / 100.0).clamp(0.0, 1.0));
    }
  }

  Future<NavigationActionPolicy> _shouldOverrideUrlLoading(
    InAppWebViewController controller,
    NavigationAction navigationAction,
  ) async {
    var scheme = navigationAction.request.url?.scheme;
    if (scheme == 'http' || scheme == 'https') {
      return NavigationActionPolicy.ALLOW;
    }
    return NavigationActionPolicy.CANCEL;
  }

  _onConsoleMessage(
    InAppWebViewController controller,
    ConsoleMessage consoleMessage,
  ) {
    if (kDebugMode) {
      print(consoleMessage);
    }
  }
}
