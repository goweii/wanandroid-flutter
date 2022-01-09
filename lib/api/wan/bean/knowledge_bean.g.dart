// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'knowledge_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KnowledgeBean _$KnowledgeBeanFromJson(Map<String, dynamic> json) =>
    KnowledgeBean(
      children: (json['children'] as List<dynamic>)
          .map((e) => KnowledgeBean.fromJson(e as Map<String, dynamic>))
          .toList(),
      courseId: json['courseId'] as int,
      id: json['id'] as int,
      name: json['name'] as String,
      order: json['order'] as int,
      parentChapterId: json['parentChapterId'] as int,
      userControlSetTop: json['userControlSetTop'] as bool,
      visible: json['visible'] as int,
    );

Map<String, dynamic> _$KnowledgeBeanToJson(KnowledgeBean instance) =>
    <String, dynamic>{
      'children': instance.children,
      'courseId': instance.courseId,
      'id': instance.id,
      'name': instance.name,
      'order': instance.order,
      'parentChapterId': instance.parentChapterId,
      'userControlSetTop': instance.userControlSetTop,
      'visible': instance.visible,
    };
