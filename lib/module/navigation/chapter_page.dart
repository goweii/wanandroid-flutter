import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/module/navigation/chapter_info.dart';
import 'package:wanandroid/module/navigation/chapter_sub_page.dart';
import 'package:wanandroid/module/navigation/chapter_widget.dart';

class ChapterPage extends StatefulWidget {
  const ChapterPage({
    Key? key,
    required this.chapterInfo,
  }) : super(key: key);

  final ChapterInfo chapterInfo;

  @override
  _ChapterPageState createState() => _ChapterPageState();
}

class _ChapterPageState extends State<ChapterPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: widget.chapterInfo.knowledgeBean.children.length,
      initialIndex: widget.chapterInfo.selectIndex
          .clamp(0, widget.chapterInfo.knowledgeBean.children.length - 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.chapterInfo.knowledgeBean.name),
          bottom: AppBarBottom(
            child: TabBar(
              isScrollable: true,
              indicatorWeight: 0.0001,
              unselectedLabelColor:
                  Theme.of(context).colorScheme.onPrimary.withAlpha(100),
              labelColor: Theme.of(context).colorScheme.onPrimary,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: Colors.transparent,
              controller: _tabController,
              labelStyle: Theme.of(context).appBarTheme.toolbarTextStyle,
              overlayColor: MaterialStateProperty.resolveWith((states) {
                return Colors.transparent;
              }),
              tabs: [
                ...widget.chapterInfo.knowledgeBean.children
                    .map((e) => Tab(text: e.name))
                    .toList(),
              ],
            ),
          )),
      body: TabBarView(
        controller: _tabController,
        dragStartBehavior: DragStartBehavior.start,
        children: widget.chapterInfo.knowledgeBean.children
            .map((e) => ChapterSubPage(knowledgeBean: e))
            .toList(),
      ),
    );
  }
}
