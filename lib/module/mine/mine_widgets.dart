import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/api/wan/bean/user_bean.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';
import 'package:wanandroid/env/l10n/generated/l10n.dart';
import 'package:wanandroid/env/provider/login.dart';
import 'package:wanandroid/env/provider/unread.dart';
import 'package:wanandroid/env/route/route_map.dart';
import 'package:wanandroid/env/route/router.dart';
import 'package:wanandroid/widget/action_item.dart';
import 'package:wanandroid/widget/read_point.dart';

class MineToolbar extends StatelessWidget {
  const MineToolbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return AppBar(
      toolbarHeight: themeData.appBarTheme.toolbarHeight,
      titleTextStyle: themeData.appBarTheme.titleTextStyle?.copyWith(
        color: themeData.colorScheme.onSurface,
      ),
      iconTheme: themeData.appBarTheme.iconTheme?.copyWith(
        color: themeData.colorScheme.onSurface,
      ),
      actions: const [
        MineUnreadMessageCountIcon(),
      ],
      backgroundColor: Colors.transparent,
    );
  }
}

class MineUnreadMessageCountIcon extends StatelessWidget {
  const MineUnreadMessageCountIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return UnreadModelConsumer(
      builder: (context, value) {
        var count = value.unreadMsgCount;
        return Stack(
          alignment: Alignment.topRight,
          children: [
            IconButton(
              onPressed: () {
                if (LoginState.value(context).isLogin) {
                  AppRouter.of(context).pushNamed(RouteMap.messagePage);
                } else {
                  AppRouter.of(context).pushNamed(RouteMap.loginPage);
                }
              },
              icon: Icon(
                Icons.notifications,
                color: themeData.appBarTheme.iconTheme?.color,
              ),
            ),
            if (count > 0)
              Container(
                margin: const EdgeInsets.only(
                  right: 10,
                  top: 10,
                ),
                child: RedPoint(count: count),
              ),
          ],
        );
      },
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
              width: AppDimens.avatarSize,
              height: AppDimens.avatarSize,
              child: Container(
                color: Theme.of(context)
                    .appBarTheme
                    .iconTheme
                    ?.color
                    ?.withAlpha(60),
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
            style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
                  fontSize: Theme.of(context).textTheme.headline6?.fontSize,
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
                style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
                      fontSize: Theme.of(context).textTheme.bodyText2?.fontSize,
                    ),
              ),
              const SizedBox(width: AppDimens.marginNormal),
              Text(
                Strings.of(context).ranking_prefix +
                    (userBean?.coinInfo.rank ?? '0'),
                style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
                      fontSize: Theme.of(context).textTheme.bodyText2?.fontSize,
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
          title: Text(Strings.of(context).coin_title),
          tip: Text('${userBean?.coinInfo.coinCount ?? ''}'),
          onPressed: () {
            if (LoginState.value(context).isLogin) {
              AppRouter.of(context).pushNamed(RouteMap.coinPage);
            } else {
              AppRouter.of(context).pushNamed(RouteMap.loginPage);
            }
          },
        ),
        ActionItem(
          leading: const Icon(CupertinoIcons.share),
          title: Text(Strings.of(context).mine_share),
          onPressed: () {
            if (LoginState.value(context).isLogin) {
              AppRouter.of(context).pushNamed(RouteMap.mySharePage);
            } else {
              AppRouter.of(context).pushNamed(RouteMap.loginPage);
            }
          },
        ),
        ActionItem(
          leading: const Icon(CupertinoIcons.heart),
          title: Text(Strings.of(context).mine_collection),
          onPressed: () {
            if (LoginState.value(context).isLogin) {
              AppRouter.of(context).pushNamed(RouteMap.collectionPage);
            } else {
              AppRouter.of(context).pushNamed(RouteMap.loginPage);
            }
          },
        ),
        ActionItem(
          leading: const Icon(CupertinoIcons.info),
          title: Text(Strings.of(context).about_me),
          tip: Text(Strings.of(context).buy_him_a_cup_of_coffee),
          tipColor: Theme.of(context).colorScheme.error,
          onPressed: () {
            AppRouter.of(context).pushNamed(RouteMap.aboutMePage);
          },
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
