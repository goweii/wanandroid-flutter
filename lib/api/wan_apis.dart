import 'package:wanandroid/api/bean/article_bean.dart';
import 'package:wanandroid/api/bean/knowledge_bean.dart';
import 'package:wanandroid/api/bean/navigation_bean.dart';
import 'package:wanandroid/api/bean/paged_bean.dart';
import 'package:wanandroid/api/bean/question_commen_bean.dart';
import 'package:wanandroid/api/bean/user_bean.dart';
import 'package:wanandroid/api/wan_api.dart';
import 'package:wanandroid/env/http/api.dart';
import 'package:wanandroid/module/home/bean/banner_bean.dart';

class WanApis {
  static Future<List<BannerBean>> getBanners() async {
    return await WanApi(
      method: HttpMethod.get,
      path: '/banner/json',
      fromJsonT: (json) {
        var data = <BannerBean>[];
        json as List;
        for (var v in json) {
          data.add(BannerBean.fromJson(v));
        }
        return data;
      },
    ).request();
  }

  static Future<List<ArticleBean>> getTopArticles() async {
    return await WanApi(
      method: HttpMethod.get,
      path: '/article/top/json',
      fromJsonT: (json) {
        var data = <ArticleBean>[];
        json as List;
        for (var v in json) {
          data.add(ArticleBean.fromJson(v));
        }
        return data;
      },
    ).request();
  }

  static Future<PagedBean<ArticleBean>> getHomeArticles(int page) async {
    return await WanApi(
      method: HttpMethod.get,
      path: '/article/list/$page/json',
      fromJsonT: (json) =>
          PagedBean.fromJson(json, (json) => ArticleBean.fromJson(json)),
    ).request();
  }

  static Future<dynamic> collectArticle({
    required int articleId,
  }) async {
    return await WanApi(
      method: HttpMethod.post,
      path: '/lg/collect/$articleId/json',
      fromJsonT: (json) => json,
    ).request();
  }

  static Future<dynamic> collectArticleByLink({
    required String title,
    required String author,
    required String link,
  }) async {
    return await WanApi(
      method: HttpMethod.post,
      path: '/lg/collect/add/json',
      body: {
        "title": title,
        "author": author,
        "link": link,
      },
      fromJsonT: (json) => json,
    ).request();
  }

  static Future<dynamic> uncollectByArticleId({
    required int articleId,
  }) async {
    return await WanApi(
      method: HttpMethod.post,
      path: '/lg/uncollect_originId/$articleId/json',
      fromJsonT: (json) => json,
    ).request();
  }

  static Future<dynamic> uncollectByCollectId({
    required int collectId,
  }) async {
    return await WanApi(
      method: HttpMethod.post,
      path: '/lg/uncollect/$collectId/json',
      fromJsonT: (json) => json,
    ).request();
  }

  static Future<dynamic> register({
    required String username,
    required String password,
    required String repassword,
  }) async {
    return await WanApi(
      method: HttpMethod.post,
      path: '/user/register',
      body: {
        "username": username,
        "password": password,
        "repassword": repassword,
      },
      fromJsonT: (json) => json,
    ).request();
  }

  static Future<dynamic> login({
    required String username,
    required String password,
  }) async {
    return await WanApi(
      method: HttpMethod.post,
      path: '/user/login',
      body: {
        "username": username,
        "password": password,
      },
      fromJsonT: (json) => json,
    ).request();
  }

  static Future<dynamic> logout() async {
    return await WanApi(
      method: HttpMethod.get,
      path: '/user/logout/json',
      fromJsonT: null,
    ).request();
  }

  static Future<UserBean> getUserInfo() async {
    return await WanApi(
      method: HttpMethod.get,
      path: '/user/lg/userinfo/json',
      fromJsonT: (json) => UserBean.fromJson(json),
    ).request();
  }

  static Future<PagedBean<ArticleBean>> getQuestions(int page) async {
    return await WanApi(
      method: HttpMethod.get,
      path: 'wenda/list/$page/json',
      fromJsonT: (json) =>
          PagedBean.fromJson(json, (json) => ArticleBean.fromJson(json)),
    ).request();
  }

  static Future<PagedBean<QuestionCommentBean>> getQuestionComments({
    required int questionId,
    required int page,
  }) async {
    return await WanApi(
      method: HttpMethod.get,
      path: '/wenda/comments/$questionId/json',
      fromJsonT: (json) => PagedBean.fromJson(
          json, (json) => QuestionCommentBean.fromJson(json)),
    ).request();
  }

  static Future<List<NavigationBean>> getNavigations() async {
    return await WanApi(
      method: HttpMethod.get,
      path: '/navi/json',
      fromJsonT: (json) {
        var data = <NavigationBean>[];
        json as List;
        for (var v in json) {
          data.add(NavigationBean.fromJson(v));
        }
        return data;
      },
    ).request();
  }

  static Future<List<KnowledgeBean>> getKnowledges() async {
    return await WanApi(
      method: HttpMethod.get,
      path: '/tree/json',
      fromJsonT: (json) {
        var data = <KnowledgeBean>[];
        json as List;
        for (var v in json) {
          data.add(KnowledgeBean.fromJson(v));
        }
        return data;
      },
    ).request();
  }

  static Future<PagedBean<ArticleBean>> getChapterArticles({
    required int chapterId,
    required int page,
  }) async {
    return await WanApi(
      method: HttpMethod.get,
      path: '/article/list/$page/json',
      queries: {"cid": chapterId},
      fromJsonT: (json) =>
          PagedBean.fromJson(json, (json) => ArticleBean.fromJson(json)),
    ).request();
  }

  static Future<PagedBean<ArticleBean>> getSquareArticles(int page) async {
    return await WanApi(
      method: HttpMethod.get,
      path: '/user_article/list/$page/json',
      fromJsonT: (json) =>
          PagedBean.fromJson(json, (json) => ArticleBean.fromJson(json)),
    ).request();
  }
}
