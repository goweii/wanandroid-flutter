import 'package:flutter/material.dart';
import 'package:wanandroid/env/mvvm/view_model.dart';
import 'package:wanandroid/env/provider/login.dart';
import 'package:wanandroid/module/common/privacy/privacy_dialog.dart';
import 'package:wanandroid/module/common/update/update_info.dart';
import 'package:wanandroid/module/main/main_home_page.dart';
import 'package:wanandroid/module/main/main_view_model.dart';
import 'package:wanandroid/module/square/square_page.dart';
import 'package:wanandroid/module/common/update/update_dialog.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final MainViewModel _viewModel = MainViewModel();

  PageController? _pageController;

  bool _canOpenSquarePage = true;

  @override
  void initState() {
    _pageController = PageController(initialPage: 1);
    super.initState();
    LoginState.stream().listen((event) {
      _viewModel.updateUnreadMsgCount();
    });
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
    return ViewModelProvider<MainViewModel>(
      create: (context) {
        _viewModel.updateUnreadMsgCount();
        handleActions();
        return _viewModel;
      },
      builder: (context, viewModel) {
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
            MainHomePage(
              onPageChanged: (value) {
                if (!_canOpenSquarePage) {
                  if (value == 0) {
                    setState(() => _canOpenSquarePage = true);
                  }
                } else {
                  if (value != 0) {
                    setState(() => _canOpenSquarePage = false);
                  }
                }
              },
            ),
            // const ToDoPage(),
          ],
        );
      },
    );
  }

  Future<void> handleActions() async {
    // 隐私协议
    await PrivacyDialog.show(context: context);
    // 版本更新
    UpdateInfo? updateInfo = await _viewModel.checkUpdate();
    if (updateInfo != null) {
      await UpdateDialog.show(context: context, updateInfo: updateInfo);
    }
  }
}
