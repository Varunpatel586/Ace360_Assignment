import 'product.dart';

class CartItem {
  CartItem({
    required this.product,
    this.quantity = 1,
    this.finish = 'Plush Cloud',
    this.spec = 'Cotton-Twill Blend · Belgian Linen · Deep-Seated',
  });

  final Product product;
  final String finish;
  final String spec;
  int quantity;

  int get lineTotal => product.price * quantity;
}
