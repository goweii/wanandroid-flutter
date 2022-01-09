import 'package:json_annotation/json_annotation.dart';

part 'message_bean.g.dart';

@JsonSerializable()
class MessageBean {
  int category;
  int date;
  String fromUser;
  int fromUserId;
  String fullLink;
  int id;
  int isRead;
  String link;
  String message;
  String niceDate;
  String tag;
  String title;
  int userId;

  MessageBean({
    required this.category,
    required this.date,
    required this.fromUser,
    required this.fromUserId,
    required this.fullLink,
    required this.id,
    required this.isRead,
    required this.link,
    required this.message,
    required this.niceDate,
    required this.tag,
    required this.title,
    required this.userId,
  });

  factory MessageBean.fromJson(Map<String, dynamic> json) =>
      _$MessageBeanFromJson(json);

  Map<String, dynamic> toJson() => _$MessageBeanToJson(this);
}
