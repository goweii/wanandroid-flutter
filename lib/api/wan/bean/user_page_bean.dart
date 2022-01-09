import 'package:json_annotation/json_annotation.dart';
import 'package:wanandroid/api/wan/bean/article_bean.dart';
import 'package:wanandroid/api/wan/bean/user_coin_bean.dart';
import 'package:wanandroid/api/wan/bean/paged_bean.dart';

part 'user_page_bean.g.dart';

@JsonSerializable()
class UserPageBean {
  final UserCoinBean coinInfo;
  final PagedBean<ArticleBean> shareArticles;

  UserPageBean({
    required this.coinInfo,
    required this.shareArticles,
  });

  factory UserPageBean.fromJson(Map<String, dynamic> json) =>
      _$UserPageBeanFromJson(json);

  Map<String, dynamic> toJson() => _$UserPageBeanToJson(this);
}
