// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserBean _$UserBeanFromJson(Map<String, dynamic> json) => UserBean(
      coinInfo: CoinInfoBean.fromJson(json['coinInfo'] as Map<String, dynamic>),
      userInfo: UserInfoBean.fromJson(json['userInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserBeanToJson(UserBean instance) => <String, dynamic>{
      'coinInfo': instance.coinInfo,
      'userInfo': instance.userInfo,
    };
