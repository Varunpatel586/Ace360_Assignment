import 'package:flutter/material.dart';

import '../../data/app_data.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text.dart';
import '../../widgets/app_bottom_nav.dart';
import '../../widgets/app_header.dart';
import '../../widgets/filter_sheet.dart';
import '../../widgets/pill.dart';
import '../../widgets/product_card.dart';
import '../details/product_details_screen.dart';

class ListingScreen extends StatefulWidget {
  const ListingScreen({super.key});

  @override
  State<ListingScreen> createState() => _ListingScreenState();
}

class _ListingScreenState extends State<ListingScreen> {
  static const List<String> _filters = [
    'Sofa Sets',
    'Sectionals',
    'Armchairs',
  ];

  int _category = -1;

  void _openProduct(int index) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ProductDetailsScreen(product: AppData.catalogue[index]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: BrandHeader(
                onMenu: () {},
                trailing: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const Icon(
                        Icons.notifications_none,
                        size: 18,
                        color: AppColors.inkSoft,
                      ),
                      Positioned(
                        right: -1,
                        top: 0,
                        child: Container(
                          width: 5,
                          height: 5,
                          decoration: const BoxDecoration(
                            color: AppColors.accent,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(18, 4, 18, 24),
                physics: const BouncingScrollPhysics(),
                children: [
                  Container(
                    height: 44,
                    padding: const EdgeInsets.only(left: 14, right: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(color: AppColors.line),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search, size: 15, color: AppColors.muted),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Search by sofa, material or room…',
                            style: AppText.sans(size: 10.5, color: AppColors.muted),
                          ),
                        ),
                        const Icon(Icons.mic_none, size: 15, color: AppColors.muted),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('All Sofas', style: AppText.serif(size: 24)),
                            const SizedBox(height: 2),
                            Text(
                              '${AppData.catalogue.length * 2} curated living pieces',
                              style: AppText.sans(
                                size: 9,
                                color: AppColors.muted,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GhostPill(
                        label: 'Popularity',
                        height: 30,
                        trailing: Icons.keyboard_arrow_down,
                        background: Colors.white,
                        textStyle: AppText.sans(size: 9.5),
                        onTap: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 13),
                  SizedBox(
                    height: 32,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        GhostPill(
                          label: 'Filters',
                          icon: Icons.tune,
                          height: 32,
                          selected: true,
                          onTap: () => FilterSheet.show(context),
                        ),
                        const SizedBox(width: 7),
                        for (var i = 0; i < _filters.length; i++) ...[
                          GhostPill(
                            label: _filters[i],
                            height: 32,
                            selected: _category == i,
                            background: Colors.white,
                            onTap: () => setState(
                              () => _category = _category == i ? -1 : i,
                            ),
                            textStyle: AppText.sans(
                              size: 10,
                              weight: FontWeight.w500,
                              color: _category == i
                                  ? Colors.white
                                  : AppColors.inkSoft,
                            ),
                          ),
                          const SizedBox(width: 7),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () => FilterSheet.show(context),
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 11,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.line),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 28,
                            height: 28,
                            decoration: const BoxDecoration(
                              color: AppColors.creamDeep,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.tune,
                              size: 13,
                              color: AppColors.inkSoft,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Filter by Price, Size, Fabric',
                                  style: AppText.sans(
                                    size: 10.5,
                                    weight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Customize your living space',
                                  style: AppText.sans(
                                    size: 8.5,
                                    color: AppColors.muted,
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
                  ),
                  const SizedBox(height: 14),
                  GridView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: AppData.catalogue.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          mainAxisExtent: 244,
                        ),
                    itemBuilder: (context, i) => ProductGridCard(
                      product: AppData.catalogue[i],
                      imageHeight: 128,
                      showViewAction: true,
                      onTap: () => _openProduct(i),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.creamDeep,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Need custom dimensions?',
                                style: AppText.serif(size: 15.5),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                'Book a complimentary atelier call.',
                                style: AppText.sans(
                                  size: 9,
                                  color: AppColors.mutedDark,
                                ),
                              ),
                            ],
                          ),
                        ),
                        PrimaryPill(
                          label: 'Contact',
                          height: 30,
                          fontSize: 9.5,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          onTap: () {},
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
      bottomNavigationBar: const AppBottomNav(currentIndex: 1),
    );
  }
}
