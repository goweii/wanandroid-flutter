import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/env/route/route_path.dart';

class AppRouteParser extends RouteInformationParser<RoutePath<dynamic>> {
  @override
  Future<RoutePath<dynamic>> parseRouteInformation(
      RouteInformation routeInformation) {
    RoutePath routePath = RoutePath(
      location: routeInformation.location ?? '/',
      arguments: null,
    );
    return SynchronousFuture(routePath);
  }

  @override
  RouteInformation restoreRouteInformation(RoutePath<dynamic> configuration) {
    return RouteInformation(
      location: configuration.location,
    );
  }
}
