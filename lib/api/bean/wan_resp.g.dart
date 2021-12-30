// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wan_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WanResp<T> _$WanRespFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    WanResp<T>(
      errorCode: json['errorCode'] as int,
      errorMsg: json['errorMsg'] as String,
      data: fromJsonT(json['data']),
    );

Map<String, dynamic> _$WanRespToJson<T>(
  WanResp<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg,
      'data': toJsonT(instance.data),
    };
