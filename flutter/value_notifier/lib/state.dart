import 'package:flutter/widgets.dart';

class CounterModel {
  CounterModel({
    required this.username,
    this.counter = 0,
  });

  final String username;
  final int counter;

  CounterModel copyWith({
    final String? username,
    final int? counter,
  }) {
    return CounterModel(
      username: username ?? this.username,
      counter: counter ?? this.counter,
    );
  }
}

class CounterNotifier extends ValueNotifier<CounterModel> {
  CounterNotifier(super.state);

  void increment() {
    value = value.copyWith(counter: value.counter + 1);
  }
}
