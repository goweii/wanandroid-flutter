import 'package:wanandroid/api/wan_apis.dart';

class ArticleRepo {
  Future<dynamic> collectArticleByLink({
    required String title,
    required String author,
    required String link,
  }) {
    return WanApis.collectArticleByLink(
      title: title,
      author: author,
      link: link,
    );
  }

  Future<dynamic> collectArticle({
    required int articleId,
  }) {
    return WanApis.collectArticle(
      articleId: articleId,
    );
  }

  Future<dynamic> uncollectByArticleId({
    required int articleId,
  }) {
    return WanApis.uncollectByArticleId(
      articleId: articleId,
    );
  }

  Future<dynamic> uncollectByCollectId({
    required int collectId,
  }) {
    return WanApis.uncollectByCollectId(
      collectId: collectId,
    );
  }
}
