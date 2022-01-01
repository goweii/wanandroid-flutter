import 'package:flutter/material.dart';
import 'package:wanandroid/api/bean/user_bean.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';
import 'package:wanandroid/env/l10n/generated/l10n.dart';
import 'package:wanandroid/env/provider/login.dart';
import 'package:wanandroid/env/route/route_map.dart';
import 'package:wanandroid/module/mine/min_repo.dart';
import 'package:wanandroid/module/mine/mine_widgets.dart';
import 'package:wanandroid/widget/action_item.dart';

class MinePage extends StatefulWidget {
  const MinePage({Key? key}) : super(key: key);

  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  final MineRepo _mineRepo = MineRepo();

  UserBean? _userBean;

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
    final LoginState loginState = LoginState.listen(context);
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
                      MineHeader(userBean: _userBean),
                      const SizedBox(height: AppDimens.marginLarge),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: MineMenus(userBean: _userBean),
            ),
          ),
        ],
      ),
    );
  }

  _getUserInfo() async {
    LoginState loginState = LoginState.value(context);
    if (loginState.isLogin) {
      try {
        UserBean userBean = await _mineRepo.userinfo();
        setState(() {
          _userBean = userBean;
        });
      } catch (_) {}
    } else {
      setState(() {
        _userBean = null;
      });
    }
  }
}
