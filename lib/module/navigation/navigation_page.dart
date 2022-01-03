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
          child: TabBar(
            isScrollable: true,
            indicatorWeight: 0.0001,
            unselectedLabelColor:
                Theme.of(context).colorScheme.onPrimary.withAlpha(100),
            labelColor: Theme.of(context).colorScheme.onPrimary,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: Colors.transparent,
            controller: _tabController,
            labelStyle: Theme.of(context).appBarTheme.titleTextStyle,
            overlayColor: MaterialStateProperty.resolveWith((states) {
              return Colors.transparent;
            }),
            tabs: [
              Tab(text: Strings.of(context).navigation_title),
              Tab(text: Strings.of(context).knowledge_title),
            ],
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
