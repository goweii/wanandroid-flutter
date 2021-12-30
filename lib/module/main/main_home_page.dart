import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';
import 'package:wanandroid/env/l10n/generated/l10n.dart';
import 'package:wanandroid/module/home/home_page.dart';
import 'package:wanandroid/module/mine/mine_page.dart';
import 'package:wanandroid/module/navigation/navigation_page.dart';
import 'package:wanandroid/module/question/question_page.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController? _tabController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Material(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabController,
              dragStartBehavior: DragStartBehavior.start,
              children: const [
                HomePage(),
                QuestionPage(),
                NavigationPage(),
                MinePage(),
              ],
            ),
          ),
          Container(
            height: AppDimens.bottomBarHeight,
            color: Theme.of(context).colorScheme.surface,
            child: Column(
              children: [
                SizedBox(
                  height: AppDimens.lineThin,
                  child: Container(
                    color: Theme.of(context).dividerColor,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      child: Icon(
                        CupertinoIcons.chart_pie_fill,
                        size: 18,
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withAlpha(100),
                      ),
                      padding: const EdgeInsets.all(8),
                    ),
                    Expanded(
                      child: TabBar(
                        unselectedLabelColor: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withAlpha(100),
                        labelColor: Theme.of(context).colorScheme.onSurface,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorColor: Colors.transparent,
                        controller: _tabController,
                        tabs: [
                          Tab(text: Strings.of(context).home_title),
                          Tab(text: Strings.of(context).question_title),
                          Tab(text: Strings.of(context).navigation_title),
                          Tab(text: Strings.of(context).mine_title),
                        ],
                      ),
                    ),
                    Container(
                      child: Icon(
                        CupertinoIcons.bookmark_fill,
                        size: 18,
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withAlpha(100),
                      ),
                      padding: const EdgeInsets.all(8),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
