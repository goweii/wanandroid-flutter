import 'package:wanandroid/api/wan/bean/article_bean.dart';
import 'package:wanandroid/api/wan/bean/collect_link_bean.dart';
import 'package:wanandroid/api/wan/wan_apis.dart';

class ArticleRepo {
  Future<ArticleBean> collectOffSiteArticle({
    required String title,
    required String author,
    required String link,
  }) {
    return WanApis.collectOffSiteArticle(
      title: title,
      author: author,
      link: link,
    );
  }

  Future<dynamic> collectInSiteArticle({
    required int articleId,
  }) {
    return WanApis.collectInSiteArticle(
      articleId: articleId,
    );
  }

  Future<dynamic> uncollectArticleByArticleId({
    required int articleId,
  }) {
    return WanApis.uncollectArticleByArticleId(
      articleId: articleId,
    );
  }

  Future<dynamic> uncollectArticleByCollectId({
    required int collectId,
    required int? articleId,
  }) {
    return WanApis.uncollectArticleByCollectId(
      collectId: collectId,
      articleId: articleId,
    );
  }

  Future<CollectLinkBean> collectLink({
    required String name,
    required String link,
  }) {
    return WanApis.collectLink(
      name: name,
      link: link,
    );
  }

  Future<dynamic> uncollectLink({
    required int id,
  }) {
    return WanApis.deleteCollectedLink(id);
  }
}
