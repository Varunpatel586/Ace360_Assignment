import '../models/product.dart';

class AppData {
  const AppData._();

  static const Product luna = Product(
    id: 'luna',
    name: 'Luna Sofa',
    brand: 'Luna Atelier',
    blurb: 'Deep-seated comfort wrapped in a cotton-twill blend, finished by hand '
        'in our Bengaluru workshop.',
    image: 'assets/images/luna_sofa.jpg',
    price: 42999,
    mrp: 58000,
    rating: 4.9,
    reviews: 28,
    badge: 'Bespoke',
    scale: '3-Seater',
    fabric: 'Belgian Linen',
  );

  static const Product kavya = Product(
    id: 'kavya',
    name: 'Kavya Sectional',
    brand: 'Kavya Studio',
    blurb: 'A low-slung L-shape sectional with feather-blend cushions and a '
        'solid teak plinth.',
    image: 'assets/images/kavya_sectional.jpg',
    price: 66499,
    mrp: 82000,
    rating: 4.8,
    reviews: 41,
    badge: 'Signature',
    scale: 'L-Shape',
    fabric: 'Performance Weave',
    leadTime: 'Ships in 8–10 days',
  );

  static const Product odila = Product(
    id: 'odila',
    name: 'Odila Modular',
    brand: 'Odila Collection',
    blurb: 'Deeply cushioned modular seating built for slow evenings and '
        'long, unhurried conversations.',
    image: 'assets/images/odila_modular.jpg',
    price: 52000,
    mrp: 64000,
    rating: 4.7,
    reviews: 19,
    badge: 'Modular',
    scale: 'Ottoman & Modular',
    fabric: 'Textured Bouclé',
  );

  static const Product studio = Product(
    id: 'studio',
    name: 'Studio Arc Sofa',
    brand: 'Atelier Studio',
    blurb: 'An architectural three-seater with a hand-finished oak base and '
        'a gently curved silhouette.',
    image: 'assets/images/studio_sofa.jpg',
    price: 58900,
    mrp: 72000,
    rating: 4.9,
    reviews: 22,
    badge: 'New',
    scale: '3-Seater',
    fabric: 'Wool Blend',
  );

  static const Product haber = Product(
    id: 'haber',
    name: 'Haber Velvet Accent Chair',
    brand: 'Haber & Co.',
    blurb: 'A sculptural accent chair upholstered in velvet with a solid '
        'walnut frame.',
    image: 'assets/images/armchair_leather.jpg',
    price: 24999,
    mrp: 31000,
    rating: 4.6,
    reviews: 14,
    badge: 'In Stock',
    scale: 'Armchair',
    fabric: 'Velvet',
    leadTime: 'In stock · ships in 3 days',
  );

  static const Product boucle = Product(
    id: 'boucle',
    name: 'Ellis Bouclé Chair',
    brand: 'Ellis Atelier',
    blurb: 'Soft bouclé upholstery over a moulded shell — an easy reading '
        'chair for a bright corner.',
    image: 'assets/images/boucle_chair.jpg',
    price: 21499,
    mrp: 26500,
    rating: 4.5,
    reviews: 11,
    badge: 'Bestseller',
    scale: 'Armchair',
    fabric: 'Bouclé',
  );

  static const List<Product> featured = [luna, kavya];
  static const List<Product> catalogue = [luna, kavya, studio, odila, haber, boucle];
  static const List<Product> wishlist = [luna, kavya, haber];

  /// Two atelier pieces pre-loaded in the shopping bag, as in the design.
  static List<CartItemSeed> get bag => const [
        CartItemSeed(product: luna, finish: 'Plush Cloud', spec: 'Cotton-Twill Blend · Deep-Seated'),
        CartItemSeed(product: kavya, finish: 'Cream', spec: 'Blended Weave · L-Shape · Belgian Linen'),
      ];
}

class CartItemSeed {
  const CartItemSeed({required this.product, required this.finish, required this.spec});
  final Product product;
  final String finish;
  final String spec;
}
