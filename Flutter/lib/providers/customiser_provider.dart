import 'package:flutter/material.dart';

/// Drives the product configurator on the details screen: palette, fabric,
/// seating configuration and quantity.
class CustomiserProvider extends ChangeNotifier {
  static const List<Color> palette = [
    Color(0xFFF1E7D8),
    Color(0xFF7A8CA0),
    Color(0xFF3C6B74),
    Color(0xFF7C8C6B),
  ];

  static const List<String> fabrics = ['Linen', 'Velvet', 'Leatherette'];
  static const List<int> fabricUplift = [0, 4500, 6000];
  static const List<String> scales = ['3-Seater', '2-Seater', 'L-Shape'];

  int paletteIndex = 0;
  int fabricIndex = 0;
  int scaleIndex = 1;
  int quantity = 1;

  Color get selectedColour => palette[paletteIndex];
  String get selectedFabric => fabrics[fabricIndex];
  int get uplift => fabricUplift[fabricIndex];
  String get selectedScale => scales[scaleIndex];

  void selectPalette(int index) {
    paletteIndex = index;
    notifyListeners();
  }

  void selectFabric(int index) {
    fabricIndex = index;
    notifyListeners();
  }

  void selectScale(int index) {
    scaleIndex = index;
    notifyListeners();
  }

  void setQuantity(int value) {
    quantity = value.clamp(1, 9);
    notifyListeners();
  }

  void increment() => setQuantity(quantity + 1);
  void decrement() => setQuantity(quantity - 1);

  void reset() {
    paletteIndex = 0;
    fabricIndex = 0;
    scaleIndex = 1;
    quantity = 1;
    notifyListeners();
  }
}
