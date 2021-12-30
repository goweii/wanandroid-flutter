// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paged_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PagedBean<T> _$PagedBeanFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    PagedBean<T>(
      curPage: json['curPage'] as int,
      datas: (json['datas'] as List<dynamic>).map(fromJsonT).toList(),
      offset: json['offset'] as int,
      over: json['over'] as bool,
      pageCount: json['pageCount'] as int,
      size: json['size'] as int,
      total: json['total'] as int,
    );

Map<String, dynamic> _$PagedBeanToJson<T>(
  PagedBean<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'curPage': instance.curPage,
      'datas': instance.datas.map(toJsonT).toList(),
      'offset': instance.offset,
      'over': instance.over,
      'pageCount': instance.pageCount,
      'size': instance.size,
      'total': instance.total,
    };
