import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wanandroid/bus/bus.dart';
import 'package:wanandroid/bus/events/collent_event.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';
import 'package:wanandroid/env/mvvm/data_provider.dart';
import 'package:wanandroid/env/mvvm/view_model.dart';
import 'package:wanandroid/module/article/article_item.dart';
import 'package:wanandroid/module/collection/collected_article_view_model.dart';
import 'package:wanandroid/widget/paged_list_footer.dart';
import 'package:wanandroid/widget/shici_refresh_header.dart';

class CollectedArticlePage extends StatefulWidget {
  const CollectedArticlePage({Key? key}) : super(key: key);

  @override
  _CollectedArticlePageState createState() => _CollectedArticlePageState();
}

class _CollectedArticlePageState extends State<CollectedArticlePage>
    with AutomaticKeepAliveClientMixin {
  final CollectedArticleViewModel _viewModel = CollectedArticleViewModel();

  ScrollController? _scrollController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController == null) return;
        if (_scrollController!.position.pixels >=
            _scrollController!.position.maxScrollExtent) {
          _viewModel.getNextPage();
        }
      });
    Bus().on<CollectEvent>().listen(_onCollectEvent);
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    _scrollController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ViewModelProvider<CollectedArticleViewModel>(
      create: (context) => _viewModel..getInitialPage(),
      builder: (context, viewModel) {
        return DataProvider<CollectedArticlesPagingData>(
          create: (context) => _viewModel.pagingData,
          builder: (context, data) {
            if (data.datas.isEmpty && data.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              scrollBehavior: ScrollConfiguration.of(context).copyWith(
                overscroll: false,
                scrollbars: false,
              ),
              controller: _scrollController,
              slivers: _buildSlivers(data),
            );
          },
        );
      },
    );
  }

  List<Widget> _buildSlivers(CollectedArticlesPagingData pagingData) {
    return [
      ShiciRefreshHeader(
        onRefresh: () {
          return _viewModel.getInitialPage();
        },
      ),
      SliverMasonryGrid.extent(
        maxCrossAxisExtent: AppDimens.gridMaxCrossAxisExtent,
        childCount: pagingData.datas.length,
        itemBuilder: (BuildContext context, int index) {
          return ArticleItem(article: pagingData.datas[index]);
        },
      ),
      if (pagingData.datas.isNotEmpty)
        SliverToBoxAdapter(
          child: PagedListFooter(
            loading: pagingData.isLoading,
            ended: pagingData.ended,
          ),
        ),
    ];
  }

  _onCollectEvent(CollectEvent event) {
    _viewModel.pagingData
      ..datas
          .where((value) =>
              value.originId == event.articleId || value.id == event.collectId)
          .forEach((element) => element.collect = event.collect)
      ..notify();
  }
}
