import 'package:wanandroid/api/bean/article_bean.dart';
import 'package:json_annotation/json_annotation.dart';

part 'navi_bean.g.dart';

@JsonSerializable()
class NaviBean {
  List<ArticleBean> articles;
  int cid;
  String name;

  NaviBean({
    required this.articles,
    required this.cid,
    required this.name,
  });

  factory NaviBean.fromJson(Map<String, dynamic> json) =>
      _$NaviBeanFromJson(json);

  Map<String, dynamic> toJson() => _$NaviBeanToJson(this);
}
