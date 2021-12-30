import 'package:flutter/material.dart';
import 'package:wanandroid/env/route/page_builder.dart';

class NonePageRoute<T> extends PageRouteBuilder<T> {
  NonePageRoute({
    required RouteSettings settings,
    required PageBuilder builder,
  }) : super(
          transitionDuration: const Duration(milliseconds: 0),
          pageBuilder: (context, animation, secondaryAnimation) {
            return builder(context, settings);
          },
        );
}

class BottomPageRoute<T> extends PageRouteBuilder<T> {
  BottomPageRoute({
    required RouteSettings settings,
    required PageBuilder builder,
  }) : super(
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
            return builder(context, settings);
          },
        );
}
