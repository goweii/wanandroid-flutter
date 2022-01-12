import 'package:json_annotation/json_annotation.dart';

part 'hot_key_bean.g.dart';

@JsonSerializable()
class HotKeyBean {
  final int id;
  final String link;
  final String name;
  final int order;
  final int visible;

  HotKeyBean({
   required this.id,
   required this.link,
   required this.name,
   required this.order,
   required this.visible,
  });

  factory HotKeyBean.fromJson(Map<String, dynamic> json) =>
      _$HotKeyBeanFromJson(json);

  Map<String, dynamic> toJson() => _$HotKeyBeanToJson(this);
}
