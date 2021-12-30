import 'package:wanandroid/api/bean/article_bean.dart';

class ArticleInfo {
  final int? id;
  final String? title;
  final String? author;
  final String? cover;
  final String link;
  bool collected;

  ArticleInfo({
    required this.id,
    required this.title,
    required this.author,
    required this.cover,
    required this.link,
    this.collected = false,
  });

  factory ArticleInfo.fromArticleBean(ArticleBean articleBean) {
    return ArticleInfo(
      id: articleBean.id,
      link: articleBean.link!,
      title: articleBean.title,
      author: articleBean.author ?? articleBean.shareUser,
      cover: articleBean.envelopePic,
      collected: articleBean.collect,
    );
  }
}
