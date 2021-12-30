import 'package:flutter/material.dart';
import 'package:wanandroid/env/route/route_map.dart';

class AppRouter {
  static Route<dynamic>? generateRoute(settings) {
    return RouteMap.routes[settings.name]?.call(settings);
  }

  static Route<dynamic>? unknownRoute(settings) {
    return null;
  }

  static String initialRoute = RouteMap.routes.entries.first.key;
}