// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateBean _$UpdateBeanFromJson(Map<String, dynamic> json) => UpdateBean(
      url: json['url'] as String,
      versionCode: json['version_code'] as int,
      versionName: json['version_name'] as String,
      desc: json['desc'] as String,
      date: json['date'] as String,
      forceVersionCode: json['force_version_code'] as int,
      forceVersionName: json['force_version_name'] as String,
    );

Map<String, dynamic> _$UpdateBeanToJson(UpdateBean instance) =>
    <String, dynamic>{
      'url': instance.url,
      'version_code': instance.versionCode,
      'version_name': instance.versionName,
      'desc': instance.desc,
      'date': instance.date,
      'force_version_code': instance.forceVersionCode,
      'force_version_name': instance.forceVersionName,
    };
