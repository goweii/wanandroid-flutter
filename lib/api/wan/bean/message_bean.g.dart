// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageBean _$MessageBeanFromJson(Map<String, dynamic> json) => MessageBean(
      category: json['category'] as int,
      date: json['date'] as int,
      fromUser: json['fromUser'] as String,
      fromUserId: json['fromUserId'] as int,
      fullLink: json['fullLink'] as String,
      id: json['id'] as int,
      isRead: json['isRead'] as int,
      link: json['link'] as String,
      message: json['message'] as String,
      niceDate: json['niceDate'] as String,
      tag: json['tag'] as String,
      title: json['title'] as String,
      userId: json['userId'] as int,
    );

Map<String, dynamic> _$MessageBeanToJson(MessageBean instance) =>
    <String, dynamic>{
      'category': instance.category,
      'date': instance.date,
      'fromUser': instance.fromUser,
      'fromUserId': instance.fromUserId,
      'fullLink': instance.fullLink,
      'id': instance.id,
      'isRead': instance.isRead,
      'link': instance.link,
      'message': instance.message,
      'niceDate': instance.niceDate,
      'tag': instance.tag,
      'title': instance.title,
      'userId': instance.userId,
    };
