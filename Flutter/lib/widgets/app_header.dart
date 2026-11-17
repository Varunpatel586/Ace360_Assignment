import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text.dart';

/// Wordmark-centred header used on the home, listing, wishlist, details and
/// confirmation screens.
class BrandHeader extends StatelessWidget {
  const BrandHeader({
    super.key,
    this.onMenu,
    this.onBack,
    this.trailing = const [],
    this.leadingDot = false,
  });

  final VoidCallback? onMenu;
  final VoidCallback? onBack;
  final List<Widget> trailing;
  final bool leadingDot;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: Row(
        children: [
          SizedBox(
            width: 64,
            child: Align(
              alignment: Alignment.centerLeft,
              child: leadingDot
                  ? const _LeadingDot()
                  : (onBack != null
                      ? _CircleIconButton(
                          icon: Icons.arrow_back,
                          onTap: onBack!,
                          border: false,
                        )
                      : _CircleIconButton(
                          icon: Icons.menu,
                          onTap: onMenu ?? () {},
                          border: false,
                        )),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                'SOFALIVING',
                style: AppText.serif(
                  size: 13.5,
                  weight: FontWeight.w500,
                  spacing: 3.6,
                  color: AppColors.ink,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 64,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: trailing,
            ),
          ),
        ],
      ),
    );
  }
}

class _LeadingDot extends StatelessWidget {
  const _LeadingDot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      margin: const EdgeInsets.only(left: 6),
      decoration: const BoxDecoration(
        color: AppColors.accent,
        shape: BoxShape.circle,
      ),
    );
  }
}

/// Back button + optional centred title, used on the bag and checkout screens.
class PageHeader extends StatelessWidget {
  const PageHeader({
    super.key,
    this.title,
    this.onBack,
    this.trailing,
    this.showLogo = false,
  });

  final String? title;
  final VoidCallback? onBack;
  final Widget? trailing;
  final bool showLogo;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: Row(
        children: [
          SizedBox(
            width: 56,
            child: Align(
              alignment: Alignment.centerLeft,
              child: _CircleIconButton(
                icon: Icons.arrow_back,
                onTap: onBack ?? () => Navigator.of(context).maybePop(),
                border: false,
              ),
            ),
          ),
          Expanded(
            child: showLogo
                ? Center(
                    child: Text(
                      'SOFALIVING',
                      style: AppText.serif(
                        size: 13.5,
                        weight: FontWeight.w500,
                        spacing: 3.6,
                      ),
                    ),
                  )
                : Center(
                    child: Text(
                      title ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppText.sans(size: 14, weight: FontWeight.w600),
                    ),
                  ),
          ),
          SizedBox(
            width: 56,
            child: Align(
              alignment: Alignment.centerRight,
              child: trailing ?? const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({
    required this.icon,
    required this.onTap,
    this.border = true,
  });

  final IconData icon;
  final VoidCallback onTap;
  final bool border;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: border ? Border.all(color: AppColors.line) : null,
        ),
        child: Icon(icon, size: 17, color: AppColors.ink),
      ),
    );
  }
}
