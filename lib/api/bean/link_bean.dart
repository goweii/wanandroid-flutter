import 'package:json_annotation/json_annotation.dart';

part 'link_bean.g.dart';

@JsonSerializable()
class LinkBean {
  final String desc;
  final String icon;
  final int id;
  String link;
  String name;
  final int order;
  final int userId;
  final int visible;
  bool? collect;

  LinkBean({
    required this.desc,
    required this.icon,
    required this.id,
    required this.link,
    required this.name,
    required this.order,
    required this.userId,
    required this.visible,
    this.collect,
  });

  factory LinkBean.fromJson(Map<String, dynamic> json) =>
      _$LinkBeanFromJson(json);

  Map<String, dynamic> toJson() => _$LinkBeanToJson(this);
}
