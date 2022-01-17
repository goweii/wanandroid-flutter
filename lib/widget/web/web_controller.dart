import 'dart:convert';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:wanandroid/widget/web/web_share_info.dart';

class WebController {
  InAppWebViewController? realController;

  attachController(InAppWebViewController controller) {
    realController = controller;
  }

  detachController() {
    realController = null;
  }

  Future<String?> getTitle() async {
    return await realController?.getTitle();
  }

  Future<Uri?> getUrl() async {
    return await realController?.getUrl();
  }

  Future<bool> canGoBack() async {
    if (realController == null) {
      return false;
    }
    return await realController!.canGoBack();
  }

  Future<bool> canGoForward() async {
    if (realController == null) {
      return false;
    }
    return await realController!.canGoForward();
  }

  Future<void> goBack() async {
    await realController?.goBack();
  }

  Future<void> goForward() async {
    await realController?.goForward();
  }

  Future<WebShareInfo?> getShareInfo() async {
    if (realController == null) {
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
    String? url = (await getUrl())?.toString();
    String? title;
    String? desc;
    List<String>? imgs;
    try {
      dynamic result = await realController?.evaluateJavascript(source: js);
      var json = jsonDecode(result) as Map<String, dynamic>;
      title = json['title'] as String?;
      desc = json['desc'] as String?;
      imgs = (json['imgs'] as List<dynamic>?)?.map((e) => e as String).toList();
    } catch (_) {}
    if (title == null || title.isEmpty) {
      title = await getTitle();
    }
    url ??= '';
    title ??= '';
    desc ??= '';
    imgs ??= [];
    imgs.removeWhere((e) => e.isEmpty);
    return WebShareInfo(
      url: url,
      title: title,
      desc: desc,
      imgs: imgs,
    );
  }

  Future<void> goTop() async {
    String js = """
javascript:(
  function(){
    var timer = null;
    cancelAnimationFrame(timer);
    var startTime = new Date();
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
    await realController?.evaluateJavascript(source: js);
  }
}