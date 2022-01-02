import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:wanandroid/entity/article_info.dart';
import 'package:wanandroid/env/route/route_map.dart';
import 'package:wanandroid/env/route/router.dart';

class HtmlView extends StatelessWidget {
  const HtmlView({
    Key? key,
    required this.data,
  }) : super(key: key);

  final String? data;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Html(
      data: data,
      onLinkTap: (url, renderContext, attributes, element) {
        AppRouter.of(context).pushNamed(
          RouteMap.articlePage,
          arguments: ArticleInfo(
            id: null,
            title: null,
            author: null,
            cover: null,
            link: url!,
          ),
        );
      },
      style: {
        "table": Style(
          backgroundColor: themeData.backgroundColor,
        ),
        "h1": Style.fromTextStyle(themeData.textTheme.headline1!),
        "h2": Style.fromTextStyle(themeData.textTheme.headline2!),
        "h3": Style.fromTextStyle(themeData.textTheme.headline3!),
        "h4": Style.fromTextStyle(themeData.textTheme.headline4!),
        "h5": Style.fromTextStyle(themeData.textTheme.headline5!),
        "h6": Style.fromTextStyle(themeData.textTheme.headline6!),
        "p": Style.fromTextStyle(themeData.textTheme.bodyText1!),
        "p > a": Style(
          textDecoration: TextDecoration.none,
        ),
      },
    );
  }
}
