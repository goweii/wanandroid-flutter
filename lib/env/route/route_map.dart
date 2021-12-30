import 'package:flutter/material.dart';
import 'package:wanandroid/entity/article_info.dart';
import 'package:wanandroid/env/route/page_route.dart';
import 'package:wanandroid/module/article/article_page.dart';
import 'package:wanandroid/module/login/login_page.dart';
import 'package:wanandroid/module/main/main_page.dart';

class RouteMap {
  static const String mainPage = "/";
  static const String loginPage = "/login";
  static const String articlePage = "/article";

  static Map<String, RouteFactory> routes = {
    mainPage: (settings) => NonePageRoute(
          settings: settings,
          builder: (context, settings) => const MainPage(),
        ),
    loginPage: (settings) => BottomPageRoute(
          settings: settings,
          builder: (context, settings) => const LoginPage(),
        ),
    articlePage: (settings) => BottomPageRoute(
          settings: settings,
          builder: (context, settings) => ArticlePage(
            articleInfo: settings.arguments as ArticleInfo,
          ),
        ),
  };
}
