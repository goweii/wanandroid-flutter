// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_page_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPageBean _$UserPageBeanFromJson(Map<String, dynamic> json) => UserPageBean(
      coinInfo: UserCoinBean.fromJson(json['coinInfo'] as Map<String, dynamic>),
      shareArticles: PagedBean<ArticleBean>.fromJson(
          json['shareArticles'] as Map<String, dynamic>,
          (value) => ArticleBean.fromJson(value as Map<String, dynamic>)),
    );

Map<String, dynamic> _$UserPageBeanToJson(UserPageBean instance) =>
    <String, dynamic>{
      'coinInfo': instance.coinInfo,
      'shareArticles': instance.shareArticles.toJson(
        (value) => value,
      ),
    };
