import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text.dart';

/// Label/value row used in order summaries on the bag, checkout and
/// confirmation screens.
class SummaryRow extends StatelessWidget {
  const SummaryRow({
    super.key,
    required this.label,
    required this.value,
    this.valueColor = AppColors.ink,
    this.valueWeight = FontWeight.w500,
    this.strikethrough = false,
    this.badge,
    this.padding = const EdgeInsets.symmetric(vertical: 6),
  });

  final String label;
  final String value;
  final Color valueColor;
  final FontWeight valueWeight;
  final bool strikethrough;
  final Widget? badge;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: AppText.sans(size: 10, color: AppColors.mutedDark),
            ),
          ),
          if (strikethrough)
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Text(
                value,
                style: AppText.sans(
                  size: 9.5,
                  color: AppColors.muted,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ),
          if (!strikethrough)
            Text(
              value,
              style: AppText.sans(
                size: 10,
                weight: valueWeight,
                color: valueColor,
              ),
            ),
          if (badge != null) ...[
            const SizedBox(width: 6),
            badge!,
          ],
        ],
      ),
    );
  }
}
