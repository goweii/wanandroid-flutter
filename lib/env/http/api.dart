import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:wanandroid/env/http/http.dart';

enum HttpMethod {
  get,
  post,
}

enum BodyType {
  form,
  json,
}

class ApiException {
  final int? code;
  final String? msg;

  ApiException({
    required this.code,
    required this.msg,
  });
}

abstract class RespConverter<Resp> {
  Resp convert(Map<String, dynamic> json);
}

class TypeOf<T> {
  @override
  Type get runtimeType => T.runtimeType;

  void get voidValue {}
}

class Api<Resp> {
  Api({
    required this.method,
    required String host,
    required String path,
    Map<String, dynamic>? queries,
    this.headers,
    this.body,
    this.bodyType = BodyType.form,
    required this.converter,
  }) : uri = Uri.https(host, path, queries);

  final HttpMethod method;
  final Uri uri;
  final Map<String, String>? headers;
  final Map<String, dynamic>? body;
  final BodyType? bodyType;
  final RespConverter<Resp>? converter;

  Future<Resp> request() async {
    var response = await _send();
    if (response.statusCode != 200) {
      throw ApiException(
        code: response.statusCode,
        msg: response.statusMessage,
      );
    }
    return _convertResp(response.data);
  }

  Resp _convertResp(String? source) {
    if (converter == null) {
      if (source == null || source.isEmpty) {
        var voidType = TypeOf<void>();
        if (Resp.runtimeType == voidType.runtimeType) {
          return voidType.voidValue as Resp;
        }
        if (Resp is String?) {
          return null as Resp;
        }
        throw ApiException(
          code: null,
          msg: 'Empty response data, Generic T must be void or String?',
        );
      }
      throw ApiException(
        code: null,
        msg: 'No RespConverter to convert response data',
      );
    }
    if (source == null || source.isEmpty) {
      throw ApiException(
        code: null,
        msg: 'Empty response data',
      );
    }
    try {
      var json = jsonDecode(source) as Map<String, dynamic>;
      Resp resp = converter!.convert(json);
      return resp;
    } catch (e) {
      throw ApiException(
        code: null,
        msg: e.toString(),
      );
    }
  }

  Future<Response<String>> _send() async {
    final Future<Response<String>> task;
    switch (method) {
      case HttpMethod.get:
        task = Http().get(
          uri,
          options: Options(
            headers: headers,
          ),
        );
        break;
      case HttpMethod.post:
        task = Http().post(
          uri,
          data: formatBody(),
          options: Options(
            headers: headers,
          ),
        );
        break;
    }
    return await task;
  }

  dynamic formatBody() {
    if (body == null) {
      return null;
    }
    if (bodyType == null) {
      return body;
    }
    switch (bodyType!) {
      case BodyType.form:
        return FormData.fromMap(body!);
      case BodyType.json:
        return jsonEncode(body);
    }
  }
}
