import 'dart:io';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wanandroid/api/wan_cookie_jar.dart';
import 'package:wanandroid/api/wan_cookies_interceptor.dart';
import 'package:wanandroid/env/http/http.dart';
import 'package:wanandroid/env/provider/login.dart';

class WanStore {
  static const host = 'www.wanandroid.com';
  static final WanStore _instance = WanStore._();

  WanStore._();

  factory WanStore() => _instance;

  WanCookieJar? _cookieJar;

  Future<void> init() async {
    Directory directory = await getApplicationSupportDirectory();
    _cookieJar = WanCookieJar(
      baseUri: Uri.https(host, ''),
      storage: FileStorage(directory.path + '/.cookies/'),
    );
    Http().addInterceptor(WanCookiesInterceptor(_cookieJar!));
  }

  Future<List<Cookie>> get cookies async {
    return await _cookieJar?.cookies ?? [];
  }

  Future<bool> get isLogin async {
    return await _cookieJar?.isLogin ?? false;
  }

  Future<UserInfo> get userInfo async {
    return await _cookieJar?.userInfo ?? const UserInfo.guest();
  }

  Future<void> logout() async {
    await _cookieJar?.logout();
  }
}
