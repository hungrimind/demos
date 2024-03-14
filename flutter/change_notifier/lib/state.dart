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

class Provider extends InheritedWidget {
  const Provider(this.data, {Key? key, required Widget child})
      : super(key: key, child: child);

  final CounterState data;

  static CounterState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>()!.data;
  }

  @override
  bool updateShouldNotify(Provider oldWidget) {
    return data != oldWidget.data;
  }
}
