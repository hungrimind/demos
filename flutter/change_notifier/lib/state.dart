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
