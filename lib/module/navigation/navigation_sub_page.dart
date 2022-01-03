import 'package:flutter/material.dart';
import 'package:wanandroid/api/bean/navigation_bean.dart';
import 'package:wanandroid/entity/article_info.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';
import 'package:wanandroid/env/mvvm/observable_data.dart';
import 'package:wanandroid/env/mvvm/view_model.dart';
import 'package:wanandroid/env/route/route_map.dart';
import 'package:wanandroid/env/route/router.dart';
import 'package:wanandroid/module/navigation/navigation_view_model.dart';
import 'package:wanandroid/module/navigation/wrap_item.dart';

class NavigationSubPage extends StatefulWidget {
  const NavigationSubPage({Key? key}) : super(key: key);

  @override
  State<NavigationSubPage> createState() => _NavigationSubPageState();
}

class _NavigationSubPageState extends State<NavigationSubPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ViewModelProvider<NavigationViewModel>(
      create: (context) => NavigationViewModel()..getNavi(),
      builder: (context, viewModel) {
        return DataProvider<List<NavigationBean>>(
          create: (context) => viewModel.data,
          builder: (context, datas) {
            return ListView.builder(
              itemCount: datas.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final ThemeData themeData = Theme.of(context);
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
                          children: data.articles
                              .map((e) => WrapItem(
                                    data: e.title ?? '',
                                    onPressed: () {
                                      AppRouter.of(context).pushNamed(
                                        RouteMap.articlePage,
                                        arguments:
                                            ArticleInfo.fromArticleBean(e),
                                      );
                                    },
                                  ))
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
