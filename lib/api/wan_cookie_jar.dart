import 'dart:io';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart' as web;
import 'package:wanandroid/env/provider/login.dart';

class WanCookieJar extends PersistCookieJar {
  final Uri baseUri;

  WanCookieJar({
    required this.baseUri,
    Storage? storage,
  }) : super(storage: storage);

  @override
  Future<void> saveFromResponse(Uri uri, List<Cookie> cookies) async {
    await super.saveFromResponse(uri, cookies);
    for (var cookie in cookies) {
      await web.CookieManager.instance().setCookie(
        url: uri,
        name: cookie.name,
        value: cookie.value,
        domain: cookie.domain,
        path: cookie.path ?? "/",
        expiresDate: cookie.expires?.millisecond,
        maxAge: cookie.maxAge,
        isSecure: cookie.secure,
        isHttpOnly: cookie.httpOnly,
      );
    }
    await _updateLoginState();
  }

  @override
  Future<void> delete(Uri uri, [bool withDomainSharedCookie = false]) async {
    await super.delete(uri, withDomainSharedCookie);
    await web.CookieManager.instance().deleteCookies(url: uri);
    await _updateLoginState();
  }

  @override
  Future<void> deleteAll() async {
    await super.deleteAll();
    await web.CookieManager.instance().deleteAllCookies();
    await _updateLoginState();
  }

  Future<void> _updateLoginState() async {
    LoginState(isLogin: await isLogin).notify();
  }

  Future<List<Cookie>> get cookies async {
    return await loadForRequest(baseUri);
  }

  Future<bool> get isLogin async {
    var cookies = await loadForRequest(baseUri);
    if (cookies.isEmpty) {
      return false;
    }
    bool hasUserCookie = false;
    bool hasPassCookie = false;
    for (var element in cookies) {
      if (element.name == 'loginUserName') {
        hasUserCookie = element.value.isNotEmpty;
      } else if (element.name == 'token_pass') {
        hasPassCookie = element.value.isNotEmpty;
      }
    }
    return hasUserCookie && hasPassCookie;
  }

  Future<void> logout() async {
    await delete(baseUri, true);
    LoginState(isLogin: false).notify();
  }
}
