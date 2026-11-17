import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';
import '../../providers/cart_provider.dart';
import '../../providers/wishlist_provider.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text.dart';
import '../../utils/format.dart';
import '../../widgets/app_bottom_nav.dart';
import '../../widgets/app_header.dart';
import '../../widgets/pill.dart';
import '../../widgets/soft_image.dart';
import '../details/product_details_screen.dart';
import '../listing/listing_screen.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wishlist = context.watch<WishlistProvider>();
    final cart = context.read<CartProvider>();

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: BrandHeader(
                onMenu: () {},
                trailing: [
                  GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      Icons.ios_share,
                      size: 16,
                      color: AppColors.inkSoft,
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      Icons.notifications_none,
                      size: 17,
                      color: AppColors.inkSoft,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(18, 6, 18, 26),
                physics: const BouncingScrollPhysics(),
                children: [
                  Row(
                    children: [
                      Text('My Wishlist', style: AppText.serif(size: 25)),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.line),
                        ),
                        child: Text(
                          '${wishlist.count} SAVED ITEMS',
                          style: AppText.label(size: 6.8, spacing: 0.7),
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: wishlist.clear,
                        child: Text(
                          'Clear All',
                          style: AppText.sans(
                            size: 8.5,
                            weight: FontWeight.w500,
                            color: AppColors.accent,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Pieces you are considering, saved for your space.',
                    style: AppText.sans(size: 9, color: AppColors.muted),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(11),
                    decoration: BoxDecoration(
                      color: AppColors.creamDeep,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.auto_awesome_outlined,
                          size: 14,
                          color: AppColors.accent,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Complete the Set',
                                style: AppText.sans(
                                  size: 10,
                                  weight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Save up to 15% when curated together',
                                style: AppText.sans(
                                  size: 8,
                                  color: AppColors.mutedDark,
                                ),
                              ),
                            ],
                          ),
                        ),
                        PrimaryPill(
                          label: 'ADD ALL TO CART',
                          height: 28,
                          fontSize: 8,
                          trailing: Icons.arrow_forward,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          onTap: () {
                            for (final product in wishlist.items) {
                              cart.add(product);
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Saved pieces added to your bag'),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (wishlist.isEmpty)
                    _EmptyWishlist()
                  else
                    for (final product in wishlist.items) ...[
                      _WishlistRow(product: product, cart: cart),
                      const SizedBox(height: 10),
                    ],
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Dot(size: 4, color: AppColors.accent),
                      const SizedBox(width: 5),
                      Text(
                        'CURATED FOR CONNOISSEURS',
                        style: AppText.label(size: 7, spacing: 0.9),
                      ),
                      const Spacer(),
                      Text(
                        'Explore the atelier',
                        style: AppText.sans(size: 7.5, color: AppColors.muted),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _PrivateSaleCard(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const ListingScreen()),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 2),
    );
  }
}

class _WishlistRow extends StatelessWidget {
  const _WishlistRow({required this.product, required this.cart});

  final Product product;
  final CartProvider cart;

  @override
  Widget build(BuildContext context) {
    final wishlist = context.read<WishlistProvider>();
    final bool inStock = product.badge == 'In Stock' || product.badge == 'Bestseller';

    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ProductDetailsScreen(product: product),
        ),
      ),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(9),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.line),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SoftImage(
                  asset: product.image,
                  width: 76,
                  height: 82,
                  radius: 11,
                ),
                Positioned(
                  left: 4,
                  top: 4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: inStock ? AppColors.sage : AppColors.accent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      inStock ? 'In Stock' : 'Made to Order',
                      style: AppText.sans(
                        size: 6,
                        weight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          product.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppText.serif(size: 15),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => wishlist.remove(product),
                        child: const Padding(
                          padding: EdgeInsets.only(left: 4),
                          child: Icon(
                            Icons.close,
                            size: 12,
                            color: AppColors.muted,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${product.fabric} · ${product.scale}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppText.sans(size: 8, color: AppColors.mutedDark),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Dot(size: 3.5, color: AppColors.muted),
                      const SizedBox(width: 4),
                      Text(
                        product.leadTime,
                        style: AppText.sans(size: 7.5, color: AppColors.muted),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        inr(product.price),
                        style: AppText.sans(size: 13, weight: FontWeight.w600),
                      ),
                      const Spacer(),
                      PrimaryPill(
                        label: 'MOVE TO CART',
                        icon: Icons.shopping_bag_outlined,
                        height: 26,
                        fontSize: 7.5,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        onTap: () {
                          cart.add(product);
                          wishlist.remove(product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${product.name} moved to your bag'),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyWishlist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 34),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.line),
      ),
      child: Column(
        children: [
          const Icon(Icons.favorite_border, size: 26, color: AppColors.muted),
          const SizedBox(height: 9),
          Text('Nothing saved yet', style: AppText.serif(size: 17)),
          const SizedBox(height: 3),
          Text(
            'Tap the heart on any piece to keep it here.',
            style: AppText.sans(size: 9, color: AppColors.muted),
          ),
        ],
      ),
    );
  }
}

class _PrivateSaleCard extends StatelessWidget {
  const _PrivateSaleCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.creamDeep,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TinyBadge(label: 'AUTUMN PRIVATE'),
                    const SizedBox(height: 7),
                    Text(
                      'When your wishlist feels empty, discover our new arrivals',
                      style: AppText.serif(size: 17, height: 1.28),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              SoftImage(
                asset: 'assets/images/living_light.jpg',
                width: 58,
                height: 58,
                radius: 8,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Explore hand-finished sofas in limited seasonal upholstery, '
            'available for private viewing.',
            style: AppText.sans(
              size: 8.5,
              color: AppColors.mutedDark,
              height: 1.55,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                'View full gallery',
                style: AppText.sans(size: 7.5, color: AppColors.muted),
              ),
              const Spacer(),
              GestureDetector(
                onTap: onTap,
                behavior: HitTestBehavior.opaque,
                child: Row(
                  children: [
                    Text(
                      'Explore Gallery',
                      style: AppText.sans(
                        size: 8.5,
                        weight: FontWeight.w600,
                        color: AppColors.ink,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.arrow_forward, size: 10),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
