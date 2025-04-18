import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:nav2demo/core/config/route_config.dart';
import 'package:nav2demo/navigation/route_information_parser.dart';
import 'package:nav2demo/navigation/router_delegate.dart';
import 'package:nav2demo/navigation/router_service.dart';

class BestRouterConfig extends RouterConfig<Object> {
  BestRouterConfig({required RouterService routerService})
    : super(
        routerDelegate: AppRouterDelegate(routerService: routerService),
        routeInformationProvider: PlatformRouteInformationProvider(
          initialRouteInformation: RouteInformation(
            uri: Uri.parse(PlatformDispatcher.instance.defaultRouteName),
          ),
        ),
        routeInformationParser: AppRouteInformationParser(routes: routes),
      );
}
