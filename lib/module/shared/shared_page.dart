import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:wanandroid/api/wan/bean/article_bean.dart';
import 'package:wanandroid/bus/bus.dart';
import 'package:wanandroid/bus/events/collent_event.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';
import 'package:wanandroid/env/l10n/generated/l10n.dart';
import 'package:wanandroid/env/mvvm/data_provider.dart';
import 'package:wanandroid/env/mvvm/view_model.dart';
import 'package:wanandroid/env/provider/login.dart';
import 'package:wanandroid/module/article/article_item.dart';
import 'package:wanandroid/module/shared/shared_view_model.dart';
import 'package:wanandroid/widget/paged_list_footer.dart';
import 'package:wanandroid/widget/shici_refresh_header.dart';

class SharedPage extends StatefulWidget {
  const SharedPage({Key? key}) : super(key: key);

  @override
  _SharedPageState createState() => _SharedPageState();
}

class _SharedPageState extends State<SharedPage> {
  final SharedViewModel _viewModel = SharedViewModel();

  ScrollController? _scrollController;

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
    return ViewModelProvider<SharedViewModel>(
        create: (context) => _viewModel..getInitialPage(),
        builder: (context, viewModel) {
          return Scaffold(
            appBar: AppBar(
              title: Text(Strings.of(context).mine_share),
            ),
            body: DataProvider<SharedArticlesPagingData>(
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
        });
  }

  List<Widget> _buildSlivers(SharedArticlesPagingData pagingData) {
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
          final ThemeData themeData = Theme.of(context);
          var data = pagingData.datas[index];
          return SwipeActionCell(
            key: ValueKey('swipe_action_cell-${data.id}'),
            backgroundColor: Colors.transparent,
            fullSwipeFactor: 0.5,
            trailingActions: [
              SwipeAction(
                performsFirstActionWithFullSwipe: true,
                widthSpace: 100,
                forceAlignmentToBoundary: true,
                title: Strings.of(context).delete,
                nestedAction: SwipeNestedAction(
                  nestedWidth: 150,
                  title: Strings.of(context).confirm_deletion,
                ),
                onTap: (CompletionHandler handler) async {
                  bool success = await _onDelete(data);
                  await handler.call(success);
                },
                color: themeData.colorScheme.error,
                style: themeData.textTheme.button!.copyWith(
                  color: themeData.colorScheme.onError,
                ),
              ),
            ],
            child: ArticleItem(article: data),
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

  Future<bool> _onDelete(ArticleBean data) async {
    return await _viewModel.deleteSharedArticle(data.id);
  }
}
