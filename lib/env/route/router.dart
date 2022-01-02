import 'package:flutter/material.dart';
import 'package:wanandroid/env/route/route_delegate.dart';

class AppRouter {
  static AppRouteDelegate of(BuildContext context) {
    final delegate = Router.of(context).routerDelegate;
    assert(delegate is AppRouteDelegate, 'Delegate type must match');
    return delegate as AppRouteDelegate;
  }
}
