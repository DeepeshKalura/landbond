import 'package:agent/core/app_url.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../presentation/auth/login_screen.dart';
import '../presentation/auth/screen/forgot_screen.dart';
import '../presentation/auth/screen/signup_screen.dart';
import '../presentation/home/screen/home_screen.dart';
import '../presentation/home/screen/property_entry_form_screen.dart';
import '../presentation/splash/screen/splash_screen.dart';

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
        path: "/login",
        name: AppUrl.loginScreen,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: "/signup",
        name: AppUrl.signUpScreen,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: "/home",
        name: AppUrl.homeScreen,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
          path: "/properties",
          name: AppUrl.propertyEntryFormScreen,
          builder: (context, state) {
            final args = state.extra as Map<String, dynamic>;

            return PropertyEntryFormScreen(
              producerId: args['propertyId'],
            );
          }),
      GoRoute(
        path: "/forgot",
        name: AppUrl.forgotScreen,
        builder: (context, state) {
          final para = state.extra as Map<String, dynamic>;
          return ForgotScreen(
            auth: para['auth'],
          );
        },
      ),
    ],
  );
}
