import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/env/l10n/generated/l10n.dart';
import 'package:wanandroid/module/navigation/knowledge_sub_page.dart';
import 'package:wanandroid/module/navigation/navigation_sub_page.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Material(
            color: Colors.transparent,
            child: TabBar(
              isScrollable: true,
              indicatorWeight: 0.0001,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: Colors.transparent,
              controller: _tabController,
              labelStyle: Theme.of(context).appBarTheme.titleTextStyle,
              labelColor: Theme.of(context).appBarTheme.titleTextStyle?.color,
              unselectedLabelColor: Theme.of(context)
                  .appBarTheme
                  .titleTextStyle
                  ?.color
                  ?.withOpacity(0.4),
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              tabs: [
                Tab(text: Strings.of(context).navigation_title),
                Tab(text: Strings.of(context).knowledge_title),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        dragStartBehavior: DragStartBehavior.start,
        children: const [
          NavigationSubPage(),
          KnowledgeSubPage(),
        ],
      ),
    );
  }
}
