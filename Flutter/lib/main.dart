import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/cart_provider.dart';
import 'providers/customiser_provider.dart';
import 'providers/wishlist_provider.dart';
import 'screens/home/home_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => WishlistProvider()),
        ChangeNotifierProvider(create: (_) => CustomiserProvider()),
      ],
      child: MaterialApp(
        title: 'SOFALIVING',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        // The design is a phone layout: keep it at phone width when the app is
        // opened on a wide screen (desktop / web) instead of stretching it.
        builder: (context, child) {
          final media = MediaQuery.of(context);
          if (media.size.width <= 600) return child ?? const SizedBox.shrink();
          return ColoredBox(
            color: const Color(0xFF17140F),
            child: Center(
              child: SizedBox(
                width: 412,
                child: MediaQuery(
                  data: media.copyWith(
                    size: Size(412, media.size.height),
                    padding: EdgeInsets.zero,
                    viewPadding: EdgeInsets.zero,
                  ),
                  child: child ?? const SizedBox.shrink(),
                ),
              ),
            ),
          );
        },
        home: const HomeScreen(),
      ),
    );
  }
}
