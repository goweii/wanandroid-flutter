// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LinkBean _$LinkBeanFromJson(Map<String, dynamic> json) => LinkBean(
      desc: json['desc'] as String,
      icon: json['icon'] as String,
      id: json['id'] as int,
      link: json['link'] as String,
      name: json['name'] as String,
      order: json['order'] as int,
      userId: json['userId'] as int,
      visible: json['visible'] as int,
      collect: json['collect'] as bool?,
    );

Map<String, dynamic> _$LinkBeanToJson(LinkBean instance) => <String, dynamic>{
      'desc': instance.desc,
      'icon': instance.icon,
      'id': instance.id,
      'link': instance.link,
      'name': instance.name,
      'order': instance.order,
      'userId': instance.userId,
      'visible': instance.visible,
      'collect': instance.collect,
    };
