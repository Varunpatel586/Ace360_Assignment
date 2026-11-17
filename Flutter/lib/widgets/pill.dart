import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text.dart';

/// Filled, fully-rounded primary action — the dark button used throughout.
class PrimaryPill extends StatelessWidget {
  const PrimaryPill({
    super.key,
    required this.label,
    this.onTap,
    this.icon,
    this.trailing,
    this.expand = false,
    this.height = 48,
    this.background = AppColors.dark,
    this.foreground = Colors.white,
    this.fontSize = 12,
    this.padding = const EdgeInsets.symmetric(horizontal: 20),
  });

  final String label;
  final VoidCallback? onTap;
  final IconData? icon;
  final IconData? trailing;
  final bool expand;
  final double height;
  final Color background;
  final Color foreground;
  final double fontSize;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final content = Row(
      mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 14, color: foreground),
          const SizedBox(width: 7),
        ],
        Flexible(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppText.sans(
              size: fontSize,
              weight: FontWeight.w500,
              color: foreground,
              spacing: 0.2,
            ),
          ),
        ),
        if (trailing != null) ...[
          const SizedBox(width: 8),
          Icon(trailing, size: 14, color: foreground),
        ],
      ],
    );

    return Material(
      color: background,
      shape: const StadiumBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: height,
          padding: padding,
          child: content,
        ),
      ),
    );
  }
}

/// Hairline-bordered pill used for secondary actions and filter chips.
class GhostPill extends StatelessWidget {
  const GhostPill({
    super.key,
    required this.label,
    this.onTap,
    this.icon,
    this.trailing,
    this.selected = false,
    this.height = 34,
    this.padding = const EdgeInsets.symmetric(horizontal: 14),
    this.textStyle,
    this.background,
    this.borderColor,
  });

  final String label;
  final VoidCallback? onTap;
  final IconData? icon;
  final IconData? trailing;
  final bool selected;
  final double height;
  final EdgeInsetsGeometry padding;
  final TextStyle? textStyle;
  final Color? background;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final Color fg = selected ? Colors.white : AppColors.inkSoft;
    return Material(
      color: selected ? AppColors.dark : (background ?? Colors.transparent),
      shape: StadiumBorder(
        side: BorderSide(
          color: selected
              ? AppColors.dark
              : (borderColor ?? AppColors.line),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: height,
          padding: padding,
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 12, color: fg),
                const SizedBox(width: 6),
              ],
              Text(
                label,
                maxLines: 1,
                style: textStyle ??
                    AppText.sans(
                      size: 10.5,
                      weight: FontWeight.w500,
                      color: fg,
                    ),
              ),
              if (trailing != null) ...[
                const SizedBox(width: 6),
                Icon(trailing, size: 12, color: fg),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Tiny uppercase status badge, e.g. INCLUDED / PAID / IN STOCK.
class TinyBadge extends StatelessWidget {
  const TinyBadge({
    super.key,
    required this.label,
    this.color = AppColors.accent,
    this.background = AppColors.accentSoft,
    this.icon,
  });

  final String label;
  final Color color;
  final Color background;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 9, color: color),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: AppText.label(size: 8, color: color, spacing: 0.8),
          ),
        ],
      ),
    );
  }
}

/// Small numbered/labelled dot separator used in metadata rows.
class Dot extends StatelessWidget {
  const Dot({super.key, this.color = AppColors.accent, this.size = 4});
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
