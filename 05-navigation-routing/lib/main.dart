import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// go_router: DECLARATIVE routing - you define all routes up front as a
// table, rather than imperatively pushing/popping. This is the standard
// approach for apps with deep linking, web URL support, or complex nested
// navigation (exactly what UniConnect Pro's 5-screen structure would use).
final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      // :id is a PATH PARAMETER - captured from the URL/route string
      path: '/product/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return ProductScreen(productId: id);
      },
    ),
  ],
);

void main() => runApp(MyApp(router: router));

class MyApp extends StatelessWidget {
  final GoRouter router;
  const MyApp({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: router);
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: ListView(
        children: List.generate(5, (i) => ListTile(
          title: Text('Product ${i + 1}'),
          // context.go() navigates by URL path - works identically on
          // mobile and Flutter web, and supports browser back/forward.
          onTap: () => context.go('/product/${i + 1}'),
        )),
      ),
    );
  }
}

class ProductScreen extends StatelessWidget {
  final String productId;
  const ProductScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product $productId')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go('/'),
          child: const Text('Back to list'),
        ),
      ),
    );
  }
}
