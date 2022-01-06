// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_coin_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCoinBean _$UserCoinBeanFromJson(Map<String, dynamic> json) => UserCoinBean(
      coinCount: json['coinCount'] as int,
      level: json['level'] as int,
      rank: json['rank'] as String,
      userId: json['userId'] as int,
      nickname: json['nickname'] as String,
      username: json['username'] as String,
    );

Map<String, dynamic> _$UserCoinBeanToJson(UserCoinBean instance) =>
    <String, dynamic>{
      'coinCount': instance.coinCount,
      'level': instance.level,
      'rank': instance.rank,
      'userId': instance.userId,
      'nickname': instance.nickname,
      'username': instance.username,
    };
