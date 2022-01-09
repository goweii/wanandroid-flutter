import 'package:json_annotation/json_annotation.dart';

part 'com_resp.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ComResp<T> {
  final int code;
  final String msg;
  final T data;

  ComResp({
    required this.code,
    required this.msg,
    required this.data,
  });

  factory ComResp.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json) fromJsonT,
  ) =>
      _$ComRespFromJson<T>(json, fromJsonT);

  Map<String, dynamic> toJson(
    Object? Function(T value) toJsonT,
  ) =>
      _$ComRespToJson<T>(this, toJsonT);
}
