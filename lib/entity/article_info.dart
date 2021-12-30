import 'package:wanandroid/api/bean/article_bean.dart';

class ArticleInfo {
  final String link;
  final String? title;
  final String? author;
  bool collected;

  ArticleInfo({
    required this.link,
    required this.title,
    required this.author,
    this.collected = false,
  });

  factory ArticleInfo.fromArticleBean(ArticleBean articleBean) {
    return ArticleInfo(
      link: articleBean.link ?? '',
      title: articleBean.title,
      author: articleBean.author ?? articleBean.shareUser,
      collected: articleBean.collect,
    );
  }
}
