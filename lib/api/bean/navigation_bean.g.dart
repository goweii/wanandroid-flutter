// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navigation_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NavigationBean _$NaviBeanFromJson(Map<String, dynamic> json) => NavigationBean(
      articles: (json['articles'] as List<dynamic>)
          .map((e) => ArticleBean.fromJson(e as Map<String, dynamic>))
          .toList(),
      cid: json['cid'] as int,
      name: json['name'] as String,
    );

Map<String, dynamic> _$NaviBeanToJson(NavigationBean instance) => <String, dynamic>{
      'articles': instance.articles,
      'cid': instance.cid,
      'name': instance.name,
    };
