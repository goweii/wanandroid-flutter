// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'com_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ComResp<T> _$ComRespFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    ComResp<T>(
      code: json['code'] as int,
      msg: json['msg'] as String,
      data: fromJsonT(json['data']),
    );

Map<String, dynamic> _$ComRespToJson<T>(
  ComResp<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'data': toJsonT(instance.data),
    };
