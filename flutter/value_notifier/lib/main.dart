import 'package:flutter/material.dart';

import 'provider.dart';
import 'state.dart';

void main() {
  runApp(
    Provider(
      notifier: CounterNotifier(CounterState(username: "Tadas")),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final counterNotifier = Provider.of<CounterNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("InheritedNotifier"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '${counterNotifier.value.username} has pushed the button this many times:',
            ),
            Text(
              '${counterNotifier.value.counter}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => counterNotifier.increment(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
