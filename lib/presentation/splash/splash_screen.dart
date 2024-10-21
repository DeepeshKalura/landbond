import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:landbond/core/app_url.dart';

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
        seconds: 3,
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
      AppUrl.signInScreen,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: FadeTransition(
          opacity: animation,
          child: const Text(
            "Land Bond",
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
