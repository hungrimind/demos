import 'package:flutter/material.dart';
import 'package:nav2demo/core/locator.dart';
import 'package:nav2demo/navigation/best_router.dart';
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
  late BestRouterConfig _bestRouterConfig;

  @override
  void initState() {
    super.initState();
    _bestRouterConfig = BestRouterConfig(
      routerService: locator.get<RouterService>(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: _bestRouterConfig);
  }
}
