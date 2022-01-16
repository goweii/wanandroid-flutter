import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wanandroid/bus/bus.dart';
import 'package:wanandroid/bus/events/collent_event.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';
import 'package:wanandroid/env/mvvm/data_provider.dart';
import 'package:wanandroid/env/mvvm/view_model.dart';
import 'package:wanandroid/env/provider/login.dart';
import 'package:wanandroid/module/article/article_item.dart';
import 'package:wanandroid/module/search/search_key.dart';
import 'package:wanandroid/module/search/search_result_view_model.dart';
import 'package:wanandroid/widget/paged_list_footer.dart';
import 'package:wanandroid/widget/shici_refresh_header.dart';

class SearchResultSubPage extends StatefulWidget {
  const SearchResultSubPage({
    Key? key,
  }) : super(key: key);

  @override
  _SearchResultSubPageState createState() => _SearchResultSubPageState();
}

class _SearchResultSubPageState extends State<SearchResultSubPage>
    with AutomaticKeepAliveClientMixin {
  final SearchResultViewModel _viewModel = SearchResultViewModel();

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
    LoginState.stream().listen(_onLoginStateChanged);
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
    return SearchKeyConsumer(
      builder: (context, searchKey) {
        _viewModel.search(searchKey.value);
        return ViewModelProvider<SearchResultViewModel>(
          create: (context) => _viewModel,
          builder: (context, viewModel) {
            return DataProvider<SearchArticlesPagingData>(
              create: (context) => _viewModel.pagingData,
              builder: (context, data) {
                if (data.datas.isEmpty && data.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
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
      },
    );
  }

  List<Widget> _buildSlivers(SearchArticlesPagingData pagingData) {
    return [
      ShiciRefreshHeader(
        onRefresh: () {
          return _viewModel.research();
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
            onLoadMoreTap: () => _viewModel.getNextPage(),
          ),
        ),
    ];
  }

  _onLoginStateChanged(LoginState loginState) {
    if (loginState.isLogin) {
      _viewModel.research();
    } else {
      _viewModel.pagingData
        // ignore: avoid_function_literals_in_foreach_calls
        ..datas.forEach((element) => element.collect = false)
        ..notify();
    }
  }

  _onCollectEvent(CollectEvent event) {
    _viewModel.pagingData
      ..datas
          .where((value) => value.id == event.articleId)
          .forEach((element) => element.collect = event.collect)
      ..notify();
  }
}
