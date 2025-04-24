import 'package:flutter/material.dart';
import 'package:nav2demo/navigation/router_service.dart';
import 'package:nav2demo/pages/screens.dart';

class AppRouterDelegate extends RouterDelegate<String> {
  AppRouterDelegate({required RouterService routerService})
    : _routerService = routerService;

  final RouterService _routerService;
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  List<Page<dynamic>> createPages() {
    List<Page<dynamic>> pages = [];
    final navigationStack = _routerService.navigationStack.value;
    for (int index = 0; index < navigationStack.length; index++) {
      final route = navigationStack[index];
      if (route.startsWith('/books/')) {
        pages.add(
          MaterialPage(
            key: ValueKey('Page_$index'),
            child: BookDetailsScreen(bookId: route.split('/').last),
          ),
        );
      }
      switch (route) {
        case '/':
          pages.add(
            MaterialPage(key: ValueKey('Page_$index'), child: HomeScreen()),
          );
        case '/books':
          pages.add(
            MaterialPage(key: ValueKey('Page_$index'), child: BooksScreen()),
          );

        case '/settings':
          pages.add(
            MaterialPage(key: ValueKey('Page_$index'), child: SettingsScreen()),
          );
        case '/404':
          pages.add(
            MaterialPage(key: ValueKey('Page_$index'), child: UnknownScreen()),
          );
      }
    }
    return pages;
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navigatorKey,
      pages: createPages(),
      onDidRemovePage: (page) {
        _routerService.pop();
      },
    );
  }

  @override
  Future<bool> popRoute() async {
    if (_routerService.navigationStack.value.length > 1) {
      Navigator.of(_navigatorKey.currentContext!).pop();
      return true;
    }
    return false;
  }

  @override
  String? get currentConfiguration {
    if (_routerService.navigationStack.value.isEmpty) {
      return null;
    }
    return _routerService.navigationStack.value.last;
  }

  @override
  Future<void> setNewRoutePath(String configuration) async {
    _routerService.replaceAll(configuration);
  }

  @override
  void addListener(VoidCallback listener) {
    _routerService.navigationStack.addListener(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    _routerService.navigationStack.removeListener(listener);
  }
}
