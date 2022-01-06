import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wanandroid/api/bean/article_bean.dart';
import 'package:wanandroid/api/bean/knowledge_bean.dart';
import 'package:wanandroid/bus/bus.dart';
import 'package:wanandroid/bus/events/collent_event.dart';
import 'package:wanandroid/env/http/paging.dart';
import 'package:wanandroid/env/mvvm/data_provider.dart';
import 'package:wanandroid/env/mvvm/view_model.dart';
import 'package:wanandroid/env/provider/login.dart';
import 'package:wanandroid/module/article/article_item.dart';
import 'package:wanandroid/module/navigation/chapter_sub_view_model.dart';
import 'package:wanandroid/widget/paged_list_footer.dart';
import 'package:wanandroid/widget/shici_refresh_header.dart';

class ChapterSubPage extends StatefulWidget {
  const ChapterSubPage({
    Key? key,
    required this.knowledgeBean,
  }) : super(key: key);

  final KnowledgeBean knowledgeBean;

  @override
  State<ChapterSubPage> createState() => _ChapterSubPageState();
}

class _ChapterSubPageState extends State<ChapterSubPage>
    with AutomaticKeepAliveClientMixin {
  late ChapterSubViewModel _viewModel;
  ScrollController? _scrollController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _viewModel = ChapterSubViewModel(widget.knowledgeBean.id);
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
  Widget build(BuildContext context) {
    super.build(context);
    return ViewModelProvider<ChapterSubViewModel>(
      create: (context) => _viewModel..getInitialPage(),
      builder: (context, viewModel) {
        return DataProvider<StatablePagingData<ArticleBean>>(
          create: (context) => viewModel.pagingData,
          builder: (context, data) {
            if (data.datas.isEmpty && data.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return CustomScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              scrollBehavior: ScrollConfiguration.of(context).copyWith(
                overscroll: false,
                scrollbars: false,
              ),
              slivers: _buildSlivers(viewModel, data),
            );
          },
        );
      },
    );
  }

  List<Widget> _buildSlivers(
    ChapterSubViewModel viewModel,
    StatablePagingData<ArticleBean> pagingData,
  ) {
    return [
      ShiciRefreshHeader(
        onRefresh: () async {
          await viewModel.getNextPage();
          return true;
        },
      ),
      SliverMasonryGrid.extent(
        maxCrossAxisExtent: 640,
        childCount: pagingData.datas.length,
        itemBuilder: (BuildContext context, int index) {
          return ArticleItem(
            article: pagingData.datas[index],
          );
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
      for (var element in _viewModel.pagingData.datas) {
        element.collect = false;
      }
      _viewModel.pagingData.notify();
    }
  }

  _onCollectEvent(CollectEvent event) {
    _viewModel.pagingData
      ..datas
          .where((element) => element.id == event.articleId)
          .forEach((element) => element.collect = event.collect)
      ..notify();
  }
}
