import 'package:json_annotation/json_annotation.dart';

part 'knowledge_bean.g.dart';

@JsonSerializable()
class KnowledgeBean {
  List<KnowledgeBean> children;
  int courseId;
  int id;
  String name;
  int order;
  int parentChapterId;
  bool userControlSetTop;
  int visible;

  KnowledgeBean({
    required this.children,
    required this.courseId,
    required this.id,
    required this.name,
    required this.order,
    required this.parentChapterId,
    required this.userControlSetTop,
    required this.visible,
  });

  factory KnowledgeBean.fromJson(Map<String, dynamic> json) =>
      _$KnowledgeBeanFromJson(json);

  Map<String, dynamic> toJson() => _$KnowledgeBeanToJson(this);
}
