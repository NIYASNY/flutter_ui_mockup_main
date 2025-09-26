import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/home/presentation/screens/home_list_screen.dart';
import '../../features/home/presentation/screens/store_profile_page.dart';
import '../../features/home/presentation/screens/cart_page.dart';
import '../../features/home/presentation/screens/enable_location_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/enable-location',
    routes: [
      GoRoute(
        path: '/enable-location',
        builder: (context, state) => const EnableLocationScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeListScreen(),
      ),
      GoRoute(
        path: '/store-profile',
        builder: (context, state) {
          final spa = state.extra as Map<String, dynamic>;
          return StoreProfilePage(spa: spa);
        },
      ),
      GoRoute(
        path: '/cart',
        builder: (context, state) => const CartPage(),
      ),
    ],
  );
}
