import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/core/app_url.dart';
// screens
import '../presentation/auth/screen/signin_screen.dart';
import '../presentation/splash/splash_screen.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRoutes {
  static final router = GoRouter(
    initialLocation: '/',
    navigatorKey: rootNavigatorKey,
    routes: [
      GoRoute(
        path: '/',
        name: AppUrl.splashScreen,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/signin',
        name: AppUrl.signInScreen,
        builder: (context, state) => const SignInScreen(),
      ),
    ],
  );
}
