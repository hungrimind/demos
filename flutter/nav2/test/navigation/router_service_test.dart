import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nav2demo/navigation/best_router.dart';
import 'package:nav2demo/navigation/route_data.dart';
import 'package:nav2demo/navigation/router_service.dart';

void main() {
  group('Navigation Tests', () {
    late RouterService routerService;
    late List<RouteEntry> testRoutes;

    setUp(() {
      // Define test routes
      testRoutes = [
        RouteEntry(
          path: '/',
          builder: (key, routeData) => const HomePage(),
        ),
        RouteEntry(
          path: '/details',
          builder: (key, routeData) => DetailsPage(
            id: routeData.queryParameters['id'],
            category: routeData.queryParameters['category'],
          ),
        ),
        RouteEntry(
          path: '/products/:id',
          builder: (key, routeData) => ProductPage(
            id: routeData.pathParameters['id'] ?? '',
            color: routeData.queryParameters['color'],
            size: routeData.queryParameters['size'],
          ),
        ),
        RouteEntry(
          path: '/users/:userId/posts/:postId',
          builder: (key, routeData) => UserPostPage(
            userId: routeData.pathParameters['userId'] ?? '',
            postId: routeData.pathParameters['postId'] ?? '',
          ),
        ),
        RouteEntry(
          path: '/settings',
          builder: (key, routeData) => const SettingsPage(),
        ),
        RouteEntry(
          path: '/404',
          builder: (key, routeData) => const NotFoundPage(),
        ),
        RouteEntry(
          path: '/pop-scope',
          builder: (key, routeData) {
            final canPop = routeData.queryParameters['canPop'] != 'false';
            return PopScopePage(
              key: key,
              canPop: canPop,
            );
          },
        ),
      ];

      // Initialize router service with test routes
      routerService = RouterService(supportedRoutes: testRoutes);
    });

    Widget createTestApp() {
      return MaterialApp.router(
        routerConfig: BestRouterConfig(
          routerService: routerService,
        ),
      );
    }

    testWidgets('Initial route should be home', (tester) async {
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      expect(find.byType(HomePage), findsOneWidget);
      expect(routerService.navigationStack.value.length, 1);
      expect(routerService.navigationStack.value.first.pathWithParams, '/');
    });

    testWidgets('Push should add new route to stack', (tester) async {
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      expect(find.byType(HomePage), findsOneWidget);
      
      routerService.push('/details');
      await tester.pumpAndSettle();

      expect(find.byType(DetailsPage), findsOneWidget);
      expect(find.byType(HomePage), findsNothing);
      expect(routerService.navigationStack.value.length, 2);
      expect(routerService.navigationStack.value.last.pathWithParams, '/details');
    });

    testWidgets('Pop should remove last route from stack', (tester) async {
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      routerService.push('/details');
      await tester.pumpAndSettle();

      expect(find.byType(DetailsPage), findsOneWidget);
      
      routerService.pop();
      await tester.pumpAndSettle();

      expect(find.byType(HomePage), findsOneWidget);
      expect(find.byType(DetailsPage), findsNothing);
      expect(routerService.navigationStack.value.length, 1);
      expect(routerService.navigationStack.value.last.pathWithParams, '/');
    });

    testWidgets('Replace all should clear stack and set new route', (tester) async {
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      routerService.push('/details');
      await tester.pumpAndSettle();

      expect(find.byType(DetailsPage), findsOneWidget);
      
      routerService.replaceAll('/settings');
      await tester.pumpAndSettle();

      expect(find.byType(SettingsPage), findsOneWidget);
      expect(find.byType(DetailsPage), findsNothing);
      expect(routerService.navigationStack.value.length, 1);
      expect(routerService.navigationStack.value.last.pathWithParams, '/settings');
    });

    testWidgets('Push invalid route should navigate to 404 and keep the previous route', (tester) async {
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      routerService.push('/invalid-route');
      await tester.pumpAndSettle();

      expect(find.byType(NotFoundPage), findsOneWidget);
      expect(routerService.navigationStack.value.length, 2);
      expect(routerService.navigationStack.value.last.pathWithParams, '/404');
    });

    group('Route Parameters Tests', () {
      testWidgets('Should handle query parameters correctly', (tester) async {
        await tester.pumpWidget(createTestApp());
        await tester.pumpAndSettle();

        routerService.push('/details?id=123&category=books');
        await tester.pumpAndSettle();

        expect(find.text('Details: 123 - books'), findsOneWidget);
        expect(routerService.navigationStack.value.last.queryParameters, {
          'id': '123',
          'category': 'books',
        });
      });

      testWidgets('Should handle path parameters correctly', (tester) async {
        await tester.pumpWidget(createTestApp());
        await tester.pumpAndSettle();

        routerService.push('/products/456');
        await tester.pumpAndSettle();

        expect(find.text('Product: 456'), findsOneWidget);
        expect(routerService.navigationStack.value.last.pathParameters, {
          'id': '456',
        });
      });

      testWidgets('Should handle multiple path parameters correctly', (tester) async {
        await tester.pumpWidget(createTestApp());
        await tester.pumpAndSettle();

        routerService.push('/users/123/posts/789');
        await tester.pumpAndSettle();

        expect(find.text('User 123 - Post 789'), findsOneWidget);
        expect(routerService.navigationStack.value.last.pathParameters, {
          'userId': '123',
          'postId': '789',
        });
      });

      testWidgets('Should handle mixed query and path parameters', (tester) async {
        await tester.pumpWidget(createTestApp());
        await tester.pumpAndSettle();

        routerService.push('/products/456?color=red&size=large');
        await tester.pumpAndSettle();

        expect(find.text('Product: 456 (red, large)'), findsOneWidget);
        expect(routerService.navigationStack.value.last.queryParameters, {
          'color': 'red',
          'size': 'large',
        });
      });
    });

    group('PopScope Tests', () {
      testWidgets('Should allow pop when canPop is true', (tester) async {
        await tester.pumpWidget(createTestApp());
        await tester.pumpAndSettle();

        // Navigate to PopScope page
        routerService.push('/pop-scope');
        await tester.pumpAndSettle();

        expect(find.byType(PopScopePage), findsOneWidget);
        expect(routerService.navigationStack.value.length, 2);

        // Trigger pop through Navigator
        await tester.pageBack();
        await tester.pumpAndSettle();

        expect(find.byType(HomePage), findsOneWidget);
        expect(routerService.navigationStack.value.length, 1);
      });

      testWidgets('Should prevent pop when canPop is false', (tester) async {
        await tester.pumpWidget(createTestApp());
        await tester.pumpAndSettle();

        // Navigate to PopScope page with canPop set to false
        routerService.push('/pop-scope?canPop=false');
        await tester.pumpAndSettle();

        expect(find.byType(PopScopePage), findsOneWidget);
        expect(routerService.navigationStack.value.length, 2);

        // Attempt to pop through Navigator
        await tester.pageBack();
        await tester.pumpAndSettle();

        // Verify pop was prevented
        expect(find.byType(PopScopePage), findsOneWidget);
        expect(routerService.navigationStack.value.length, 2);
      });
    });
  });
}

