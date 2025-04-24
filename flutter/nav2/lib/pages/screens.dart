import 'package:flutter/material.dart';
import 'package:nav2demo/core/locator.dart';
import 'package:nav2demo/navigation/router_service.dart';
// Removed incorrect import for route_names.dart
// Import NavigationState, AppRoute, navigationStateNotifier

// --- Example Screens ---

class HomeScreen extends StatelessWidget {
  static const String home = 'home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Update state using typed constant
                locator.get<RouterService>().push("/books");
              },
              child: const Text('Go to Books'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Update state using typed constant
                locator.get<RouterService>().push("/settings");
              },
              child: const Text('Go to Settings'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              // Example of navigating to a non-existent route
              onPressed: () {
                // Keep navigating to an invalid path string for 404 test
                locator.get<RouterService>().push('/invalid-path');
              },
              child: const Text('Go to Unknown Page (Simulate 404)'),
            ),
          ],
        ),
      ),
    );
  }
}

class BooksScreen extends StatefulWidget {
  static const String books = 'books';
  const BooksScreen({super.key});

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  int counter = 0;

  incrementCounter() {
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Example book IDs
    final bookIds = ['1', 'the-hobbit', '42'];
    return Scaffold(
      appBar: AppBar(title: Text('Books + $counter')),
      body: ListView.builder(
        itemCount: bookIds.length,
        itemBuilder: (context, index) {
          final bookId = bookIds[index];
          return ListTile(
            title: Text('Book $bookId'),
            onTap: () {
              locator.get<RouterService>().push("/books/$bookId");
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: incrementCounter,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class BookDetailsScreen extends StatelessWidget {
  static const String bookDetails = 'bookDetails';
  final String bookId;
  const BookDetailsScreen({super.key, required this.bookId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Book Details: $bookId')),
      body: Center(child: Text('Showing details for book ID: $bookId')),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  static const String settings = 'settings';
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: const Center(child: Text('App Settings')),
    );
  }
}

class UnknownScreen extends StatelessWidget {
  static const String unknown = 'unknown';
  const UnknownScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page Not Found')),
      body: const Center(
        child: Text('404 - The requested page could not be found.'),
      ),
    );
  }
}

class Page2Screen extends StatelessWidget {
  const Page2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page 2')),
      body: const Center(child: Text('Page 2')),
    );
  }
}
