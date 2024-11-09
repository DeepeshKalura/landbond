import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:landbond/presentation/home/screen/list_properties_screen.dart';

import '../presentation/auth/screen/confirm_email_screen.dart';
import '../presentation/auth/screen/email_verified_screen.dart';
import '../presentation/auth/screen/new_password_screen.dart';
import '../presentation/home/data/model/property.dart';
import '../presentation/home/screen/notification_screen.dart';
import '../presentation/home/screen/property_screen.dart';
import '../presentation/property/screen/chating_with_agent_screen.dart';
import '../presentation/property/screen/property_details_screen.dart';
import '/core/app_url.dart';
// screens
import '../presentation/auth/screen/checking_email_forgot_password_screen.dart';
import '../presentation/auth/screen/clinet_signin_screen.dart';
import '../presentation/auth/screen/forgot_password_screen.dart';
import '../presentation/auth/screen/signin_screen.dart';
import '../presentation/home/screen/home_screen.dart';
import '../presentation/auth/screen/client_registeration_screen.dart';
import '../presentation/onboading/next_boading_screen.dart';
import '../presentation/onboading/onboarding_screen.dart';
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
      GoRoute(
        path: '/home',
        name: AppUrl.homeScreen,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        name: AppUrl.onboardingScreen,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/nextboarding',
        name: AppUrl.nextBoardingScreen,
        builder: (context, state) => const NextboardingScreen(),
      ),
      GoRoute(
        path: '/clinetsignup',
        name: AppUrl.clientSignupScreen,
        builder: (context, state) => const ClientSignupScreen(),
      ),
      GoRoute(
        path: '/loginUser',
        name: AppUrl.loginUserScreen,
        builder: (context, state) => const ClientSigninScreen(),
      ),
      GoRoute(
        path: '/forgotPassword',
        name: AppUrl.forgotPasswordScreen,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: '/checkingEmailForgotPassword',
        name: AppUrl.checkingEmailForgotPasswordScreen,
        builder: (context, state) => const CheckingEmailForgotPasswordScreen(),
      ),
      GoRoute(
        path: '/emailVerify',
        name: AppUrl.emailVerifiedScreen,
        builder: (context, state) => const EmailVerifiedScreen(),
      ),
      GoRoute(
        path: '/newPassword',
        name: AppUrl.newPasswordScreen,
        builder: (context, state) => const NewPasswordScreen(),
      ),
      GoRoute(
        path: '/confirmEmailScreen',
        name: AppUrl.confirmEmailScreen,
        builder: (context, state) => const ConfirmEmailScreen(),
      ),
      GoRoute(
        path: '/notificationScreen',
        name: AppUrl.notificationScreen,
        builder: (context, state) => const NotificationScreen(),
      ),
      GoRoute(
        path: '/propertyScreen',
        name: AppUrl.propertyScreen,
        builder: (context, state) => const PropertyScreen(),
      ),
      GoRoute(
        path: '/listPropertiesScreen',
        name: AppUrl.listPropertiesScreen,
        builder: (context, state) => const ListPropertiesScreen(),
      ),
      GoRoute(
        path: '/propertyDetailsScreen',
        name: AppUrl.propertyDetailsScreen,
        builder: (context, state) {
          Map<String, Property> args = state.extra as Map<String, Property>;
          return PropertyDetailsScreen(
            property: args['property']!,
          );
        },
      ),
      GoRoute(
          path: '/chatingWithAgentScreen',
          name: AppUrl.chatingWithAgentScreen,
          builder: (context, state) {
            Map<String, String> args = state.extra as Map<String, String>;

            return ChatingWithAgentScreen(
              producerId: args['producerId'] as String,
            );
          }),
    ],
  );
}
