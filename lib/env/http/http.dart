import 'dart:io';

import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';

class Http {
  static final Http _instance = Http._();

  Http._();

  factory Http() => _instance;

  final Dio _dio = Dio();
  CookieJar? _cookieJar;

  Future<void> init() async {
    Directory directory = await getApplicationSupportDirectory();
    _cookieJar =
        PersistCookieJar(storage: FileStorage(directory.path + '/.cookies/'));
    CookieManager cookieManager = CookieManager(_cookieJar!);
    _dio.interceptors.add(cookieManager);
  }

  Future<List<Cookie>> loadCookies(Uri uri) async {
    return await _cookieJar?.loadForRequest(uri) ?? [];
  }

  Future<void> deleteCookies(Uri uri) async {
    return await _cookieJar?.delete(uri, true);
  }

  Future<void> deleteAllCookies() async {
    return await _cookieJar?.deleteAll();
  }

  Future<Response<T>> get<T>(
    Uri uri, {
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) =>
      _dio.getUri(uri,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress);

  Future<Response<T>> post<T>(
    Uri uri, {
    dynamic data,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) =>
      _dio.postUri(uri,
          data: data,
          options: options,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress);
}
