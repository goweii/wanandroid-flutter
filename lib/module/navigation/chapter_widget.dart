import 'package:flutter/material.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';

class AppBarBottom extends StatelessWidget implements PreferredSizeWidget {
  const AppBarBottom({
    Key? key,
    required this.child,
    this.height = AppDimens.tabBarHeight,
  }) : super(key: key);

  final Widget child;
  final double height;

  @override
  Size get preferredSize => Size(double.infinity, height);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: child,
    );
  }
}
