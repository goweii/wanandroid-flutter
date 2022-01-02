import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/api/bean/user_bean.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';
import 'package:wanandroid/env/l10n/generated/l10n.dart';
import 'package:wanandroid/env/provider/login.dart';
import 'package:wanandroid/env/route/route_map.dart';
import 'package:wanandroid/env/route/router.dart';
import 'package:wanandroid/widget/action_item.dart';

class MineToolbar extends StatelessWidget {
  const MineToolbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimens.appBarHeight,
      alignment: Alignment.centerRight,
      child: IconButton(
        onPressed: null,
        icon: Icon(
          Icons.notifications,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }
}

class MineHeader extends StatelessWidget {
  const MineHeader({
    Key? key,
    required this.userBean,
  }) : super(key: key);

  final UserBean? userBean;

  @override
  Widget build(BuildContext context) {
    final LoginState loginState = LoginState.listen(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => _toUserInfoPage(context),
          child: ClipOval(
            child: SizedBox(
              width: 80,
              height: 80,
              child: Container(
                color: Theme.of(context).colorScheme.onPrimary.withAlpha(60),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppDimens.marginNormal),
        GestureDetector(
          onTap: () => _toUserInfoPage(context),
          child: Text(
            loginState.isLogin
                ? userBean?.userInfo.nickname ?? ''
                : Strings.of(context).guest_name,
            style: Theme.of(context).textTheme.headline6?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
          ),
        ),
        const SizedBox(height: AppDimens.marginHalf),
        if (loginState.isLogin)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                Strings.of(context).level_prefix +
                    '${userBean?.coinInfo.level ?? 0}',
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
              ),
              const SizedBox(width: AppDimens.marginNormal),
              Text(
                Strings.of(context).rank_prefix +
                    (userBean?.coinInfo.rank ?? '0'),
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
              ),
            ],
          ),
      ],
    );
  }

  _toUserInfoPage(BuildContext context) {
    LoginState loginState = LoginState.value(context);
    if (loginState.isLogin) {
    } else {
      AppRouter.of(context).pushNamed(RouteMap.loginPage);
    }
  }
}

class MineMenus extends StatelessWidget {
  const MineMenus({
    Key? key,
    required this.userBean,
  }) : super(key: key);

  final UserBean? userBean;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ActionItem(
          leading: const Icon(CupertinoIcons.money_dollar_circle),
          title: Text(Strings.of(context).mine_coin),
          tip: Text('${userBean?.coinInfo.coinCount ?? ''}'),
          onPressed: () {},
        ),
        ActionItem(
          leading: const Icon(CupertinoIcons.heart),
          title: Text(Strings.of(context).mine_collection),
          onPressed: () {},
        ),
        ActionItem(
          leading: const Icon(CupertinoIcons.settings),
          title: Text(Strings.of(context).settings_title),
          onPressed: () {
            AppRouter.of(context).pushNamed(RouteMap.settingsPage);
          },
        ),
      ],
    );
  }
}
