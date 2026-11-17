import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import '../utils/format.dart';
import 'pill.dart';

/// Bottom sheet shown from the "Filters" chip on the All Sofas screen.
class FilterSheet extends StatefulWidget {
  const FilterSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: AppColors.cream,
      barrierColor: Colors.black.withValues(alpha: 0.32),
      builder: (_) => const FilterSheet(),
    );
  }

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  static const _materials = ['Bouclé', 'Velvet', 'Linen', 'Chenille'];
  static const _materialColors = [
    AppColors.swatchCream,
    AppColors.swatchClay,
    AppColors.swatchTaupe,
    AppColors.swatchInk,
  ];
  static const _seating = ['2-Seater', '3-Seater', 'L-Shape', 'Ottoman & Modular'];

  int _material = 0;
  int _seatingIndex = 0;
  RangeValues _range = const RangeValues(12000, 95000);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 18),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 34,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.line,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Filter Sofas', style: AppText.serif(size: 24, height: 1.1)),
                    const SizedBox(height: 4),
                    Text(
                      'Refine by price, material & dimension',
                      style: AppText.sans(size: 10, color: AppColors.mutedDark),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.line),
                  ),
                  child: const Icon(Icons.close, size: 14, color: AppColors.inkSoft),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Text('Price Range', style: AppText.sans(size: 12, weight: FontWeight.w600)),
              const Spacer(),
              Text(
                'Up to ${inr(_range.end)}',
                style: AppText.label(size: 9, color: AppColors.accent, spacing: 0.4),
              ),
            ],
          ),
          const SizedBox(height: 6),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 2,
              activeTrackColor: AppColors.ink,
              inactiveTrackColor: AppColors.line,
              thumbColor: AppColors.ink,
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 12),
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6.5),
            ),
            child: RangeSlider(
              values: _range,
              min: 12000,
              max: 120000,
              divisions: 108,
              onChanged: (values) => setState(() => _range = values),
            ),
          ),
          Row(
            children: [
              Text(inr(_range.start), style: AppText.sans(size: 9, color: AppColors.muted)),
              const Spacer(),
              Text('${inr(120000)}+', style: AppText.sans(size: 9, color: AppColors.muted)),
            ],
          ),
          const SizedBox(height: 18),
          Text('Material Preference', style: AppText.sans(size: 12, weight: FontWeight.w600)),
          const SizedBox(height: 10),
          Row(
            children: [
              for (var i = 0; i < _materials.length; i++)
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _material = i),
                    behavior: HitTestBehavior.opaque,
                    child: Column(
                      children: [
                        Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: _materialColors[i],
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: _material == i ? AppColors.ink : AppColors.line,
                              width: _material == i ? 1.6 : 1,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          _materials[i],
                          style: AppText.sans(
                            size: 8.5,
                            weight: _material == i ? FontWeight.w600 : FontWeight.w400,
                            color: _material == i ? AppColors.ink : AppColors.mutedDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 18),
          Text('Seating Configuration', style: AppText.sans(size: 12, weight: FontWeight.w600)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 7,
            runSpacing: 7,
            children: [
              for (var i = 0; i < _seating.length; i++)
                GhostPill(
                  label: _seating[i],
                  height: 30,
                  selected: _seatingIndex == i,
                  onTap: () => setState(() => _seatingIndex = i),
                  textStyle: AppText.sans(
                    size: 9.5,
                    weight: FontWeight.w500,
                    color: _seatingIndex == i ? Colors.white : AppColors.inkSoft,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 22),
          Row(
            children: [
              GhostPill(
                label: 'Reset',
                height: 44,
                padding: const EdgeInsets.symmetric(horizontal: 26),
                onTap: () => setState(() {
                  _material = 0;
                  _seatingIndex = 0;
                  _range = const RangeValues(12000, 95000);
                }),
                textStyle: AppText.sans(size: 11, weight: FontWeight.w500),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: PrimaryPill(
                  label: 'Show 24 Pieces',
                  height: 44,
                  expand: true,
                  onTap: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
