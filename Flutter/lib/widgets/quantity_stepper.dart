import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text.dart';

class QuantityStepper extends StatelessWidget {
  const QuantityStepper({
    super.key,
    required this.value,
    required this.onDecrement,
    required this.onIncrement,
    this.width = 92,
    this.height = 32,
  });

  final int value;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.line),
      ),
      child: Row(
        children: [
          Expanded(
            child: _StepButton(icon: Icons.remove, onTap: onDecrement),
          ),
          Text(
            '$value',
            style: AppText.sans(size: 11, weight: FontWeight.w600),
          ),
          Expanded(
            child: _StepButton(icon: Icons.add, onTap: onIncrement),
          ),
        ],
      ),
    );
  }
}

class _StepButton extends StatelessWidget {
  const _StepButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Center(
        child: Icon(icon, size: 12, color: AppColors.inkSoft),
      ),
    );
  }
}
