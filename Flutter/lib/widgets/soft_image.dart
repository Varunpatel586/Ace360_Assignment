import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class SoftImage extends StatelessWidget {
  const SoftImage({
    super.key,
    required this.asset,
    this.radius = 14,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.alignment = Alignment.center,
  });

  final String asset;
  final double radius;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        width: width,
        height: height,
        color: AppColors.creamDeep,
        child: Image.asset(
          asset,
          fit: fit,
          width: width,
          height: height,
          alignment: alignment,
          errorBuilder: (context, error, stack) => Center(
            child: Icon(
              Icons.weekend_outlined,
              color: AppColors.muted.withValues(alpha: 0.5),
              size: 22,
            ),
          ),
        ),
      ),
    );
  }
}
