class Product {
  const Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.blurb,
    required this.image,
    required this.price,
    required this.mrp,
    required this.rating,
    required this.reviews,
    this.badge = 'Bespoke',
    this.scale = '3-Seater',
    this.fabric = 'Belgian Linen',
    this.leadTime = 'Ships in 6–7 days',
  });

  final String id;
  final String name;
  final String brand;
  final String blurb;
  final String image;
  final int price;
  final int mrp;
  final double rating;
  final int reviews;
  final String badge;
  final String scale;
  final String fabric;
  final String leadTime;

  double get discount => mrp <= price ? 0 : (mrp - price) / mrp;
}
