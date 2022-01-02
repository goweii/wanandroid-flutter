import 'package:json_annotation/json_annotation.dart';

part 'question_commen_bean.g.dart';

@JsonSerializable()
class QuestionCommentBean {
  int anonymous;
  int appendForContent;
  int articleId;
  bool canEdit;
  String content;
  String contentMd;
  int id;
  String niceDate;
  int publishDate;
  int replyCommentId;
  List<QuestionCommentBean> replyComments;
  int rootCommentId;
  int status;
  int toUserId;
  String toUserName;
  int userId;
  String userName;
  int zan;

  QuestionCommentBean({
    required this.anonymous,
    required this.appendForContent,
    required this.articleId,
    required this.canEdit,
    required this.content,
    required this.contentMd,
    required this.id,
    required this.niceDate,
    required this.publishDate,
    required this.replyCommentId,
    required this.replyComments,
    required this.rootCommentId,
    required this.status,
    required this.toUserId,
    required this.toUserName,
    required this.userId,
    required this.userName,
    required this.zan,
  });

  factory QuestionCommentBean.fromJson(Map<String, dynamic> json) =>
      _$QuestionCommentBeanFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionCommentBeanToJson(this);
}
