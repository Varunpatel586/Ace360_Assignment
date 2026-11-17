import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/cart_item.dart';
import '../../providers/cart_provider.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text.dart';
import '../../utils/format.dart';
import '../../widgets/app_bottom_nav.dart';
import '../../widgets/pill.dart';
import '../../widgets/quantity_stepper.dart';
import '../../widgets/section_card.dart';
import '../../widgets/soft_image.dart';
import '../../widgets/summary_row.dart';
import '../checkout/checkout_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final TextEditingController _couponController =
      TextEditingController(text: 'SOFAPREST');

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 2, 18, 4),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).maybePop(),
                    behavior: HitTestBehavior.opaque,
                    child: const SizedBox(
                      width: 32,
                      height: 32,
                      child: Icon(Icons.arrow_back, size: 17),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Shopping Bag (${cart.itemCount} ${cart.itemCount == 1 ? 'Item' : 'Items'})',
                    style: AppText.sans(size: 14, weight: FontWeight.w600),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.line),
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.lock_outline,
                          size: 9,
                          color: AppColors.mutedDark,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'SECURE',
                          style: AppText.label(size: 7.5, spacing: 0.8),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(18, 8, 18, 22),
                physics: const BouncingScrollPhysics(),
                children: [
                  Row(
                    children: [
                      Text(
                        'BESPOKE ATELIER ORDER',
                        style: AppText.label(size: 7.5, spacing: 1),
                      ),
                      const Spacer(),
                      const Dot(size: 4, color: AppColors.sage),
                      const SizedBox(width: 4),
                      Text(
                        'Handcrafted in our studio',
                        style: AppText.sans(size: 8, color: AppColors.sage),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  if (cart.isEmpty)
                    _EmptyBag()
                  else
                    for (final item in cart.items) ...[
                      _CartItemCard(item: item),
                      const SizedBox(height: 10),
                    ],
                  const SizedBox(height: 2),
                  const _WhiteGloveBanner(),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 44,
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.line),
                          ),
                          child: TextField(
                            controller: _couponController,
                            style: AppText.sans(
                              size: 11,
                              weight: FontWeight.w500,
                              spacing: 0.4,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              filled: false,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                              hintText: 'Coupon code',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      PrimaryPill(
                        label: 'Apply',
                        height: 44,
                        fontSize: 11,
                        padding: const EdgeInsets.symmetric(horizontal: 22),
                        onTap: () => cart.applyCoupon(_couponController.text),
                      ),
                    ],
                  ),
                  if (cart.couponApplied) ...[
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.accentTint,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.accentSoft),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.local_offer_outlined,
                            size: 12,
                            color: AppColors.accent,
                          ),
                          const SizedBox(width: 7),
                          Expanded(
                            child: Text(
                              '${cart.coupon} · ₹5,000 applied',
                              style: AppText.sans(
                                size: 9.5,
                                weight: FontWeight.w500,
                                color: AppColors.accent,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: cart.removeCoupon,
                            child: const Icon(
                              Icons.delete_outline,
                              size: 13,
                              color: AppColors.accent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                  SectionCard(
                    padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Order Summary', style: AppText.serif(size: 16)),
                        const SizedBox(height: 8),
                        SummaryRow(label: 'Subtotal', value: inr(cart.subtotal)),
                        SummaryRow(
                          label: 'Polished & Custom Crafting',
                          value: 'Included',
                          valueWeight: FontWeight.w600,
                        ),
                        SummaryRow(
                          label: 'White Glove Delivery & Assembly',
                          value: '₹2,000',
                          strikethrough: true,
                          badge: const TinyBadge(
                            label: 'FREE',
                            color: AppColors.sage,
                            background: AppColors.sageSoft,
                          ),
                        ),
                        SummaryRow(
                          label: 'Promotional Discount (${cart.coupon})',
                          value: cart.discount == 0 ? '—' : '-${inr(cart.discount)}',
                          valueColor: AppColors.accent,
                        ),
                        const Divider(height: 20),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Estimated Total',
                                  style: AppText.sans(
                                    size: 11,
                                    weight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Inclusive of all taxes & GST',
                                  style: AppText.sans(
                                    size: 8,
                                    color: AppColors.muted,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Text(
                              inr(cart.total),
                              style: AppText.serif(size: 22, height: 1),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  PrimaryPill(
                    label: 'PROCEED TO CHECKOUT · ${inr(cart.total)}',
                    trailing: Icons.arrow_forward,
                    height: 50,
                    expand: true,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const CheckoutScreen()),
                    ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () => Navigator.of(context).popUntil(
                      (route) => route.isFirst,
                    ),
                    behavior: HitTestBehavior.opaque,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.arrow_back,
                          size: 11,
                          color: AppColors.mutedDark,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'CONTINUE SHOPPING',
                          style: AppText.label(
                            size: 8,
                            color: AppColors.mutedDark,
                            spacing: 1,
                          ),
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
      bottomNavigationBar: const AppBottomNav(currentIndex: 3),
    );
  }
}

class _CartItemCard extends StatelessWidget {
  const _CartItemCard({required this.item});

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    final cart = context.read<CartProvider>();
    return Container(
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
                asset: item.product.image,
                width: 78,
                height: 82,
                radius: 11,
              ),
              Positioned(
                left: 4,
                bottom: 4,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.94),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    item.finish,
                    style: AppText.sans(size: 6.5, color: AppColors.inkSoft),
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
                        item.product.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppText.serif(size: 15),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => cart.remove(item),
                      child: const Padding(
                        padding: EdgeInsets.only(left: 4, top: 2),
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
                  item.spec,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.sans(
                    size: 8,
                    color: AppColors.mutedDark,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      inr(item.product.price),
                      style: AppText.sans(size: 13, weight: FontWeight.w600),
                    ),
                    const Spacer(),
                    QuantityStepper(
                      value: item.quantity,
                      width: 82,
                      height: 28,
                      onDecrement: () => cart.decrement(item),
                      onIncrement: () => cart.increment(item),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WhiteGloveBanner extends StatelessWidget {
  const _WhiteGloveBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.creamDeep,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.line),
                ),
                child: const Icon(
                  Icons.local_shipping_outlined,
                  size: 13,
                  color: AppColors.accent,
                ),
              ),
              const SizedBox(width: 9),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Complimentary White Glove',
                            style: AppText.label(
                              size: 8,
                              color: AppColors.ink,
                              spacing: 0.7,
                            ),
                          ),
                        ),
                        const TinyBadge(label: 'INCLUDED', color: AppColors.accent),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'White Glove Delivery, in-home assembly, and full packaging '
                      'removal. Handled by our senior installers.',
                      style: AppText.sans(
                        size: 8,
                        color: AppColors.mutedDark,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const SizedBox(width: 34),
              const Icon(
                Icons.access_time,
                size: 10,
                color: AppColors.mutedDark,
              ),
              const SizedBox(width: 5),
              Text(
                'Scheduled Delivery · 12–14 business days',
                style: AppText.sans(size: 8, color: AppColors.mutedDark),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _EmptyBag extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SectionCard(
      padding: const EdgeInsets.symmetric(vertical: 36),
      child: Column(
        children: [
          const Icon(
            Icons.shopping_bag_outlined,
            size: 28,
            color: AppColors.muted,
          ),
          const SizedBox(height: 10),
          Text('Your bag is empty', style: AppText.serif(size: 17)),
          const SizedBox(height: 4),
          Text(
            'Add a handcrafted piece to begin.',
            style: AppText.sans(size: 9.5, color: AppColors.muted),
          ),
        ],
      ),
    );
  }
}
