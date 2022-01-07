import 'package:flutter/material.dart';
import 'package:wanandroid/entity/article_info.dart';
import 'package:wanandroid/env/route/app_page.dart';
import 'package:wanandroid/env/route/page_routes.dart';
import 'package:wanandroid/env/route/route_path.dart';
import 'package:wanandroid/module/aboutme/about_me_page.dart';
import 'package:wanandroid/module/article/article_page.dart';
import 'package:wanandroid/module/coin/coin_page.dart';
import 'package:wanandroid/module/collection/collection_page.dart';
import 'package:wanandroid/module/login/login_page.dart';
import 'package:wanandroid/module/main/main_page.dart';
import 'package:wanandroid/module/message/message_page.dart';
import 'package:wanandroid/module/navigation/chapter_info.dart';
import 'package:wanandroid/module/navigation/chapter_page.dart';
import 'package:wanandroid/module/question/question_args.dart';
import 'package:wanandroid/module/question/question_details_page.dart';
import 'package:wanandroid/module/settings/settings_page.dart';
import 'package:wanandroid/module/shared/shared_page.dart';

class RouteMap {
  static const String mainPage = "/";
  static const String loginPage = "/login";
  static const String articlePage = "/article";
  static const String settingsPage = "/settings";
  static const String questionDetailsPage = "/questionDetails";
  static const String chapterPage = "/chapter";
  static const String coinPage = "/coin";
  static const String collectionPage = "/collection";
  static const String sharedPage = "/shared";
  static const String aboutMePage = "/aboutMe";
  static const String messagePage = "/message";

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
    sharedPage: (context, page) => RightPageRoute(
          page: page,
          builder: (context, arguments) {
            return const SharedPage();
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
