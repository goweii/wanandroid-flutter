import 'package:flutter/material.dart';
import 'package:wanandroid/api/wan/bean/knowledge_bean.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';
import 'package:wanandroid/env/http/paging.dart';
import 'package:wanandroid/env/mvvm/data_provider.dart';
import 'package:wanandroid/env/mvvm/view_model.dart';
import 'package:wanandroid/env/route/route_map.dart';
import 'package:wanandroid/env/route/router.dart';
import 'package:wanandroid/module/navigation/chapter_info.dart';
import 'package:wanandroid/module/navigation/knowledge_view_model.dart';
import 'package:wanandroid/module/navigation/wrap_item.dart';

class KnowledgeSubPage extends StatefulWidget {
  const KnowledgeSubPage({Key? key}) : super(key: key);

  @override
  State<KnowledgeSubPage> createState() => _KnowledgeSubPageState();
}

class _KnowledgeSubPageState extends State<KnowledgeSubPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ViewModelProvider<KnowledgeViewModel>(
      create: (context) => KnowledgeViewModel()..getData(),
      builder: (context, viewModel) {
        return DataProvider<StatablePagingData<KnowledgeBean>>(
          create: (context) => viewModel.data,
          builder: (context, data) {
            if (data.datas.isEmpty && data.isLoading) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            return ListView.builder(
              itemCount: data.datas.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final ThemeData themeData = Theme.of(context);
                var knowledgeBean = data.datas[index];
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
                          knowledgeBean.name,
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
                          children: knowledgeBean.children
                              .map((e) => WrapItem(
                                    data: e.name,
                                    onPressed: () {
                                      AppRouter.of(context).pushNamed(
                                        RouteMap.chapterPage,
                                        arguments: ChapterInfo(
                                          knowledgeBean: knowledgeBean,
                                          selectIndex:
                                              knowledgeBean.children.indexOf(e),
                                        ),
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
