import 'package:json_annotation/json_annotation.dart';

part 'tag_bean.g.dart';

@JsonSerializable()
class TagBean {
  final String name;
  final String url;

  TagBean({
    required this.name,
    required this.url,
  });

  factory TagBean.fromJson(Map<String, dynamic> json) =>
      _$TagBeanFromJson(json);

  Map<String, dynamic> toJson() => _$TagBeanToJson(this);
}
