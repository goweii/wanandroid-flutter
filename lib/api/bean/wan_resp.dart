import 'package:json_annotation/json_annotation.dart';

part 'wan_resp.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class WanResp<T> {
  final int errorCode;
  final String errorMsg;
  final T data;

  WanResp({
    required this.errorCode,
    required this.errorMsg,
    required this.data,
  });

  factory WanResp.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json) fromJsonT,
  ) =>
      _$WanRespFromJson<T>(json, fromJsonT);

  Map<String, dynamic> toJson(
    Object? Function(T value) toJsonT,
  ) =>
      _$WanRespToJson<T>(this, toJsonT);
}
