import 'package:flutter/material.dart';
import 'package:wanandroid/module/main/main_home_page.dart';
import 'package:wanandroid/module/square/square_page.dart';

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

  bool _canOpenSquarePage = true;

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
      allowImplicitScrolling: true,
      scrollBehavior: ScrollConfiguration.of(context).copyWith(
        overscroll: false,
        scrollbars: false,
      ),
      physics: _canOpenSquarePage
          ? const ClampingScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      controller: _pageController,
      children: [
        const SquarePage(),
        MainHomePage(onPageChanged: (value) {
          if (!_canOpenSquarePage) {
            if (value == 0) {
              setState(() => _canOpenSquarePage = true);
            }
          } else {
            if (value != 0) {
              setState(() => _canOpenSquarePage = false);
            }
          }
        }),
        // const ToDoPage(),
      ],
    );
  }
}
