import 'package:flutter/material.dart';
import 'package:wanandroid/api/wan/bean/question_commen_bean.dart';
import 'package:wanandroid/bus/bus.dart';
import 'package:wanandroid/bus/events/collent_event.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';
import 'package:wanandroid/env/l10n/generated/l10n.dart';
import 'package:wanandroid/env/provider/login.dart';
import 'package:wanandroid/module/question/question_comment_item.dart';
import 'package:wanandroid/module/question/question_details_repo.dart';
import 'package:wanandroid/module/question/question_args.dart';
import 'package:wanandroid/widget/html_view.dart';
import 'package:wanandroid/widget/paged_list_footer.dart';
import 'package:wanandroid/widget/shici_refresh_header.dart';

class QuestionDetailsPage extends StatefulWidget {
  const QuestionDetailsPage({
    Key? key,
    required this.args,
  }) : super(key: key);

  final QuestionArgs args;

  @override
  _QuestionDetailsPageState createState() => _QuestionDetailsPageState();
}

class _QuestionDetailsPageState extends State<QuestionDetailsPage> {
  late final QuestionDetailsRepo _repo;

  final List<QuestionCommentBean> _comments = [];
  bool _ended = false;
  bool _loading = false;

  bool get _hasComments => true == _comments.isNotEmpty;

  ScrollController? _scrollController;

  @override
  void initState() {
    _repo = QuestionDetailsRepo(widget.args.id);
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController == null) return;
        if (_loading) return;
        if (_ended) return;
        if (_scrollController!.position.pixels >=
            _scrollController!.position.maxScrollExtent) {
          _loadNextPage();
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
      //setState(() {
      //  for (var element in _comments) {
      //    //element.collect = false;
      //  }
      //});
    }
  }

  _onCollectEvent(CollectEvent event) {
    _comments.where((value) => value.id == event.articleId).forEach((element) {
      //setState(() {
      //  //element.collect = event.collect;
      //});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.args.title ?? ''),
      ),
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              scrollBehavior: ScrollConfiguration.of(context).copyWith(
                overscroll: false,
                scrollbars: false,
              ),
              controller: _scrollController,
              slivers: _buildSlivers(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildSlivers() {
    return [
      ShiciRefreshHeader(
        onRefresh: _refreshData,
      ),
      SliverToBoxAdapter(
        child: Container(
          color: Theme.of(context).colorScheme.surface,
          child: HtmlView(data: widget.args.desc),
        ),
      ),
      SliverToBoxAdapter(
        child: Container(
          padding: const EdgeInsets.all(AppDimens.marginNormal),
          width: double.infinity,
          child: Text(
            Strings.of(context).answers + '(${_comments.length})',
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return QuestionCommentItem(comment: _comments[index]);
          },
          childCount: _comments.length,
        ),
      ),
      if (_hasComments)
        SliverToBoxAdapter(
          child: PagedListFooter(
            loading: _loading,
            ended: _ended,
            onLoadMoreTap: () => _repo.getNextPageComments(),
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
      var value = await _repo.getInitialPageComments();
      setState(() {
        _ended = value.ended;
        _comments.clear();
        _comments.addAll(value.datas);
      });
    } catch (_) {
      result = false;
    }
    setState(() {
      _loading = false;
    });
    return result;
  }

  void _loadNextPage() {
    setState(() {
      _loading = true;
    });
    _repo.getNextPageComments().then((value) {
      setState(() {
        _loading = false;
        _ended = value.ended;
        _comments.addAll(value.datas);
      });
    }, onError: (error) {
      setState(() {
        _loading = false;
      });
    });
  }
}
