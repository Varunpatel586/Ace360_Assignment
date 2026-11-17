import 'package:flutter/material.dart';

import '../data/app_data.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  CartProvider() {
    for (final seed in AppData.bag) {
      _items.add(
        CartItem(product: seed.product, finish: seed.finish, spec: seed.spec),
      );
    }
  }

  final List<CartItem> _items = [];
  String coupon = 'SOFAPREST';
  bool couponApplied = true;

  List<CartItem> get items => List.unmodifiable(_items);
  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);
  bool get isEmpty => _items.isEmpty;

  int get subtotal => _items.fold(0, (sum, item) => sum + item.lineTotal);
  int get discount => couponApplied ? 5000 : 0;
  int get deliveryFee => 0;
  int get total => subtotal - discount + deliveryFee;

  void add(Product product, {int quantity = 1, String? finish, String? spec}) {
    final index = _items.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      _items[index].quantity += quantity;
    } else {
      _items.add(
        CartItem(
          product: product,
          quantity: quantity,
          finish: finish ?? 'Plush Cloud',
          spec: spec ?? 'Cotton-Twill Blend · Belgian Linen · Deep-Seated',
        ),
      );
    }
    notifyListeners();
  }

  void increment(CartItem item) {
    item.quantity += 1;
    notifyListeners();
  }

  void decrement(CartItem item) {
    if (item.quantity > 1) {
      item.quantity -= 1;
    } else {
      _items.remove(item);
    }
    notifyListeners();
  }

  void remove(CartItem item) {
    _items.remove(item);
    notifyListeners();
  }

  void applyCoupon(String code) {
    coupon = code.trim().isEmpty ? coupon : code.trim().toUpperCase();
    couponApplied = true;
    notifyListeners();
  }

  void removeCoupon() {
    couponApplied = false;
    notifyListeners();
  }
}
