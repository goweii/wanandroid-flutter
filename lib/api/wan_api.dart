import 'dart:io';

import 'package:wanandroid/api/bean/wan_resp.dart';
import 'package:wanandroid/env/http/api.dart';
import 'package:wanandroid/env/http/http.dart';

class WanRespConverter<T> implements RespConverter<T> {
  final T Function(dynamic json)? fromJsonT;

  WanRespConverter({
    required this.fromJsonT,
  });

  @override
  T convert(Map<String, dynamic> json) {
    if (fromJsonT == null) {
      return json as T;
    }
    WanResp<T> resp = WanResp<T>.fromJson(json, fromJsonT!);
    if (resp.errorCode == 0) {
      return resp.data;
    } else {
      throw ApiException(
        code: resp.errorCode,
        msg: resp.errorMsg,
      );
    }
  }
}

class WanApi<T> extends Api<T> {
  static const host = 'www.wanandroid.com';

  static Future<List<Cookie>> get cookies async {
    return await Http().loadCookies(Uri.https(host, ''));
  }

  static Future<bool> get isLogin async {
    var cookies = await Http().loadCookies(Uri.https(host, ''));
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

  static Future<void> clearLogin() async {
    Uri uri = Uri.https(host, '');
    return await Http().deleteCookies(uri);
  }

  WanApi({
    required HttpMethod method,
    required String path,
    Map<String, dynamic>? queries,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    BodyType bodyType = BodyType.form,
    required T Function(dynamic json)? fromJsonT,
  }) : super(
          method: method,
          host: host,
          path: path,
          body: body,
          bodyType: bodyType,
          converter: WanRespConverter<T>(fromJsonT: fromJsonT),
        );
}
