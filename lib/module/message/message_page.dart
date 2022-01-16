import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';
import 'package:wanandroid/env/l10n/generated/l10n.dart';
import 'package:wanandroid/env/mvvm/data_provider.dart';
import 'package:wanandroid/env/mvvm/view_model.dart';
import 'package:wanandroid/module/message/message_item.dart';
import 'package:wanandroid/module/message/message_view_model.dart';
import 'package:wanandroid/widget/paged_list_footer.dart';
import 'package:wanandroid/widget/shici_refresh_header.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final MessageViewModel _viewModel = MessageViewModel();

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
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    _scrollController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<MessageViewModel>(
      create: (context) {
        _viewModel.getInitialPage();
        return _viewModel;
      },
      provide: (viewModel) => [
        DataProvider<MsgStatablePagingData>(
            create: (_) => viewModel.msgStatablePagingData),
      ],
      builder: (context, viewModel) {
        return Scaffold(
          appBar: AppBar(
            title: Text(Strings.of(context).message_title),
          ),
          body: DataConsumer<MsgStatablePagingData>(builder: (context, data) {
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
          }),
        );
      },
    );
  }

  List<Widget> _buildSlivers(MsgStatablePagingData pagingData) {
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
          return MessageItem(message: pagingData.datas[index]);
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
}
