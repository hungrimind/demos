import 'package:flutter/material.dart';
import 'package:state_management/state.dart';

void main() {
  runApp(
    ListenableProvider(
      notifier: CounterState(username: "tadas"),
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
    final counter = ListenableProvider.of<CounterState>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("InheritedNotifier"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '${counter.username} has pushed the button this many times:',
            ),
            Text(
              '${counter.counter}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            ListenableProvider.of<CounterState>(context).increment(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
