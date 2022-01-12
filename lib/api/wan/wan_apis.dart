import 'package:wanandroid/api/wan/bean/article_bean.dart';
import 'package:wanandroid/api/wan/bean/collect_link_bean.dart';
import 'package:wanandroid/api/wan/bean/hot_key_bean.dart';
import 'package:wanandroid/api/wan/bean/user_coin_bean.dart';
import 'package:wanandroid/api/wan/bean/knowledge_bean.dart';
import 'package:wanandroid/api/wan/bean/link_bean.dart';
import 'package:wanandroid/api/wan/bean/message_bean.dart';
import 'package:wanandroid/api/wan/bean/navigation_bean.dart';
import 'package:wanandroid/api/wan/bean/paged_bean.dart';
import 'package:wanandroid/api/wan/bean/question_commen_bean.dart';
import 'package:wanandroid/api/wan/bean/user_bean.dart';
import 'package:wanandroid/api/wan/bean/user_coin_history_bean.dart';
import 'package:wanandroid/api/wan/bean/user_page_bean.dart';
import 'package:wanandroid/api/wan/wan_api.dart';
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

  static Future<dynamic> collectInSiteArticle({
    required int articleId,
  }) async {
    return await WanApi(
      method: HttpMethod.post,
      path: '/lg/collect/$articleId/json',
      fromJsonT: (json) => json,
    ).request();
  }

  static Future<ArticleBean> collectOffSiteArticle({
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
      fromJsonT: (json) => ArticleBean.fromJson(json),
    ).request();
  }

  static Future<dynamic> uncollectArticleByArticleId({
    required int articleId,
  }) async {
    return await WanApi(
      method: HttpMethod.post,
      path: '/lg/uncollect_originId/$articleId/json',
      fromJsonT: (json) => json,
    ).request();
  }

  static Future<dynamic> uncollectArticleByCollectId({
    required int collectId,
    required int? articleId,
  }) async {
    return await WanApi(
      method: HttpMethod.post,
      path: '/lg/uncollect/$collectId/json',
      body: {"originId": articleId ?? -1},
      bodyType: BodyType.form,
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

  static Future<UserCoinBean> getUserCoin() async {
    return await WanApi(
      method: HttpMethod.get,
      path: '/lg/coin/userinfo/json',
      fromJsonT: (json) => UserCoinBean.fromJson(json),
    ).request();
  }

  static Future<PagedBean<UserCoinHistoryBean>> getUserCoinHistory(int page) {
    return WanApi(
      method: HttpMethod.get,
      path: '/lg/coin/list/$page/json',
      fromJsonT: (json) => PagedBean.fromJson(
          json, (json) => UserCoinHistoryBean.fromJson(json)),
    ).request();
  }

  static Future<PagedBean<UserCoinBean>> getCoinRanking(int page) {
    return WanApi(
      method: HttpMethod.get,
      path: '/coin/rank/$page/json',
      fromJsonT: (json) =>
          PagedBean.fromJson(json, (json) => UserCoinBean.fromJson(json)),
    ).request();
  }

  static Future<int> getUnreadMessageCount() async {
    return await WanApi(
      method: HttpMethod.get,
      path: '/message/lg/count_unread/json',
      fromJsonT: null,
    ).request();
  }

  static Future<PagedBean<MessageBean>> getReadedMessages(int page) {
    return WanApi(
      method: HttpMethod.get,
      path: '/message/lg/readed_list/$page/json',
      fromJsonT: (json) =>
          PagedBean.fromJson(json, (json) => MessageBean.fromJson(json)),
    ).request();
  }

  static Future<PagedBean<MessageBean>> getUnreadMessages(int page) {
    return WanApi(
      method: HttpMethod.get,
      path: '/message/lg/unread_list/$page/json',
      fromJsonT: (json) =>
          PagedBean.fromJson(json, (json) => MessageBean.fromJson(json)),
    ).request();
  }

  static Future<PagedBean<ArticleBean>> getCollectedArticles(int page) {
    return WanApi(
      method: HttpMethod.get,
      path: '/lg/collect/list/$page/json',
      fromJsonT: (json) =>
          PagedBean.fromJson(json, (json) => ArticleBean.fromJson(json)),
    ).request();
  }

  static Future<List<LinkBean>> getCollectedLinks() {
    return WanApi(
      method: HttpMethod.get,
      path: '/lg/collect/usertools/json',
      fromJsonT: (json) {
        var data = <LinkBean>[];
        json as List;
        for (var v in json) {
          data.add(LinkBean.fromJson(v));
        }
        return data;
      },
    ).request();
  }

  static Future<CollectLinkBean> collectLink({
    required String name,
    required String link,
  }) {
    return WanApi(
      method: HttpMethod.post,
      path: '/lg/collect/addtool/json',
      body: {
        'name': name,
        'link': link,
      },
      bodyType: BodyType.form,
      fromJsonT: (json) => CollectLinkBean.fromJson(json),
    ).request();
  }

  static Future<dynamic> deleteCollectedLink(int id) async {
    return await WanApi(
      method: HttpMethod.post,
      path: '/lg/collect/deletetool/json',
      body: {"id": id},
      bodyType: BodyType.form,
      fromJsonT: null,
    ).request();
  }

  static Future<CollectLinkBean> updateCollectedLink({
    required int id,
    required String name,
    required String link,
  }) async {
    return await WanApi(
      method: HttpMethod.post,
      path: '/lg/collect/updatetool/json',
      body: {
        "id": id,
        "name": name,
        "link": link,
      },
      bodyType: BodyType.form,
      fromJsonT: (json) => CollectLinkBean.fromJson(json),
    ).request();
  }

  static Future<UserPageBean> getSharedArticles(int page) {
    return WanApi(
      method: HttpMethod.get,
      path: '/user/lg/private_articles/$page/json',
      fromJsonT: (json) => UserPageBean.fromJson(json),
    ).request();
  }

  static Future<dynamic> deleteSharedArticle(int id) {
    return WanApi(
      method: HttpMethod.post,
      path: '/lg/user_article/delete/$id/json',
      fromJsonT: null,
    ).request();
  }

  static Future<UserPageBean> getUserSharedArticles({
    required int userid,
    required int page,
  }) {
    return WanApi(
      method: HttpMethod.get,
      path: '/user/$userid/share_articles/$page/json',
      fromJsonT: (json) => UserPageBean.fromJson(json),
    ).request();
  }

  static Future<dynamic> shareArticle({
    required String title,
    required String link,
  }) {
    return WanApi(
      method: HttpMethod.post,
      path: '/lg/user_article/add/json',
      body: {
        'title': title,
        'link': link,
      },
      bodyType: BodyType.form,
      fromJsonT: null,
    ).request();
  }

  static Future<PagedBean<ArticleBean>> search({
    required String key,
    required int page,
  }) {
    return WanApi(
      method: HttpMethod.post,
      path: '/article/query/$page/json',
      body: {'k': key},
      bodyType: BodyType.form,
      fromJsonT: (json) =>
          PagedBean.fromJson(json, (json) => ArticleBean.fromJson(json)),
    ).request();
  }

  static Future<List<HotKeyBean>> getHotKey() {
    return WanApi(
      method: HttpMethod.get,
      path: '/hotkey/json',
      fromJsonT: (json) {
        var data = <HotKeyBean>[];
        json as List;
        for (var v in json) {
          data.add(HotKeyBean.fromJson(v));
        }
        return data;
      },
    ).request();
  }
}
