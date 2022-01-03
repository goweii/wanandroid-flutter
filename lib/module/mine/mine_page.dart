import 'package:flutter/material.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';
import 'package:wanandroid/env/mvvm/observable_data.dart';
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
    _getUserInfo();
    LoginState.stream().listen((event) {
      _getUserInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ViewModelProvider<MineViewModel>(
        create: (context) => _viewModel,
        builder: (context, viewModel) {
          return DataProvider<UserBeanStatableData>(
              create: (context) => viewModel.userBean,
              builder: (context, userBean) {
                return Scaffold(
                  body: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: double.infinity,
                        color: Theme.of(context).colorScheme.primary,
                        child: Stack(
                          children: [
                            SafeArea(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const MineToolbar(),
                                  MineHeader(userBean: userBean.value),
                                  const SizedBox(height: AppDimens.marginLarge),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: MineMenus(userBean: userBean.value),
                        ),
                      ),
                    ],
                  ),
                );
              });
        });
  }

  _getUserInfo() async {
    LoginState loginState = LoginState.value(context);
    if (loginState.isLogin) {
      await _viewModel.getUserInfo();
    } else {
      _viewModel.clearUserInfo();
    }
  }
}
