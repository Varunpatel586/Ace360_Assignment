import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../screens/cart/cart_screen.dart';
import '../screens/listing/listing_screen.dart';
import '../screens/wishlist/wishlist_screen.dart';
import '../theme/app_colors.dart';
import '../theme/app_text.dart';

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({
    super.key,
    required this.currentIndex,
    this.transparent = false,
  });

  final int currentIndex;
  final bool transparent;

  static const _labels = ['Home', 'Explore', 'Wishlist', 'Cart'];
  static const _icons = [
    Icons.weekend_outlined,
    Icons.explore_outlined,
    Icons.favorite_border,
    Icons.shopping_bag_outlined,
  ];

  void _open(BuildContext context, int index) {
    if (index == currentIndex) {
      if (index != 0) return;
    }
    switch (index) {
      case 0:
        Navigator.of(context).popUntil((route) => route.isFirst);
        break;
      case 1:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const ListingScreen()),
        );
        break;
      case 2:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const WishlistScreen()),
        );
        break;
      case 3:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const CartScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartCount = context.watch<CartProvider>().itemCount;
    return Container(
      decoration: BoxDecoration(
        color: transparent ? AppColors.cream : Colors.white,
        border: const Border(top: BorderSide(color: AppColors.lineSoft)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 56,
          child: Row(
            children: [
              for (var i = 0; i < _labels.length; i++)
                Expanded(
                  child: _NavItem(
                    label: _labels[i],
                    icon: _icons[i],
                    active: i == currentIndex,
                    badge: i == 3 && cartCount > 0 ? '$cartCount' : null,
                    onTap: () => _open(context, i),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.label,
    required this.icon,
    required this.active,
    required this.onTap,
    this.badge,
  });

  final String label;
  final IconData icon;
  final bool active;
  final VoidCallback onTap;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    final Color color = active ? AppColors.ink : AppColors.muted;
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 22,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(icon, size: 20, color: color),
                if (badge != null)
                  Positioned(
                    right: -7,
                    top: -4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 1,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.accent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        badge!,
                        style: AppText.sans(
                          size: 7.5,
                          weight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: AppText.sans(
              size: 8.5,
              weight: active ? FontWeight.w600 : FontWeight.w400,
              color: color,
              spacing: 0.3,
            ),
          ),
          const SizedBox(height: 3),
          Container(
            width: 3,
            height: 3,
            decoration: BoxDecoration(
              color: active ? AppColors.accent : Colors.transparent,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}
