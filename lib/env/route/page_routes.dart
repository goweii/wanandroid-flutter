import 'package:flutter/material.dart';

typedef PageWidgetBuilder = Widget Function(
    BuildContext context, dynamic arguments);

class NonePageRoute<T> extends PageRouteBuilder<T> {
  NonePageRoute({
    required Page<dynamic> page,
    required PageWidgetBuilder builder,
  }) : super(
          settings: page,
          transitionDuration: const Duration(milliseconds: 0),
          pageBuilder: (context, animation, secondaryAnimation) {
            return builder(context, page.arguments);
          },
        );
}

class RightPageRoute<T> extends PageRouteBuilder<T> {
  RightPageRoute({
    required Page<dynamic> page,
    required PageWidgetBuilder builder,
  }) : super(
          settings: page,
          transitionDuration: const Duration(milliseconds: 400),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: const Offset(0.0, 0.0),
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.fastOutSlowIn,
              )),
              child: child,
            );
          },
          pageBuilder: (context, animation, secondaryAnimation) {
            return builder(context, page.arguments);
          },
        );
}

class BottomPageRoute<T> extends PageRouteBuilder<T> {
  BottomPageRoute({
    required Page<dynamic> page,
    required PageWidgetBuilder builder,
  }) : super(
          settings: page,
          transitionDuration: const Duration(milliseconds: 400),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 1.0),
                end: const Offset(0.0, 0.0),
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.fastOutSlowIn,
              )),
              child: child,
            );
          },
          pageBuilder: (context, animation, secondaryAnimation) {
            return builder(context, page.arguments);
          },
        );
}
