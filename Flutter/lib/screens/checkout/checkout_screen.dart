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
import '../confirmation/order_confirmation_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _location = 0;
  int _payment = 0;

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
              child: PageHeader(
                title: 'Checkout',
                trailing: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.line),
                  ),
                  child: const Icon(Icons.lock_outline, size: 13),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(18, 6, 18, 24),
                physics: const BouncingScrollPhysics(),
                children: [
                  const _CheckoutSteps(),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Text(
                        'Saved Locations',
                        style: AppText.sans(size: 12, weight: FontWeight.w600),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          '+ New address',
                          style: AppText.sans(
                            size: 9,
                            weight: FontWeight.w500,
                            color: AppColors.accent,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 9),
                  Row(
                    children: [
                      Expanded(
                        child: _LocationCard(
                          title: 'Home',
                          subtitle: 'Bandra West, Mumbai',
                          icon: Icons.home_outlined,
                          selected: _location == 0,
                          onTap: () => setState(() => _location = 0),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _LocationCard(
                          title: 'Office — BKC',
                          subtitle: 'BKC, Mumbai',
                          icon: Icons.business_outlined,
                          selected: _location == 1,
                          onTap: () => setState(() => _location = 1),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SectionCard(
                    padding: const EdgeInsets.fromLTRB(14, 13, 14, 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _CardHeading(
                          icon: Icons.person_outline,
                          title: 'Contact Information',
                          trailing: Icon(
                            Icons.keyboard_arrow_up,
                            size: 15,
                            color: AppColors.muted,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const _ReadField(label: 'Full Name', value: 'Zara Mehta'),
                        const SizedBox(height: 10),
                        const _ReadField(
                          label: 'Phone Number',
                          value: '98271 23456',
                          prefix: '+91',
                        ),
                        const SizedBox(height: 10),
                        const _ReadField(
                          label: 'Email Address',
                          value: 'zara.mehta@gmail.com',
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Order updates and delivery coordination are shared over '
                          'email and WhatsApp.',
                          style: AppText.sans(
                            size: 8,
                            color: AppColors.muted,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  SectionCard(
                    padding: const EdgeInsets.fromLTRB(14, 13, 14, 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _CardHeading(
                          icon: Icons.location_on_outlined,
                          title: 'Delivery Address',
                          trailing: Text(
                            'Change',
                            style: AppText.sans(
                              size: 8.5,
                              color: AppColors.accent,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const _ReadField(
                          label: 'House/Flat, Building, Street',
                          value: '402, Lotus Grande, 14th Road',
                        ),
                        const SizedBox(height: 10),
                        const _ReadField(
                          label: 'Landmark / Locality Area',
                          value: 'Near Joggers Park, Bandra West',
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Expanded(
                              child: _ReadField(label: 'City', value: 'Mumbai'),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _ReadField(
                                label: 'State',
                                value: 'Maharashtra',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Expanded(
                              flex: 3,
                              child: _ReadField(
                                label: 'PIN Code',
                                value: '400050',
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Expanded(
                              flex: 4,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: TinyBadge(
                                  label: 'Deliverable · White Glove',
                                  color: AppColors.sage,
                                  background: AppColors.sageSoft,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const _GloveNotice(),
                  const SizedBox(height: 10),
                  _CuratedOrder(cart: cart),
                  const SizedBox(height: 10),
                  _PaymentCard(
                    selected: _payment,
                    onSelect: (i) => setState(() => _payment = i),
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
            child: Material(
              color: AppColors.dark,
              borderRadius: BorderRadius.circular(28),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => const OrderConfirmationScreen(),
                  ),
                ),
                child: Container(
                  height: 54,
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.lock_outline,
                        size: 15,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'CONTINUE TO PAYMENT',
                              style: AppText.label(
                                size: 8.5,
                                color: Colors.white,
                                spacing: 1,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              'Encrypted checkout · ${inr(cart.total)}',
                              style: AppText.sans(
                                size: 8,
                                color: Colors.white.withValues(alpha: 0.65),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward,
                        size: 16,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CheckoutSteps extends StatelessWidget {
  const _CheckoutSteps();

  @override
  Widget build(BuildContext context) {
    const labels = ['Details', 'Delivery & Payment', 'Confirmation'];
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < labels.length; i++) ...[
          Column(
            children: [
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: i == 1 ? AppColors.dark : Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: i <= 1 ? AppColors.dark : AppColors.line,
                  ),
                ),
                child: Center(
                  child: i == 0
                      ? const Icon(Icons.check, size: 10, color: AppColors.ink)
                      : Text(
                          '${i + 1}',
                          style: AppText.sans(
                            size: 9,
                            weight: FontWeight.w600,
                            color: i == 1 ? Colors.white : AppColors.muted,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                labels[i],
                style: AppText.sans(
                  size: 8,
                  weight: i == 1 ? FontWeight.w600 : FontWeight.w400,
                  color: i == 1 ? AppColors.ink : AppColors.muted,
                ),
              ),
              const SizedBox(height: 3),
              Container(
                width: i == 1 ? 26 : 0,
                height: 2,
                color: AppColors.accent,
              ),
            ],
          ),
          if (i != labels.length - 1)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 4, right: 4),
                child: CustomPaint(
                  painter: _DashedPainter(color: AppColors.line, dash: 3, gap: 3),
                  child: const SizedBox(height: 2, width: double.infinity),
                ),
              ),
            ),
        ],
      ],
    );
  }
}

class _LocationCard extends StatelessWidget {
  const _LocationCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? AppColors.ink : AppColors.line,
            width: selected ? 1.2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 13, color: selected ? AppColors.ink : AppColors.muted),
            const SizedBox(width: 7),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppText.sans(size: 9.5, weight: FontWeight.w600),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppText.sans(size: 7.5, color: AppColors.muted),
                  ),
                ],
              ),
            ),
            if (selected)
              Container(
                width: 13,
                height: 13,
                decoration: const BoxDecoration(
                  color: AppColors.ink,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, size: 8, color: Colors.white),
              ),
          ],
        ),
      ),
    );
  }
}

class _CardHeading extends StatelessWidget {
  const _CardHeading({required this.icon, required this.title, this.trailing});

  final IconData icon;
  final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: const BoxDecoration(
            color: AppColors.creamDeep,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 12, color: AppColors.accent),
        ),
        const SizedBox(width: 8),
        Text(title, style: AppText.sans(size: 11.5, weight: FontWeight.w600)),
        const Spacer(),
        if (trailing != null) trailing!,
      ],
    );
  }
}

class _ReadField extends StatelessWidget {
  const _ReadField({required this.label, required this.value, this.prefix});

  final String label;
  final String value;
  final String? prefix;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppText.label(size: 7.5, spacing: 0.5)),
        const SizedBox(height: 4),
        Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 11),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.line),
          ),
          child: Row(
            children: [
              if (prefix != null) ...[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.creamDeep,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    prefix!,
                    style: AppText.sans(size: 8.5, weight: FontWeight.w500),
                  ),
                ),
                const SizedBox(width: 9),
              ],
              Expanded(
                child: Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.sans(size: 10, weight: FontWeight.w400),
                ),
              ),
              const Icon(
                Icons.edit_outlined,
                size: 11,
                color: AppColors.muted,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _GloveNotice extends StatelessWidget {
  const _GloveNotice();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.creamDeep,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: const BoxDecoration(
              color: AppColors.dark,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.local_shipping_outlined,
              size: 13,
              color: Colors.white,
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
                        'Complimentary White Glove Delivery',
                        style: AppText.sans(size: 10, weight: FontWeight.w600),
                      ),
                    ),
                    const TinyBadge(label: 'Included'),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Includes in-home placement, assembly, and packaging removal. '
                  'Scheduled by our senior installation team.',
                  style: AppText.sans(
                    size: 8,
                    color: AppColors.mutedDark,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(
                      Icons.verified_outlined,
                      size: 10,
                      color: AppColors.accent,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Included at checkout · no extra charge',
                      style: AppText.sans(
                        size: 8,
                        weight: FontWeight.w500,
                        color: AppColors.accent,
                      ),
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

class _CuratedOrder extends StatelessWidget {
  const _CuratedOrder({required this.cart});

  final CartProvider cart;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      padding: const EdgeInsets.fromLTRB(14, 13, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: AppColors.creamDeep,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.shopping_bag_outlined,
                  size: 12,
                  color: AppColors.accent,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Curated Order (${cart.itemCount} Items)',
                  style: AppText.sans(size: 11.5, weight: FontWeight.w600),
                ),
              ),
              Text(
                'Edit',
                style: AppText.sans(size: 8.5, color: AppColors.accent),
              ),
            ],
          ),
          const SizedBox(height: 10),
          for (final item in cart.items) ...[
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  SoftImage(
                    asset: item.product.image,
                    width: 40,
                    height: 40,
                    radius: 8,
                  ),
                  const SizedBox(width: 9),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.product.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppText.sans(
                            size: 10,
                            weight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 1),
                        Text(
                          '${item.product.fabric} · ${item.product.scale}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppText.sans(size: 7.5, color: AppColors.muted),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    inr(item.lineTotal),
                    style: AppText.sans(size: 10, weight: FontWeight.w500),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    width: 14,
                    height: 14,
                    decoration: const BoxDecoration(
                      color: AppColors.sageSoft,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.check, size: 8, color: AppColors.sage),
                  ),
                ],
              ),
            ),
          ],
          const Divider(height: 12),
          SummaryRow(
            label: 'Subtotal',
            value: inr(cart.subtotal),
            valueWeight: FontWeight.w600,
          ),
          const SummaryRow(
            label: 'White Glove Shipping & Assembly',
            value: 'FREE',
            valueColor: AppColors.sage,
            valueWeight: FontWeight.w600,
          ),
          const SummaryRow(
            label: 'GST & taxes (included)',
            value: 'Included',
            valueColor: AppColors.mutedDark,
          ),
          const Divider(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('Total Payable', style: AppText.serif(size: 15)),
              const Spacer(),
              Text(
                inr(cart.total),
                style: AppText.sans(size: 18, weight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PaymentCard extends StatelessWidget {
  const _PaymentCard({required this.selected, required this.onSelect});

  final int selected;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    const options = [
      ('UPI (Google Pay / PhonePe)', 'Instant · no verification wait', Icons.qr_code_2),
      ('Credit / Debit Card', 'Visa, Mastercard, RuPay', Icons.credit_card),
      ('Pay on Delivery (Select)', 'Select PIN codes only', Icons.payments_outlined),
    ];

    return SectionCard(
      padding: const EdgeInsets.fromLTRB(14, 13, 14, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: AppColors.goldSoft,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.account_balance_wallet_outlined,
                  size: 12,
                  color: AppColors.gold,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Payment Preference',
                style: AppText.sans(size: 11.5, weight: FontWeight.w600),
              ),
              const Spacer(),
              const TinyBadge(
                label: 'MOST TRUSTED',
                color: AppColors.gold,
                background: AppColors.goldSoft,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: AppColors.creamDeep,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              'Secure Checkout Mode — all transactions are processed via '
              'RBI-authorised gateways with 100% buyer protection.',
              style: AppText.sans(
                size: 7.5,
                color: AppColors.mutedDark,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 10),
          for (var i = 0; i < options.length; i++) ...[
            GestureDetector(
              onTap: () => onSelect(i),
              behavior: HitTestBehavior.opaque,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: selected == i ? AppColors.ink : AppColors.line,
                    width: selected == i ? 1.3 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: selected == i ? AppColors.ink : AppColors.line,
                          width: 1.2,
                        ),
                      ),
                      child: Center(
                        child: Container(
                          width: 7,
                          height: 7,
                          decoration: BoxDecoration(
                            color: selected == i
                                ? AppColors.ink
                                : Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 9),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            options[i].$1,
                            style: AppText.sans(
                              size: 9.5,
                              weight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 1),
                          Text(
                            options[i].$2,
                            style: AppText.sans(
                              size: 7.5,
                              color: AppColors.muted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(options[i].$3, size: 13, color: AppColors.mutedDark),
                  ],
                ),
              ),
            ),
            if (i != options.length - 1) const SizedBox(height: 7),
          ],
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.lock_outline, size: 10, color: AppColors.muted),
              const SizedBox(width: 4),
              Text(
                '256-bit SSL encrypted',
                style: AppText.sans(size: 7.5, color: AppColors.muted),
              ),
              const Spacer(),
              Text(
                'Secured by SOFALIVING',
                style: AppText.sans(size: 7.5, color: AppColors.muted),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DashedPainter extends CustomPainter {
  const _DashedPainter({required this.color, this.dash = 4, this.gap = 3});

  final Color color;
  final double dash;
  final double gap;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;
    double x = 0;
    while (x < size.width) {
      canvas.drawLine(Offset(x, 1), Offset(x + dash, 1), paint);
      x += dash + gap;
    }
  }

  @override
  bool shouldRepaint(covariant _DashedPainter oldDelegate) =>
      oldDelegate.color != color;
}
