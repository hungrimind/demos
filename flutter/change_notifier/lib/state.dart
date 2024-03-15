import 'package:flutter/widgets.dart';

class CounterState extends ChangeNotifier {
  CounterState({required this.username});

  String username;
  int counter = 0;

  void increment() {
    counter++;
    notifyListeners();
  }
}

class ListenableProvider<T extends Listenable> extends InheritedNotifier<T> {
  const ListenableProvider({
    super.key,
    required super.child,
    required super.notifier,
  });

  static T of<T extends Listenable>(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<ListenableProvider<T>>();

    if (provider == null) {
      throw Exception("No Provider found in context");
    }

    final notifier = provider.notifier;

    if (notifier == null) {
      throw Exception("No notifier found in Provider");
    }

    return notifier;
  }
}
