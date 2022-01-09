// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'about_me_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AboutMeBean _$AboutMeBeanFromJson(Map<String, dynamic> json) => AboutMeBean(
      avatar: json['avatar'] as String,
      nickname: json['nickname'] as String,
      signature: json['signature'] as String,
      github: json['github'] as String,
      qqGroup: json['qq_group'] as String,
      qqGroupKey: json['qq_group_key'] as String,
      wxQrcode: json['wx_qrcode'] as String,
      zfbQrcode: json['zfb_qrcode'] as String,
    );

Map<String, dynamic> _$AboutMeBeanToJson(AboutMeBean instance) =>
    <String, dynamic>{
      'avatar': instance.avatar,
      'nickname': instance.nickname,
      'signature': instance.signature,
      'github': instance.github,
      'qq_group': instance.qqGroup,
      'qq_group_key': instance.qqGroupKey,
      'wx_qrcode': instance.wxQrcode,
      'zfb_qrcode': instance.zfbQrcode,
    };
