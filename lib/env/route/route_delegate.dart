import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/env/route/route_map.dart';
import 'package:wanandroid/env/route/route_path.dart';

class AppRouteDelegate extends RouterDelegate<RoutePath<dynamic>>
    with PopNavigatorRouterDelegateMixin<RoutePath<dynamic>>, ChangeNotifier {
  final List<RoutePath<dynamic>> _stack = [];

  List<RoutePath<dynamic>> get stack => List.unmodifiable(_stack);

  @override
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  RoutePath<dynamic>? get currentConfiguration =>
      _stack.isNotEmpty ? _stack.last : null;

  void pushNamed(String name, {dynamic arguments}) {
    push(RoutePath(
      location: name,
      arguments: arguments,
    ));
  }

  void push(RoutePath<dynamic> routePath) {
    if (!_stack.contains(routePath)) {
      _stack.add(routePath);
      notifyListeners();
    }
  }

  void pop() {
    if (_stack.isNotEmpty) {
      _stack.removeLast();
      notifyListeners();
    }
  }

  @override
  Future<void> setNewRoutePath(RoutePath<dynamic> configuration) {
    if (configuration.isRoot) {
      _stack.removeWhere((element) {
        return !element.isRoot;
      });
      if (_stack.isEmpty) {
        _stack.add(configuration);
      }
    } else {
      _stack.add(configuration);
    }
    return SynchronousFuture(null);
  }

  bool _onPopPage(Route<dynamic> route, dynamic result) {
    if (_stack.isNotEmpty) {
      _stack.removeLast();
      notifyListeners();
    }
    return route.didPop(result);
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onPopPage: _onPopPage,
      pages: _buildPages(context),
    );
  }

  List<Page<dynamic>> _buildPages(BuildContext context) {
    List<Page<dynamic>> pages = [];
    for (var element in _stack) {
      var page = RouteMap.buildPage(context, element);
      if (page != null) {
        pages.add(page);
      }
    }
    return pages;
  }
}
