import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';
import '../../providers/cart_provider.dart';
import '../../providers/customiser_provider.dart';
import '../../providers/wishlist_provider.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text.dart';
import '../../utils/format.dart';
import '../../widgets/app_header.dart';
import '../../widgets/pill.dart';
import '../../widgets/quantity_stepper.dart';
import '../../widgets/section_card.dart';
import '../../widgets/soft_image.dart';
import '../cart/cart_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.product});

  final Product product;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final PageController _pageController = PageController();
  int _page = 0;
  int _expanded = -1;

  List<String> get _gallery => [
    widget.product.image,
    'assets/images/detail_hero.jpg',
    'assets/images/living_grey.jpg',
    'assets/images/studio_sofa.jpg',
    'assets/images/luna_cloud.jpg',
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final customiser = context.watch<CustomiserProvider>();
    final wishlist = context.watch<WishlistProvider>();
    final cart = context.read<CartProvider>();
    final saved = wishlist.isSaved(widget.product);

    final int total = (widget.product.price + customiser.uplift) * customiser.quantity;

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: BrandHeader(
                onBack: () => Navigator.of(context).maybePop(),
                trailing: [
                  GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      Icons.ios_share,
                      size: 17,
                      color: AppColors.inkSoft,
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () => wishlist.toggle(widget.product),
                    child: Icon(
                      saved ? Icons.favorite : Icons.favorite_border,
                      size: 17,
                      color: saved ? AppColors.accent : AppColors.inkSoft,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 22),
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 6, 18, 0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 268,
                          child: Stack(
                            children: [
                              PageView.builder(
                                controller: _pageController,
                                itemCount: _gallery.length,
                                onPageChanged: (i) => setState(() => _page = i),
                                itemBuilder: (context, i) => SoftImage(
                                  asset: _gallery[i],
                                  width: double.infinity,
                                  radius: 18,
                                ),
                              ),
                              Positioned(
                                left: 11,
                                top: 11,
                                child: _GlassPill(
                                  icon: Icons.inventory_2_outlined,
                                  label: '12 in stock',
                                ),
                              ),
                              Positioned(
                                right: 11,
                                top: 11,
                                child: _GlassPill(
                                  icon: Icons.star,
                                  label: '4.8 (2.1k)',
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (var i = 0; i < _gallery.length; i++) ...[
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                width: i == _page ? 18 : 5,
                                height: 4,
                                decoration: BoxDecoration(
                                  color: i == _page
                                      ? AppColors.ink
                                      : AppColors.line,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              if (i != _gallery.length - 1) const SizedBox(width: 4),
                            ],
                          ],
                        ),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            const Dot(size: 5),
                            const SizedBox(width: 5),
                            Text(
                              '4.8 (240 reviews)',
                              style: AppText.sans(
                                size: 9,
                                weight: FontWeight.w500,
                              ),
                            ),
                            const Spacer(),
                            const Dot(size: 4, color: AppColors.sage),
                            const SizedBox(width: 5),
                            Text(
                              'In Stock · ${widget.product.leadTime}',
                              style: AppText.sans(
                                size: 8.5,
                                color: AppColors.mutedDark,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.product.name,
                            style: AppText.serif(size: 27, height: 1.15),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Text(
                              inr(widget.product.price),
                              style: AppText.sans(
                                size: 16,
                                weight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 7),
                            Text(
                              inr(widget.product.mrp),
                              style: AppText.sans(
                                size: 10,
                                color: AppColors.muted,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const TinyBadge(label: 'Bespoke'),
                          ],
                        ),
                        const SizedBox(height: 9),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Sculpted low-profile seating in a cloud-soft, ergonomic '
                            'build. Luna is upholstered in a high-resilience linen '
                            'blend and sits on a hand-finished oak base — made to '
                            'order, piece by piece.',
                            style: AppText.sans(
                              size: 10,
                              color: AppColors.mutedDark,
                              height: 1.62,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _SubHeader(
                          title: 'Calico Palette',
                          action: 'Reset Design',
                          onAction: () {
                            context.read<CustomiserProvider>().reset();
                          },
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            for (var i = 0; i < CustomiserProvider.palette.length; i++)
                              Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: GestureDetector(
                                  onTap: () => customiser.selectPalette(i),
                                  child: Container(
                                    width: 38,
                                    height: 38,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: customiser.paletteIndex == i
                                            ? AppColors.ink
                                            : Colors.transparent,
                                        width: 1.4,
                                      ),
                                    ),
                                    child: Center(
                                      child: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: CustomiserProvider.palette[i],
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 1.5,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        _SubHeader(title: 'Material Fabric', action: 'Swipe to compare'),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            for (var i = 0; i < CustomiserProvider.fabrics.length; i++) ...[
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => customiser.selectFabric(i),
                                  child: _OptionBox(
                                    title: CustomiserProvider.fabrics[i],
                                    subtitle: CustomiserProvider.fabricUplift[i] == 0
                                        ? 'Included'
                                        : '+${inr(CustomiserProvider.fabricUplift[i])}',
                                    selected: customiser.fabricIndex == i,
                                    icon: i == 0
                                        ? Icons.texture
                                        : (i == 1 ? Icons.blur_on : Icons.layers_outlined),
                                  ),
                                ),
                              ),
                              if (i != CustomiserProvider.fabrics.length - 1)
                                const SizedBox(width: 8),
                            ],
                          ],
                        ),
                        const SizedBox(height: 18),
                        _SubHeader(
                          title: 'Configuration & Scale',
                          action: 'Measure Check',
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            for (var i = 0; i < CustomiserProvider.scales.length; i++) ...[
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => customiser.selectScale(i),
                                  child: _OptionBox(
                                    title: CustomiserProvider.scales[i],
                                    subtitle: i == 0 ? 'Family' : (i == 1 ? 'Pair' : 'Studio'),
                                    selected: customiser.scaleIndex == i,
                                    height: 58,
                                    showCheck: customiser.scaleIndex == i,
                                  ),
                                ),
                              ),
                              if (i != CustomiserProvider.scales.length - 1)
                                const SizedBox(width: 8),
                            ],
                          ],
                        ),
                        const SizedBox(height: 16),
                        SectionCard(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Quantity',
                                      style: AppText.sans(
                                        size: 12,
                                        weight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      'Crafted to order for each home',
                                      style: AppText.sans(
                                        size: 8.5,
                                        color: AppColors.muted,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              QuantityStepper(
                                value: customiser.quantity,
                                onDecrement: customiser.decrement,
                                onIncrement: customiser.increment,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        _Accordion(
                          title: 'Dimensions & Specifications',
                          icon: Icons.straighten,
                          expanded: _expanded == 0,
                          onTap: () => setState(() => _expanded = _expanded == 0 ? -1 : 0),
                          body: 'Width 224 cm · Depth 96 cm · Height 78 cm\n'
                              'Seat height 42 cm · Solid oak frame · '
                              'High-resilience foam with feather wrap.',
                        ),
                        const SizedBox(height: 8),
                        _Accordion(
                          title: 'Care & Maintenance',
                          icon: Icons.spa_outlined,
                          expanded: _expanded == 1,
                          onTap: () => setState(() => _expanded = _expanded == 1 ? -1 : 1),
                          body: 'Vacuum monthly with a soft brush attachment. '
                              'Professional dry clean recommended once a year. '
                              'Keep out of direct sunlight to protect the weave.',
                        ),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            const Expanded(
                              child: _TrustTile(
                                icon: Icons.verified_outlined,
                                title: '10-Yr Frame',
                                subtitle: 'Warranty',
                              ),
                            ),
                            SizedBox(width: 8),
                            const Expanded(
                              child: _TrustTile(
                                icon: Icons.local_shipping_outlined,
                                title: 'White Glove',
                                subtitle: 'Delivery',
                              ),
                            ),
                            SizedBox(width: 8),
                            const Expanded(
                              child: _TrustTile(
                                icon: Icons.workspace_premium_outlined,
                                title: '100%',
                                subtitle: 'Authentic',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: AppColors.lineSoft)),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 10, 18, 10),
            child: Row(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total', style: AppText.label(size: 8)),
                    const SizedBox(height: 2),
                    Text(
                      inr(total),
                      style: AppText.sans(size: 16, weight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: PrimaryPill(
                    label: 'ADD TO CART · ${inr(total)}',
                    icon: Icons.shopping_bag_outlined,
                    height: 46,
                    expand: true,
                    onTap: () {
                      cart.add(
                        widget.product,
                        quantity: customiser.quantity,
                        finish: 'Calico ${customiser.paletteIndex + 1}',
                        spec:
                            '${customiser.selectedScale} · ${customiser.selectedFabric} · Hand Finished',
                      );
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const CartScreen()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GlassPill extends StatelessWidget {
  const _GlassPill({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 10, color: AppColors.inkSoft),
          const SizedBox(width: 4),
          Text(
            label,
            style: AppText.sans(size: 8.5, weight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

class _SubHeader extends StatelessWidget {
  const _SubHeader({required this.title, this.action, this.onAction});

  final String title;
  final String? action;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: AppText.sans(size: 12, weight: FontWeight.w600)),
        const Spacer(),
        if (action != null)
          GestureDetector(
            onTap: onAction,
            behavior: HitTestBehavior.opaque,
            child: Text(
              action!,
              style: AppText.sans(
                size: 9,
                weight: FontWeight.w500,
                color: AppColors.accent,
              ),
            ),
          ),
      ],
    );
  }
}

class _OptionBox extends StatelessWidget {
  const _OptionBox({
    required this.title,
    required this.subtitle,
    required this.selected,
    this.icon,
    this.height = 64,
    this.showCheck = false,
  });

  final String title;
  final String subtitle;
  final bool selected;
  final IconData? icon;
  final double height;
  final bool showCheck;

  @override
  Widget build(BuildContext context) {
    final Color fg = selected ? Colors.white : AppColors.ink;
    final Color sub = selected ? Colors.white70 : AppColors.mutedDark;
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: selected ? AppColors.dark : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: selected ? AppColors.dark : AppColors.line),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 13, color: fg),
            const SizedBox(height: 4),
          ],
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.sans(size: 9.5, weight: FontWeight.w500, color: fg),
                ),
              ),
              if (showCheck) ...[
                const SizedBox(width: 3),
                Icon(Icons.check, size: 9, color: AppColors.accent),
              ],
            ],
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppText.sans(
              size: 7.5,
              color: selected ? sub : AppColors.accent,
            ),
          ),
        ],
      ),
    );
  }
}

class _Accordion extends StatelessWidget {
  const _Accordion({
    required this.title,
    required this.icon,
    required this.expanded,
    required this.onTap,
    required this.body,
  });

  final String title;
  final IconData icon;
  final bool expanded;
  final VoidCallback onTap;
  final String body;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          border: Border.all(color: AppColors.line),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 14, color: AppColors.mutedDark),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: AppText.sans(size: 10.5, weight: FontWeight.w500),
                ),
                const Spacer(),
                Icon(
                  expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  size: 15,
                  color: AppColors.muted,
                ),
              ],
            ),
            if (expanded) ...[
              const SizedBox(height: 9),
              Text(
                body,
                style: AppText.sans(
                  size: 9.5,
                  color: AppColors.mutedDark,
                  height: 1.6,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _TrustTile extends StatelessWidget {
  const _TrustTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.line),
      ),
      child: Column(
        children: [
          Icon(icon, size: 15, color: AppColors.accent),
          const SizedBox(height: 6),
          Text(
            title,
            style: AppText.sans(size: 8.5, weight: FontWeight.w600),
          ),
          const SizedBox(height: 1),
          Text(
            subtitle,
            style: AppText.sans(size: 7.5, color: AppColors.muted),
          ),
        ],
      ),
    );
  }
}
