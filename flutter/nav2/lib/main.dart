import 'package:flutter/material.dart';
import 'package:nav2demo/core/config/route_config.dart';
import 'package:nav2demo/core/locator.dart';
import 'package:nav2demo/navigation/route_information_parser.dart';
import 'package:nav2demo/navigation/router_delegate.dart';
import 'package:nav2demo/navigation/router_service.dart';
import 'package:nav2demo/navigation/url_strategy/url_strategy.dart';

// Import your Delegate, Parser, Notifier, and other necessary files
void main() {
  setupLocator();
  configureUrlStrategy();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final RouterDelegate<Object> routerDelegate;
  late final RouteInformationParser<Object> routeInformationParser;

  @override
  void initState() {
    super.initState();
    routerDelegate = AppRouterDelegate(
      routerService: locator.get<RouterService>(),
    );
    routeInformationParser = AppRouteInformationParser(routes: routes);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: routerDelegate,
      routeInformationParser: routeInformationParser,
    );
  }
}
