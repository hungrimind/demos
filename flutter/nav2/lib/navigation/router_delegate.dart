import 'package:flutter/material.dart';
import 'package:nav2demo/navigation/router_service.dart';
import 'package:nav2demo/pages/screens.dart';

class AppRouterDelegate extends RouterDelegate<String> {
  AppRouterDelegate({required RouterService routerService})
    : _routerService = routerService;

  final RouterService _routerService;

  List<Page<dynamic>> createPages() {
    List<Page<dynamic>> pages = [];
    for (String routeData in _routerService.navigationStack.value) {
      if (routeData.startsWith('/books/')) {
        pages.add(
          MaterialPage(
            key: ValueKey('Page_${routeData.hashCode}'),
            child: BookDetailsScreen(bookId: routeData.split('/').last),
          ),
        );
      }
      switch (routeData) {
        case '/':
          pages.add(
            MaterialPage(
              key: ValueKey('Page_${routeData.hashCode}'),
              child: HomeScreen(),
            ),
          );
        case '/books':
          pages.add(
            MaterialPage(
              key: ValueKey('Page_${routeData.hashCode}'),
              child: BooksScreen(),
            ),
          );

        case '/settings':
          pages.add(
            MaterialPage(
              key: ValueKey('Page_${routeData.hashCode}'),
              child: SettingsScreen(),
            ),
          );
        case '/404':
          pages.add(
            MaterialPage(
              key: ValueKey('Page_${routeData.hashCode}'),
              child: UnknownScreen(),
            ),
          );
      }
    }
    return pages;
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      pages: createPages(),
      onDidRemovePage: (page) {
        _routerService.pop();
      },
    );
  }

  @override
  Future<bool> popRoute() async {
    if (_routerService.navigationStack.value.length > 1) {
      _routerService.pop();
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
