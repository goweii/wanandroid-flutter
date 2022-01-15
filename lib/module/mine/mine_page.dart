import 'package:flutter/material.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';
import 'package:wanandroid/env/mvvm/data_provider.dart';
import 'package:wanandroid/env/mvvm/view_model.dart';
import 'package:wanandroid/env/provider/login.dart';
import 'package:wanandroid/module/mine/mine_view_model.dart';
import 'package:wanandroid/module/mine/mine_widgets.dart';

class MinePage extends StatefulWidget {
  const MinePage({Key? key}) : super(key: key);

  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage>
    with AutomaticKeepAliveClientMixin {
  final MineViewModel _viewModel = MineViewModel();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _loadData();
    LoginState.stream().listen((event) {
      _loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ViewModelProvider<MineViewModel>(
      create: (context) => _viewModel,
      provide: (viewModel) => [
        DataProvider<UserBeanStatableData>(create: (_) => viewModel.userBean),
      ],
      builder: (context, viewModel) {
        return DataConsumer<UserBeanStatableData>(
          builder: (context, userBean) {
            return Scaffold(
              body: OrientationBuilder(
                builder: (context, orientation) {
                  bool isPortrait = orientation == Orientation.portrait;
                  if (isPortrait) {
                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: double.infinity,
                          color: Theme.of(context).appBarTheme.backgroundColor,
                          child: SafeArea(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const MineToolbar(),
                                SizedBox(
                                  width: double.infinity,
                                  height: AppDimens.appBarHeaderHeight,
                                  child: Center(
                                    child: MineHeader(userBean: userBean.value),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: MineMenus(userBean: userBean.value),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Row(
                      children: [
                        Expanded(
                          child: Container(
                            color:
                                Theme.of(context).appBarTheme.backgroundColor,
                            child: SafeArea(
                              child: Stack(
                                children: [
                                  const MineToolbar(),
                                  Center(
                                    child: MineHeader(userBean: userBean.value),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            color:
                                Theme.of(context).appBarTheme.backgroundColor,
                            child: SafeArea(
                              child: Center(
                                child: SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  child: MineMenus(userBean: userBean.value),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            );
          },
        );
      },
    );
  }

  _loadData() async {
    LoginState loginState = LoginState.value(context);
    if (loginState.isLogin) {
      await _viewModel.getUserInfo();
    } else {
      _viewModel.clearUserInfo();
    }
  }
}
