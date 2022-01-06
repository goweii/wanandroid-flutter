// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_coin_history_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCoinHistoryBean _$UserCoinHistoryBeanFromJson(Map<String, dynamic> json) =>
    UserCoinHistoryBean(
      coinCount: json['coinCount'] as int,
      date: json['date'] as int,
      desc: json['desc'] as String,
      id: json['id'] as int,
      reason: json['reason'] as String,
      type: json['type'] as int,
      userId: json['userId'] as int,
      userName: json['userName'] as String,
    );

Map<String, dynamic> _$UserCoinHistoryBeanToJson(
        UserCoinHistoryBean instance) =>
    <String, dynamic>{
      'coinCount': instance.coinCount,
      'date': instance.date,
      'desc': instance.desc,
      'id': instance.id,
      'reason': instance.reason,
      'type': instance.type,
      'userId': instance.userId,
      'userName': instance.userName,
    };