// Test pages
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Home')),
    );
  }
}

class DetailsPage extends StatelessWidget {
  const DetailsPage({
    super.key,
    this.id,
    this.category,
  });

  final String? id;
  final String? category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Details: $id - $category')),
    );
  }
}

class ProductPage extends StatelessWidget {
  const ProductPage({
    super.key,
    required this.id,
    this.color,
    this.size,
  });

  final String id;
  final String? color;
  final String? size;

  @override
  Widget build(BuildContext context) {
    if (color != null || size != null) {
      return Scaffold(
        body: Center(child: Text('Product: $id ($color, $size)')),
      );
    }
    return Scaffold(
      body: Center(child: Text('Product: $id')),
    );
  }
}

class UserPostPage extends StatelessWidget {
  const UserPostPage({
    super.key,
    required this.userId,
    required this.postId,
  });

  final String userId;
  final String postId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('User $userId - Post $postId')),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Settings')),
    );
  }
} 

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('404')),
    );
  }
}

// Add PopScopePage for testing PopScope behavior
class PopScopePage extends StatelessWidget {
  const PopScopePage({
    super.key,
    this.canPop = true,
    this.onPopInvoked,
  });

  final bool canPop;
  final PopInvokedWithResultCallback<dynamic>? onPopInvoked;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      onPopInvokedWithResult: onPopInvoked,
      child: Scaffold(
        appBar: AppBar(title: const Text('Pop Scope Page')),
        body: const Center(child: Text('Pop Scope Page')),
      ),
    );
  }
}
