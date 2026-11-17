import 'package:flutter/material.dart';

import '../../data/app_data.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text.dart';
import '../../widgets/app_bottom_nav.dart';
import '../../widgets/app_header.dart';
import '../../widgets/pill.dart';
import '../../widgets/product_card.dart';
import '../../widgets/section_heading.dart';
import '../../widgets/soft_image.dart';
import '../details/product_details_screen.dart';
import '../listing/listing_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _category = 0;
  static const List<String> _categories = [
    'All',
    'Sofa Sets',
    'Sectionals',
    'Recliners',
  ];

  void _openListing() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const ListingScreen()),
    );
  }

  void _openProduct(int index) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ProductDetailsScreen(product: AppData.catalogue[index]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                    onTap: _openListing,
                    child: const Icon(
                      Icons.notifications_none,
                      size: 18,
                      color: AppColors.inkSoft,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 26,
                    height: 26,
                    decoration: const BoxDecoration(
                      color: AppColors.creamDeep,
                      shape: BoxShape.circle,
                      border: Border.fromBorderSide(
                        BorderSide(color: AppColors.line),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'ZM',
                      style: AppText.serif(size: 9, weight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(18, 4, 18, 26),
                physics: const BouncingScrollPhysics(),
                children: [
                  _SearchBar(onTap: _openListing),
                  const SizedBox(height: 14),
                  const _HeroBanner(),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 34,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _categories.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 7),
                      itemBuilder: (context, i) => GhostPill(
                        label: _categories[i],
                        height: 32,
                        selected: _category == i,
                        icon: i == 0 ? Icons.grid_view_rounded : null,
                        onTap: () => setState(() => _category = i),
                        textStyle: AppText.sans(
                          size: 10.5,
                          weight: FontWeight.w500,
                          color: _category == i ? Colors.white : AppColors.inkSoft,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SectionHeading(
                    title: 'Featured Sofas',
                    subtitle:
                        'Signature collections designed for enduring comfort.',
                    actionLabel: 'View All',
                    onAction: _openListing,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ProductGridCard(
                          product: AppData.luna,
                          onTap: () => _openProduct(0),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ProductGridCard(
                          product: AppData.kavya,
                          onTap: () => _openProduct(1),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _WideFeatureCard(onTap: () => _openProduct(3)),
                  const SizedBox(height: 14),
                  const _TextilePromo(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 0),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 46,
        padding: const EdgeInsets.only(left: 14, right: 7),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.line),
        ),
        child: Row(
          children: [
            const Icon(Icons.search, size: 15, color: AppColors.muted),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Search for your perfect sofa',
                style: AppText.sans(size: 10.5, color: AppColors.muted),
              ),
            ),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.line),
              ),
              child: const Icon(Icons.tune, size: 14, color: AppColors.inkSoft),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroBanner extends StatelessWidget {
  const _HeroBanner();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        children: [
          Image.asset(
            'assets/images/hero_living.jpg',
            height: 244,
            width: double.infinity,
            fit: BoxFit.cover,
            alignment: const Alignment(0, 0.55),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.02),
                    Colors.black.withValues(alpha: 0.62),
                  ],
                  stops: const [0.35, 1],
                ),
              ),
            ),
          ),
          Positioned(
            left: 18,
            right: 18,
            bottom: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Crafted For Serenity',
                  style: AppText.serif(
                    size: 25,
                    weight: FontWeight.w400,
                    color: Colors.white,
                    height: 1.15,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Handcrafted sofas for slow living, made to order in our atelier.',
                  style: AppText.sans(
                    size: 9.5,
                    color: Colors.white.withValues(alpha: 0.82),
                  ),
                ),
                const SizedBox(height: 12),
                PrimaryPill(
                  label: 'Explore Collections',
                  trailing: Icons.arrow_forward,
                  height: 34,
                  fontSize: 10,
                  background: Colors.white,
                  foreground: AppColors.ink,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const ListingScreen()),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WideFeatureCard extends StatelessWidget {
  const _WideFeatureCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final product = AppData.odila;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.line),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SoftImage(
                  asset: product.image,
                  height: 168,
                  width: double.infinity,
                  radius: 13,
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.favorite_border,
                      size: 12,
                      color: AppColors.inkSoft,
                    ),
                  ),
                ),
                Positioned(
                  left: 8,
                  bottom: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                          'Modular',
                          style: AppText.sans(size: 7.5, color: AppColors.inkSoft),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 11, 8, 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Dot(size: 3.5, color: AppColors.accent),
                      const SizedBox(width: 5),
                      Text(
                        'NEW COLLECTION',
                        style: AppText.label(
                          size: 7.5,
                          color: AppColors.accent,
                          spacing: 0.8,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(product.name, style: AppText.serif(size: 19)),
                  const SizedBox(height: 4),
                  Text(
                    product.blurb,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppText.sans(
                      size: 9.5,
                      color: AppColors.mutedDark,
                      height: 1.45,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'FROM',
                            style: AppText.label(size: 7, spacing: 0.8),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '₹52,000',
                            style: AppText.sans(size: 16, weight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const Spacer(),
                      PrimaryPill(
                        label: 'Configure',
                        height: 32,
                        fontSize: 10,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        onTap: onTap,
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

class _TextilePromo extends StatelessWidget {
  const _TextilePromo();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.creamDeep,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'NEW ARRIVALS',
                style: AppText.label(
                  size: 7.5,
                  color: AppColors.accent,
                  spacing: 1,
                ),
              ),
              const Spacer(),
              GhostPill(
                label: 'Ideal for Textile',
                height: 24,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                background: Colors.white,
                borderColor: Colors.white,
                textStyle: AppText.sans(size: 8, color: AppColors.inkSoft),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text('Tactile Velvet Textures', style: AppText.serif(size: 21)),
          const SizedBox(height: 6),
          Text(
            'Explore the deep pile of hand-finished velvet and custom-ordered '
            'stain-resistant finishes.',
            style: AppText.sans(
              size: 9.5,
              color: AppColors.mutedDark,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              for (final color in const [
                AppColors.swatchTaupe,
                AppColors.swatchTeal,
                AppColors.swatchClay,
                AppColors.swatchSlate,
              ])
                Padding(
                  padding: const EdgeInsets.only(right: 7),
                  child: Container(
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                  ),
                ),
              const SizedBox(width: 2),
              Text(
                '+3 more',
                style: AppText.sans(size: 8, color: AppColors.muted),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Stack(
            children: [
              SoftImage(
                asset: 'assets/images/velvet_texture.jpg',
                height: 146,
                width: double.infinity,
                radius: 14,
              ),
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.35),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 14,
                bottom: 14,
                child: Text(
                  'SIGNATURE VELVET',
                  style: AppText.label(size: 7.5, color: Colors.white, spacing: 1),
                ),
              ),
              Positioned(
                right: 12,
                bottom: 12,
                child: PrimaryPill(
                  label: 'Discover',
                  height: 30,
                  fontSize: 9,
                  background: Colors.white,
                  foreground: AppColors.ink,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  onTap: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
