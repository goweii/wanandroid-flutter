import 'package:wanandroid/api/wan/bean/wan_resp.dart';
import 'package:wanandroid/api/wan/wan_store.dart';
import 'package:wanandroid/env/http/api.dart';

class WanApi<T> extends Api<T> {
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
          host: WanStore.host,
          path: path,
          body: body,
          bodyType: bodyType,
          converter: WanRespConverter<T>(fromJsonT: fromJsonT),
        );
}

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
