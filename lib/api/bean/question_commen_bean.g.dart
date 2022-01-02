// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_commen_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionCommentBean _$QuestionCommentBeanFromJson(Map<String, dynamic> json) =>
    QuestionCommentBean(
      anonymous: json['anonymous'] as int,
      appendForContent: json['appendForContent'] as int,
      articleId: json['articleId'] as int,
      canEdit: json['canEdit'] as bool,
      content: json['content'] as String,
      contentMd: json['contentMd'] as String,
      id: json['id'] as int,
      niceDate: json['niceDate'] as String,
      publishDate: json['publishDate'] as int,
      replyCommentId: json['replyCommentId'] as int,
      replyComments: (json['replyComments'] as List<dynamic>)
          .map((e) => QuestionCommentBean.fromJson(e as Map<String, dynamic>))
          .toList(),
      rootCommentId: json['rootCommentId'] as int,
      status: json['status'] as int,
      toUserId: json['toUserId'] as int,
      toUserName: json['toUserName'] as String,
      userId: json['userId'] as int,
      userName: json['userName'] as String,
      zan: json['zan'] as int,
    );

Map<String, dynamic> _$QuestionCommentBeanToJson(
        QuestionCommentBean instance) =>
    <String, dynamic>{
      'anonymous': instance.anonymous,
      'appendForContent': instance.appendForContent,
      'articleId': instance.articleId,
      'canEdit': instance.canEdit,
      'content': instance.content,
      'contentMd': instance.contentMd,
      'id': instance.id,
      'niceDate': instance.niceDate,
      'publishDate': instance.publishDate,
      'replyCommentId': instance.replyCommentId,
      'replyComments': instance.replyComments,
      'rootCommentId': instance.rootCommentId,
      'status': instance.status,
      'toUserId': instance.toUserId,
      'toUserName': instance.toUserName,
      'userId': instance.userId,
      'userName': instance.userName,
      'zan': instance.zan,
    };
