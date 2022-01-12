import 'package:flutter/material.dart';
import 'package:wanandroid/entity/article_info.dart';
import 'package:wanandroid/env/route/app_page.dart';
import 'package:wanandroid/env/route/page_routes.dart';
import 'package:wanandroid/env/route/route_path.dart';
import 'package:wanandroid/module/aboutme/about_me_page.dart';
import 'package:wanandroid/module/article/article_page.dart';
import 'package:wanandroid/module/coin/coin_page.dart';
import 'package:wanandroid/module/coin/coin_ranking_page.dart';
import 'package:wanandroid/module/collection/collection_page.dart';
import 'package:wanandroid/module/login/login_page.dart';
import 'package:wanandroid/module/main/main_page.dart';
import 'package:wanandroid/module/message/message_page.dart';
import 'package:wanandroid/module/navigation/chapter_info.dart';
import 'package:wanandroid/module/navigation/chapter_page.dart';
import 'package:wanandroid/module/question/question_args.dart';
import 'package:wanandroid/module/question/question_details_page.dart';
import 'package:wanandroid/module/scan/scan_page.dart';
import 'package:wanandroid/module/search/search_page.dart';
import 'package:wanandroid/module/settings/settings_page.dart';
import 'package:wanandroid/module/share/share_article_info.dart';
import 'package:wanandroid/module/share/share_article_page.dart';
import 'package:wanandroid/module/share/my_share_page.dart';
import 'package:wanandroid/module/userpage/user_page.dart';

class RouteMap {
  static const String mainPage = "/";
  static const String loginPage = "/login";
  static const String articlePage = "/article";
  static const String settingsPage = "/settings";
  static const String questionDetailsPage = "/questionDetails";
  static const String chapterPage = "/chapter";
  static const String coinPage = "/coin";
  static const String collectionPage = "/collection";
  static const String mySharePage = "/myShare";
  static const String aboutMePage = "/aboutMe";
  static const String messagePage = "/message";
  static const String coinRankPage = "/coinRank";
  static const String userPage = "/user";
  static const String shareArticlePage = "/shareArticle";
  static const String scanPage = "/scan";
  static const String searchPage = "/search";

  static final Map<String, RouteBuilder> map = {
    mainPage: (context, page) => NonePageRoute(
          page: page,
          builder: (context, arguments) {
            return const MainPage();
          },
        ),
    loginPage: (context, page) => BottomPageRoute(
          page: page,
          builder: (context, arguments) {
            return const LoginPage();
          },
        ),
    articlePage: (context, page) => RightPageRoute(
          page: page,
          builder: (context, arguments) {
            return ArticlePage(
              articleInfo: arguments as ArticleInfo,
            );
          },
        ),
    settingsPage: (context, page) => RightPageRoute(
          page: page,
          builder: (context, arguments) {
            return const SettingsPage();
          },
        ),
    questionDetailsPage: (context, page) => RightPageRoute(
          page: page,
          builder: (context, arguments) {
            return QuestionDetailsPage(
              args: arguments as QuestionArgs,
            );
          },
        ),
    chapterPage: (context, page) => RightPageRoute(
          page: page,
          builder: (context, arguments) {
            return ChapterPage(
              chapterInfo: arguments as ChapterInfo,
            );
          },
        ),
    coinPage: (context, page) => RightPageRoute(
          page: page,
          builder: (context, arguments) {
            return const CoinPage();
          },
        ),
    collectionPage: (context, page) => RightPageRoute(
          page: page,
          builder: (context, arguments) {
            return const CollectionPage();
          },
        ),
    mySharePage: (context, page) => RightPageRoute(
          page: page,
          builder: (context, arguments) {
            return const MySharePage();
          },
        ),
    aboutMePage: (context, page) => RightPageRoute(
          page: page,
          builder: (context, arguments) {
            return const AboutMePage();
          },
        ),
    messagePage: (context, page) => RightPageRoute(
          page: page,
          builder: (context, arguments) {
            return const MessagePage();
          },
        ),
    coinRankPage: (context, page) => RightPageRoute(
          page: page,
          builder: (context, arguments) {
            return const CoinRankingPage();
          },
        ),
    userPage: (context, page) => RightPageRoute(
          page: page,
          builder: (context, arguments) {
            return UserPage(userid: arguments as int);
          },
        ),
    shareArticlePage: (context, page) => RightPageRoute(
          page: page,
          builder: (context, arguments) {
            return ShareArticlePage(
              shareArticleInfo: arguments as ShareArticleInfo?,
            );
          },
        ),
    scanPage: (context, page) => BottomPageRoute(
          page: page,
          builder: (context, arguments) {
            return const ScanPage();
          },
        ),
    searchPage: (context, page) => RightPageRoute(
          page: page,
          builder: (context, arguments) {
            return const SearchPage();
          },
        ),
  };

  static Page<dynamic>? buildPage(
      BuildContext context, RoutePath<dynamic> routePath) {
    var builder = map[routePath.location];
    if (builder == null) return null;
    return AppPage(
      routePath: routePath,
      builder: builder,
    );
  }
}
