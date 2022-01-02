import 'package:flutter/material.dart';
import 'package:wanandroid/api/bean/navi_bean.dart';
import 'package:wanandroid/entity/article_info.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';
import 'package:wanandroid/env/l10n/generated/l10n.dart';
import 'package:wanandroid/env/route/route_map.dart';
import 'package:wanandroid/env/route/router.dart';
import 'package:wanandroid/module/navigation/navi_repo.dart';
import 'package:wanandroid/utils/string_utils.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage>
    with AutomaticKeepAliveClientMixin {
  final NaviRepo _repo = NaviRepo();

  final List<NaviBean> datas = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _repo.getNavi().then((value) {
      setState(() {
        datas.addAll(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.of(context).navigation_title),
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          var data = datas[index];
          return Container(
            color: themeData.colorScheme.surface,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(
                    AppDimens.marginNormal,
                    AppDimens.marginNormal,
                    AppDimens.marginNormal,
                    AppDimens.marginHalf,
                  ),
                  child: Text(
                    data.name,
                    style: themeData.textTheme.subtitle1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppDimens.marginNormal,
                    AppDimens.marginHalf,
                    AppDimens.marginNormal,
                    AppDimens.marginNormal,
                  ),
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    runAlignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: AppDimens.marginHalf,
                    runSpacing: AppDimens.marginHalf,
                    children: data.articles.map((e) {
                      return Material(
                        shape: const StadiumBorder(),
                        clipBehavior: Clip.hardEdge,
                        child: InkWell(
                          onTap: () {
                            AppRouter.of(context).pushNamed(
                              RouteMap.articlePage,
                              arguments: ArticleInfo.fromArticleBean(e),
                            );
                          },
                          child: Container(
                            constraints: const BoxConstraints(
                              minWidth: AppDimens.smallButtonHeight,
                              minHeight: AppDimens.smallButtonHeight,
                            ),
                            padding: const EdgeInsets.fromLTRB(
                              AppDimens.marginNormal,
                              AppDimens.marginHalf,
                              AppDimens.marginNormal,
                              AppDimens.marginHalf,
                            ),
                            decoration: BoxDecoration(
                                color: themeData.hoverColor,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(99))),
                            child: Text(
                              StringUtils.simplifyToSingleLine(e.title ?? ''),
                              style: themeData.textTheme.subtitle2?.copyWith(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          );
        },
        itemCount: datas.length,
      ),
    );
  }
}
