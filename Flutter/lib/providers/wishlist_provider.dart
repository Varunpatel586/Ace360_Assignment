import 'package:flutter/foundation.dart';

import '../data/app_data.dart';
import '../models/product.dart';

class WishlistProvider extends ChangeNotifier {
  final List<Product> _items = [...AppData.wishlist];

  List<Product> get items => List.unmodifiable(_items);
  int get count => _items.length;
  bool get isEmpty => _items.isEmpty;

  bool isSaved(Product product) => _items.any((item) => item.id == product.id);

  void toggle(Product product) {
    if (isSaved(product)) {
      _items.removeWhere((item) => item.id == product.id);
    } else {
      _items.add(product);
    }
    notifyListeners();
  }

  void remove(Product product) {
    _items.removeWhere((item) => item.id == product.id);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
