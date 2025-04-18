import 'package:flutter/material.dart';
import 'package:nav2demo/navigation/utils.dart';

class AppRouteInformationParser extends RouteInformationParser<String> {
  AppRouteInformationParser({required this.routes});

  final List<String> routes;

  @override
  Future<String> parseRouteInformation(
    RouteInformation routeInformation,
  ) async {
    final uri = routeInformation.uri;
    return findMatchingRoutePattern(uri.toString(), routes);
  }

  @override
  RouteInformation? restoreRouteInformation(String configuration) {
    if (configuration.isNotEmpty) {
      return RouteInformation(uri: Uri.parse(configuration));
    }

    return null;
  }
}
