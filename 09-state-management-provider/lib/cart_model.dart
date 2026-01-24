import 'package:flutter/foundation.dart';

class CartItem {
  final String name;
  final double price;
  CartItem({required this.name, required this.price});
}

// ChangeNotifier: a plain Dart class that can notify listeners when its
// internal state changes. This is the core building block Provider wraps -
// no Flutter-specific magic, just a well-known observer pattern.
class CartModel extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items); // don't expose the mutable list directly
  double get total => _items.fold(0, (sum, item) => sum + item.price);
  int get itemCount => _items.length;

  void addItem(CartItem item) {
    _items.add(item);
    notifyListeners(); // tells every widget watching this model to rebuild
  }

  void removeItem(CartItem item) {
    _items.remove(item);
    notifyListeners();
  }
}
