import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text.dart';

class SectionHeading extends StatelessWidget {
  const SectionHeading({
    super.key,
    required this.title,
    this.subtitle,
    this.actionLabel,
    this.actionIcon = Icons.arrow_forward,
    this.onAction,
    this.titleSize = 17,
    this.padding = EdgeInsets.zero,
  });

  final String title;
  final String? subtitle;
  final String? actionLabel;
  final IconData actionIcon;
  final VoidCallback? onAction;
  final double titleSize;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppText.serif(size: titleSize, height: 1.2),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 3),
                  Text(
                    subtitle!,
                    style: AppText.sans(
                      size: 10,
                      color: AppColors.mutedDark,
                      height: 1.35,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (actionLabel != null)
            GestureDetector(
              onTap: onAction,
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.only(left: 8, top: 3),
                child: Row(
                  children: [
                    Text(
                      actionLabel!.toUpperCase(),
                      style: AppText.label(
                        size: 8.5,
                        color: AppColors.accent,
                        spacing: 0.9,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(actionIcon, size: 11, color: AppColors.accent),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
