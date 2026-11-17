import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/cart_provider.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text.dart';
import '../../utils/format.dart';
import '../../widgets/app_header.dart';
import '../../widgets/pill.dart';
import '../../widgets/section_card.dart';
import '../../widgets/soft_image.dart';
import '../../widgets/summary_row.dart';

class OrderConfirmationScreen extends StatelessWidget {
  const OrderConfirmationScreen({super.key});

  static const _steps = [
    ('Order Placed', 'Confirmed', 0),
    ('Master Workshop', 'In Progress', 1),
    ('Quality Assurance', 'Customising', 2),
    ('White Glove Delivery', 'Preparing', 3),
  ];

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
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: BrandHeader(
                leadingDot: true,
                trailing: [
                  GestureDetector(
                    onTap: () =>
                        Navigator.of(context).popUntil((route) => route.isFirst),
                    child: const Icon(Icons.close, size: 17),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(18, 6, 18, 26),
                physics: const BouncingScrollPhysics(),
                children: [
                  SectionCard(
                    padding: const EdgeInsets.fromLTRB(18, 22, 18, 16),
                    child: Column(
                      children: [
                        SizedBox(
                          width: 74,
                          height: 64,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: const BoxDecoration(
                                  color: AppColors.creamDeep,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Container(
                                width: 26,
                                height: 26,
                                decoration: const BoxDecoration(
                                  color: AppColors.accent,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.check,
                                  size: 14,
                                  color: Colors.white,
                                ),
                              ),
                              Positioned(
                                right: 8,
                                bottom: 2,
                                child: Container(
                                  width: 10,
                                  height: 10,
                                  decoration: const BoxDecoration(
                                    color: AppColors.dark,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Order Placed Successfully!',
                          textAlign: TextAlign.center,
                          style: AppText.serif(size: 23, height: 1.2),
                        ),
                        const SizedBox(height: 7),
                        Text(
                          'Thank you, Zara. Your bespoke pieces are now being '
                          'handcrafted in our atelier.',
                          textAlign: TextAlign.center,
                          style: AppText.sans(
                            size: 9.5,
                            color: AppColors.mutedDark,
                            height: 1.55,
                          ),
                        ),
                        const SizedBox(height: 13),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 9,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.creamDeep,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'ORDER # · 2554-89201',
                                style: AppText.label(size: 8, spacing: 0.9),
                              ),
                              const SizedBox(width: 6),
                              const Icon(
                                Icons.copy,
                                size: 10,
                                color: AppColors.mutedDark,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Divider(height: 1),
                        const SizedBox(height: 13),
                        Row(
                          children: [
                            Container(
                              width: 26,
                              height: 26,
                              decoration: const BoxDecoration(
                                color: AppColors.creamDeep,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.schedule,
                                size: 12,
                                color: AppColors.accent,
                              ),
                            ),
                            const SizedBox(width: 9),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'ESTIMATED DELIVERY',
                                    style: AppText.label(size: 7, spacing: 1),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'October 28 – 30, 2025',
                                    style: AppText.sans(
                                      size: 10.5,
                                      weight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const TinyBadge(label: 'Priority White Glove'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  SectionCard(
                    padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Craftsmanship Journey',
                              style: AppText.serif(size: 16),
                            ),
                            const Spacer(),
                            Text(
                              'VIEW DETAILS',
                              style: AppText.label(
                                size: 7.5,
                                color: AppColors.accent,
                                spacing: 0.8,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var i = 0; i < _steps.length; i++) ...[
                              Expanded(
                                child: Column(
                                  children: [
                                    _JourneyNode(index: i),
                                    const SizedBox(height: 7),
                                    Text(
                                      _steps[i].$1,
                                      textAlign: TextAlign.center,
                                      style: AppText.sans(
                                        size: 7.5,
                                        weight: i == 0
                                            ? FontWeight.w600
                                            : FontWeight.w400,
                                        height: 1.35,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      _steps[i].$2,
                                      textAlign: TextAlign.center,
                                      style: AppText.sans(
                                        size: 7,
                                        color: i == 0
                                            ? AppColors.sage
                                            : (i == 1
                                                ? AppColors.accent
                                                : AppColors.muted),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (i != _steps.length - 1)
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 11),
                                    child: CustomPaint(
                                      painter: _DashedLine(
                                        color: i == 0
                                            ? AppColors.muted
                                            : AppColors.line,
                                      ),
                                      child: const SizedBox(
                                        height: 1,
                                        width: double.infinity,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  SectionCard(
                    padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('Order Details', style: AppText.serif(size: 16)),
                            const Spacer(),
                            GhostPill(
                              label: 'View all Items',
                              height: 24,
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              textStyle: AppText.sans(
                                size: 7.5,
                                color: AppColors.inkSoft,
                              ),
                              onTap: () {},
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        for (final item in cart.items) ...[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                SoftImage(
                                  asset: item.product.image,
                                  width: 54,
                                  height: 54,
                                  radius: 9,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              item.product.name,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: AppText.sans(
                                                size: 10,
                                                weight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            inr(item.lineTotal),
                                            style: AppText.sans(
                                              size: 10,
                                              weight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 2),
                                      Row(
                                        children: [
                                          Text(
                                            '${item.product.scale} · ${item.product.fabric}',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: AppText.sans(
                                              size: 7.5,
                                              color: AppColors.muted,
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            inr(item.product.mrp),
                                            style: AppText.sans(
                                              size: 7,
                                              color: AppColors.muted,
                                              decoration:
                                                  TextDecoration.lineThrough,
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
                        const SizedBox(height: 4),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              size: 12,
                              color: AppColors.mutedDark,
                            ),
                            const SizedBox(width: 7),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'WHITE GLOVE DELIVERY ADDRESS',
                                    style: AppText.label(size: 6.5, spacing: 0.9),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    '402, Lotus Grande, 14th Road,\n'
                                    'Bandra West, Mumbai 400050',
                                    style: AppText.sans(
                                      size: 8.5,
                                      color: AppColors.mutedDark,
                                      height: 1.5,
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    'Recipient · Zara Mehta · +91 98271 23456',
                                    style: AppText.sans(
                                      size: 8,
                                      color: AppColors.accent,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.creamDeep,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.credit_card,
                                size: 14,
                                color: AppColors.mutedDark,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'PAYMENT METHOD',
                                      style: AppText.label(size: 6.5, spacing: 0.9),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      'UPI · phone reference #4PH-90210',
                                      style: AppText.sans(size: 8.5, weight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              const TinyBadge(
                                label: 'PAID',
                                color: AppColors.sage,
                                background: AppColors.sageSoft,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        SummaryRow(
                          label: 'Subtotal',
                          value: inr(cart.subtotal),
                        ),
                        const SummaryRow(
                          label: 'White Glove Delivery & Assembly',
                          value: 'Complementary',
                          valueColor: AppColors.accent,
                        ),
                        const SummaryRow(
                          label: 'Craftsmanship Insurance',
                          value: 'Included',
                          valueColor: AppColors.mutedDark,
                        ),
                        const Divider(height: 18),
                        Row(
                          children: [
                            Text(
                              'Total Paid',
                              style: AppText.sans(
                                size: 12,
                                weight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              inr(cart.total),
                              style: AppText.sans(
                                size: 20,
                                weight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(13),
                    decoration: BoxDecoration(
                      color: AppColors.creamDeep,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'S',
                            style: AppText.serif(size: 12, weight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Personal Atelier Concierge',
                                style: AppText.sans(
                                  size: 10,
                                  weight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                'Questions about your commission? Speak with your '
                                'dedicated design specialist — available until 10 PM.',
                                style: AppText.sans(
                                  size: 8,
                                  color: AppColors.mutedDark,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.chevron_right,
                          size: 16,
                          color: AppColors.muted,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  GhostPill(
                    label: 'Track Order Status',
                    icon: Icons.local_shipping_outlined,
                    height: 46,
                    padding: EdgeInsets.zero,
                    background: Colors.white,
                    onTap: () {},
                    textStyle: AppText.sans(
                      size: 10.5,
                      weight: FontWeight.w500,
                      color: AppColors.ink,
                    ),
                  ),
                  const SizedBox(height: 10),
                  PrimaryPill(
                    label: 'Continue Shopping',
                    trailing: Icons.arrow_forward,
                    height: 50,
                    expand: true,
                    onTap: () =>
                        Navigator.of(context).popUntil((route) => route.isFirst),
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

class _JourneyNode extends StatelessWidget {
  const _JourneyNode({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    if (index == 0) {
      return Container(
        width: 23,
        height: 23,
        decoration: const BoxDecoration(
          color: AppColors.dark,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.check, size: 11, color: Colors.white),
      );
    }
    if (index == 1) {
      return Container(
        width: 23,
        height: 23,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.accent, width: 1.4),
        ),
        child: const Icon(Icons.schedule, size: 11, color: AppColors.accent),
      );
    }
    return Container(
      width: 23,
      height: 23,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.line),
      ),
      child: Center(
        child: Container(
          width: 5,
          height: 5,
          decoration: const BoxDecoration(
            color: AppColors.line,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}

class _DashedLine extends CustomPainter {
  const _DashedLine({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;
    double x = 0;
    while (x < size.width) {
      canvas.drawLine(Offset(x, 0.5), Offset(x + 3, 0.5), paint);
      x += 6;
    }
  }

  @override
  bool shouldRepaint(covariant _DashedLine oldDelegate) =>
      oldDelegate.color != color;
}
