// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navi_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NaviBean _$NaviBeanFromJson(Map<String, dynamic> json) => NaviBean(
      articles: (json['articles'] as List<dynamic>)
          .map((e) => ArticleBean.fromJson(e as Map<String, dynamic>))
          .toList(),
      cid: json['cid'] as int,
      name: json['name'] as String,
    );

Map<String, dynamic> _$NaviBeanToJson(NaviBean instance) => <String, dynamic>{
      'articles': instance.articles,
      'cid': instance.cid,
      'name': instance.name,
    };
