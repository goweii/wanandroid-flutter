import 'package:dio/dio.dart';

class Http {
  static final Http _instance = Http._();

  Http._();

  factory Http() => _instance;

  final Dio _dio = Dio();

  addInterceptor(Interceptor interceptor) {
    _dio.interceptors.add(interceptor);
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
