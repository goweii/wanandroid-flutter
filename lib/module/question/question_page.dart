import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wanandroid/api/bean/article_bean.dart';
import 'package:wanandroid/bus/bus.dart';
import 'package:wanandroid/bus/events/collent_event.dart';
import 'package:wanandroid/env/l10n/generated/l10n.dart';
import 'package:wanandroid/env/provider/login.dart';
import 'package:wanandroid/env/route/route_map.dart';
import 'package:wanandroid/env/route/router.dart';
import 'package:wanandroid/module/article/article_item.dart';
import 'package:wanandroid/module/question/question_repo.dart';
import 'package:wanandroid/widget/paged_list_footer.dart';
import 'package:wanandroid/widget/shici_refresh_header.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({Key? key}) : super(key: key);

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage>
    with AutomaticKeepAliveClientMixin {
  final QuestionRepo _repo = QuestionRepo();

  final List<ArticleBean> _questions = [];
  bool _ended = false;
  bool _loading = false;

  bool get _hasQuestions => true == _questions.isNotEmpty;

  ScrollController? _scrollController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController == null) return;
        if (_loading) return;
        if (_ended) return;
        if (_scrollController!.position.pixels >=
            _scrollController!.position.maxScrollExtent) {
          setState(() {
            _loading = true;
          });
          _repo.getNextPageQuestions().then((value) {
            setState(() {
              _loading = false;
              _ended = value.ended;
              _questions.addAll(value.datas);
            });
          }, onError: (error) {
            setState(() {
              _loading = false;
            });
          });
        }
      });
    _refreshData();
    LoginState.stream().listen(_onLoginStateChanged);
    Bus().on<CollectEvent>().listen(_onCollectEvent);
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    _scrollController = null;
    super.dispose();
  }

  _onLoginStateChanged(LoginState loginState) {
    if (loginState.isLogin) {
      _refreshData();
    } else {
      setState(() {
        for (var element in _questions) {
          element.collect = false;
        }
      });
    }
  }

  _onCollectEvent(CollectEvent event) {
    _questions.where((value) => value.id == event.articleId).forEach((element) {
      setState(() {
        element.collect = event.collect;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.of(context).question_title),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          scrollBehavior: ScrollConfiguration.of(context).copyWith(
            overscroll: false,
            scrollbars: false,
          ),
          controller: _scrollController,
          slivers: _buildSlivers(),
        );
      }),
    );
  }

  List<Widget> _buildSlivers() {
    return [
      ShiciRefreshHeader(
        onRefresh: _refreshData,
      ),
      SliverMasonryGrid.extent(
        itemBuilder: (BuildContext context, int index) {
          return ArticleItem(
            article: _questions[index],
            onPressed: (value) {
              AppRouter.of(context).pushNamed(
                RouteMap.questionDetailsPage,
                arguments: value,
              );
            },
          );
        },
        maxCrossAxisExtent: 640,
        childCount: _questions.length,
      ),
      if (_hasQuestions)
        SliverToBoxAdapter(
          child: PagedListFooter(
            loading: _loading,
            ended: _ended,
          ),
        ),
    ];
  }

  Future<bool> _refreshData() async {
    bool result = true;
    setState(() {
      _loading = true;
    });
    try {
      var value = await _repo.getInitialPageQuestions();
      setState(() {
        _ended = value.ended;
        _questions.clear();
        _questions.addAll(value.datas);
      });
    } catch (_) {
      result = false;
    }
    setState(() {
      _loading = false;
    });
    return result;
  }
}
