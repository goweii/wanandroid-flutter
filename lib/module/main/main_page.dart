import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/module/bookmark/bookmark_page.dart';
import 'package:wanandroid/module/publish/publish_page.dart';
import 'package:wanandroid/module/main/main_home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  PageController? _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: 1);
    super.initState();
  }

  @override
  void deactivate() {
    _pageController?.dispose();
    _pageController = null;
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return PageView(
      dragStartBehavior: DragStartBehavior.start,
      allowImplicitScrolling: true,
      scrollBehavior: ScrollConfiguration.of(context).copyWith(
        overscroll: false,
        scrollbars: false,
      ),
      controller: _pageController,
      children: const [
        PublishPage(),
        MainHomePage(),
        BookmarkPage(),
      ],
    );
  }
}
