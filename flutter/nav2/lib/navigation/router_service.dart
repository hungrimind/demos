import 'package:flutter/material.dart';
import 'package:nav2demo/core/config/route_config.dart';

/// Service responsible for managing navigation state using MVVM pattern
class RouterService {
  final navigationStack = ValueNotifier<List<String>>(['/']);

  void push(String path) {
    if (path == navigationStack.value.last) {
      return;
    }

    if (routes.contains(path) || path.startsWith('/books/')) {
      navigationStack.value = [...navigationStack.value, path];
      print('Navigation stack: ${navigationStack.value}');
    } else {
      navigationStack.value = [...navigationStack.value, '/404'];
      print('Invalid path: $path');
    }
  }

  void pop() {
    if (navigationStack.value.length <= 1) {
      return;
    }

    navigationStack.value = navigationStack.value.sublist(
      0,
      navigationStack.value.length - 1,
    );
    print('Navigation stack: ${navigationStack.value}');
  }

  void replaceAll(String path) {
    navigationStack.value = [path];
    print('Navigation stack: ${navigationStack.value}');
  }
}
