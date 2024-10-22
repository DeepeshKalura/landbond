import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../presentation/auth/screen/opt_verfication_screen.dart';
import '../presentation/auth/screen/signup_screen.dart';
import '../presentation/auth/screen/welcome_screen.dart';
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
        path: '/welcome',
        name: AppUrl.welcomeScreen,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: '/signin',
        name: AppUrl.signInScreen,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: '/signup',
        name: AppUrl.signUpScreen,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: '/optVerfication',
        name: AppUrl.optVerficationScreen,
        builder: (context, state) => const OptVerficationScreen(),
      ),
    ],
  );
}
