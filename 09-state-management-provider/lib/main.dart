import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_model.dart';

void main() {
  runApp(
    // ChangeNotifierProvider makes the CartModel available to this widget
    // and ALL its descendants, without manually passing it down through
    // every constructor (avoiding "prop drilling").
    ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => const MaterialApp(home: ShopPage());
}

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    final products = [
      CartItem(name: 'Laptop', price: 1200),
      CartItem(name: 'Mouse', price: 20),
      CartItem(name: 'Keyboard', price: 45),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop'),
        actions: [
          // Consumer rebuilds ONLY this small widget when CartModel changes -
          // not the entire ShopPage - which is much more efficient.
          Consumer<CartModel>(
            builder: (context, cart, child) => Padding(
              padding: const EdgeInsets.all(16),
              child: Text('Cart: ${cart.itemCount} (KES ${cart.total.toStringAsFixed(0)})'),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text('KES ${product.price.toStringAsFixed(0)}'),
            trailing: ElevatedButton(
              // context.read<T>() gets the model WITHOUT subscribing to
              // rebuilds - correct for one-off actions like a button press.
              // (context.watch<T>() would subscribe and rebuild - use that
              // only inside build() when you need to DISPLAY changing data.)
              onPressed: () => context.read<CartModel>().addItem(product),
              child: const Text('Add'),
            ),
          );
        },
      ),
    );
  }
}
