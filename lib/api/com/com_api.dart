import 'package:wanandroid/api/com/bean/com_resp.dart';
import 'package:wanandroid/env/http/api.dart';

class ComApi<T> extends Api<T> {
  ComApi({
    required HttpMethod method,
    required String path,
    Map<String, dynamic>? queries,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    BodyType bodyType = BodyType.form,
    required T Function(dynamic json)? fromJsonT,
  }) : super(
          method: method,
          host: 'gitee.com',
          path: '/goweii/flutter_wanandroid_server/raw/master' + path,
          body: body,
          bodyType: bodyType,
          converter: ComRespConverter<T>(fromJsonT: fromJsonT),
        );
}

class ComRespConverter<T> implements RespConverter<T> {
  final T Function(dynamic json)? fromJsonT;

  ComRespConverter({
    required this.fromJsonT,
  });

  @override
  T convert(Map<String, dynamic> json) {
    if (fromJsonT == null) {
      return json as T;
    }
    ComResp<T> resp = ComResp<T>.fromJson(json, fromJsonT!);
    if (resp.code == 0) {
      return resp.data;
    } else {
      throw ApiException(
        code: resp.code,
        msg: resp.msg,
      );
    }
  }
}
