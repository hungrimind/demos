import 'package:flutter/widgets.dart';

class CounterState {
  CounterState({
    required this.username,
    this.counter = 0,
  });

  final String username;
  final int counter;

  CounterState copyWith({
    final String? username,
    final int? counter,
  }) {
    return CounterState(
      username: username ?? this.username,
      counter: counter ?? this.counter,
    );
  }
}

class CounterNotifier extends ValueNotifier<CounterState> {
  CounterNotifier(super.state);

  void increment() {
    value = value.copyWith(counter: value.counter + 1);
  }
}

/// ChangeNotifier is extending [Listenable] so by using that subclass this can
/// also be reused for other [Listenable] classes.
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
