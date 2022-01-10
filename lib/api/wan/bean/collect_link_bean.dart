import 'package:json_annotation/json_annotation.dart';

part 'collect_link_bean.g.dart';

@JsonSerializable()
class CollectLinkBean {
  final String desc;
  final String icon;
  final int id;
  final String link;
  final String name;
  final int order;
  final int userId;
  final int visible;

  CollectLinkBean({
    required this.desc,
    required this.icon,
    required this.id,
    required this.link,
    required this.name,
    required this.order,
    required this.userId,
    required this.visible,
  });

  factory CollectLinkBean.fromJson(Map<String, dynamic> json) =>
      _$CollectLinkBeanFromJson(json);

  Map<String, dynamic> toJson() => _$CollectLinkBeanToJson(this);
}
