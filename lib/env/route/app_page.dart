import 'package:flutter/material.dart';
import 'package:wanandroid/env/route/route_path.dart';

typedef RouteBuilder = Route<dynamic> Function(
    BuildContext context, Page<dynamic> page);

class AppPage extends Page<dynamic> {
  AppPage({
    required RoutePath routePath,
    required this.builder,
  }) : super(
          key: ValueKey(routePath.location),
          name: routePath.location,
          arguments: routePath.arguments,
        );

  final RouteBuilder builder;

  @override
  Route<dynamic> createRoute(BuildContext context) {
    return builder(context, this);
  }
}
