import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wanandroid/api/wan/bean/article_bean.dart';
import 'package:wanandroid/bus/bus.dart';
import 'package:wanandroid/bus/events/collent_event.dart';
import 'package:wanandroid/env/http/paging.dart';
import 'package:wanandroid/env/l10n/generated/l10n.dart';
import 'package:wanandroid/env/mvvm/data_provider.dart';
import 'package:wanandroid/env/mvvm/view_model.dart';
import 'package:wanandroid/env/provider/login.dart';
import 'package:wanandroid/env/route/route_map.dart';
import 'package:wanandroid/env/route/router.dart';
import 'package:wanandroid/module/article/article_item.dart';
import 'package:wanandroid/module/square/square_view_model.dart';
import 'package:wanandroid/widget/paged_list_footer.dart';
import 'package:wanandroid/widget/shici_refresh_header.dart';

class SquarePage extends StatefulWidget {
  const SquarePage({Key? key}) : super(key: key);

  @override
  _SquarePageState createState() => _SquarePageState();
}

class _SquarePageState extends State<SquarePage>
    with AutomaticKeepAliveClientMixin {
  final SquareViewModel _viewModel = SquareViewModel();

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
    return ViewModelProvider<SquareViewModel>(
      create: (context) => _viewModel..getInitialPage(),
      builder: (context, viewModel) {
        return Scaffold(
          appBar: AppBar(
            title: Text(Strings.of(context).publish_title),
            actions: [
              IconButton(
                onPressed: () {
                  AppRouter.of(context).pushNamed(RouteMap.shareArticlePage);
                },
                icon: const Icon(CupertinoIcons.add),
              )
            ],
          ),
          body: DataProvider<StatablePagingData<ArticleBean>>(
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
          ),
        );
      },
    );
  }

  List<Widget> _buildSlivers(StatablePagingData<ArticleBean> pagingData) {
    return [
      ShiciRefreshHeader(
        onRefresh: () {
          return _viewModel.getInitialPage();
        },
      ),
      SliverMasonryGrid.extent(
        maxCrossAxisExtent: 640,
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

  _onLoginStateChanged(LoginState loginState) {
    if (loginState.isLogin) {
      _viewModel.getInitialPage();
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
