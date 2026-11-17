import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../providers/wishlist_provider.dart';
import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import '../utils/format.dart';
import 'pill.dart';
import 'soft_image.dart';

class ProductGridCard extends StatelessWidget {
  const ProductGridCard({
    super.key,
    required this.product,
    required this.onTap,
    this.imageHeight = 132,
    this.showViewAction = false,
  });

  final Product product;
  final VoidCallback onTap;
  final double imageHeight;
  final bool showViewAction;

  @override
  Widget build(BuildContext context) {
    final wishlist = context.watch<WishlistProvider>();
    final saved = wishlist.isSaved(product);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.line),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SoftImage(
                  asset: product.image,
                  height: imageHeight,
                  width: double.infinity,
                  radius: 12,
                ),
                Positioned(
                  top: 7,
                  right: 7,
                  child: GestureDetector(
                    onTap: () => wishlist.toggle(product),
                    child: Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        color: saved ? Colors.white : Colors.white.withValues(alpha: 0.9),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        saved ? Icons.favorite : Icons.favorite_border,
                        size: 11,
                        color: saved ? AppColors.accent : AppColors.inkSoft,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 7,
                  bottom: 7,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.94),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Dot(size: 3.5),
                        const SizedBox(width: 4),
                        Text(
                          product.badge,
                          style: AppText.sans(
                            size: 7.5,
                            weight: FontWeight.w500,
                            color: AppColors.inkSoft,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (showViewAction)
              Row(
                children: [
                  const Dot(size: 3.5, color: AppColors.accent),
                  const SizedBox(width: 4),
                  Text(
                    '${product.rating} (${product.reviews})',
                    style: AppText.sans(size: 8, color: AppColors.mutedDark),
                  ),
                  const Spacer(),
                  if (product.discount > 0)
                    Text(
                      '${(product.discount * 100).round()}% off',
                      style: AppText.sans(
                        size: 8,
                        weight: FontWeight.w500,
                        color: AppColors.sage,
                      ),
                    ),
                ],
              )
            else
              Text(
                product.brand.toUpperCase(),
                style: AppText.label(size: 7.5, spacing: 0.7),
              ),
            const SizedBox(height: 3),
            Text(
              product.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppText.serif(size: 14.5, height: 1.2),
            ),
            const SizedBox(height: 2),
            Text(
              '${product.scale} · ${product.fabric}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppText.sans(size: 8, color: AppColors.muted),
            ),
            const SizedBox(height: 6),
            if (showViewAction)
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Starting',
                          style: AppText.sans(size: 7.5, color: AppColors.muted),
                        ),
                        Text(
                          inr(product.price),
                          style: AppText.sans(size: 12, weight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  PrimaryPill(
                    label: 'View',
                    height: 26,
                    fontSize: 9,
                    onTap: onTap,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                  ),
                ],
              )
            else
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    inr(product.price),
                    style: AppText.sans(size: 12, weight: FontWeight.w600),
                  ),
                  const SizedBox(width: 5),
                  Flexible(
                    child: Text(
                      inr(product.mrp),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppText.sans(
                        size: 8,
                        color: AppColors.muted,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ),
                  const Spacer(),
                  if (product.discount > 0)
                    Text(
                      'Bespoke',
                      style: AppText.sans(
                        size: 7.5,
                        weight: FontWeight.w500,
                        color: AppColors.accent,
                      ),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
