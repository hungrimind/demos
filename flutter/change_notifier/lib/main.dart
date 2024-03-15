import 'package:flutter/material.dart';
import 'package:state_management/state.dart';

void main() {
  runApp(
    ListenableProvider(
      notifier: CounterNotifier(CounterState(username: "John")),
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
    final counter = ListenableProvider.of<CounterNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("InheritedNotifier"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '${counter.value.username} has pushed the button this many times:',
            ),
            Text(
              '${counter.value.counter}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            ListenableProvider.of<CounterNotifier>(context).increment(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
