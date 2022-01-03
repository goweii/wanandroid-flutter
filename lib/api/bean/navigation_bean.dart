import 'package:wanandroid/api/bean/article_bean.dart';
import 'package:json_annotation/json_annotation.dart';

part 'navigation_bean.g.dart';

@JsonSerializable()
class NavigationBean {
  List<ArticleBean> articles;
  int cid;
  String name;

  NavigationBean({
    required this.articles,
    required this.cid,
    required this.name,
  });

  factory NavigationBean.fromJson(Map<String, dynamic> json) =>
      _$NaviBeanFromJson(json);

  Map<String, dynamic> toJson() => _$NaviBeanToJson(this);
}
