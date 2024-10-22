import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:landbond/core/app_url.dart';

import '../../core/pallet.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  AnimationController? animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 4,
      ),
    );

    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(animationController!);

    animationController?.forward();
    animationController?.addListener(() {
      if (animationController!.isCompleted) {
        _nextScreen();
      }
    });
  }

  void _nextScreen() {
    context.pushReplacementNamed(
      AppUrl.welcomeScreen,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallet.backgroundColor,
      body: Center(
        child: FadeTransition(
          opacity: animation,
          child: Image.asset(
            "assets/images/splashLogo.png",
          ),
        ),
      ),
    );
  }
}
