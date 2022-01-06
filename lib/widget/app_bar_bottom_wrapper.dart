import 'package:flutter/material.dart';

class AppBarBottomWrapper extends StatelessWidget implements PreferredSizeWidget {
  const AppBarBottomWrapper({
    Key? key,
    required this.height,
    required this.child,
  }) : super(key: key);

  final double height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }

  @override
  Size get preferredSize => Size(double.infinity, height);
}
