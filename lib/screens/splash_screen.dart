import 'package:flutter/material.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = "splash";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, OnboardingScreen.routeName);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundGradient = LinearGradient(
      colors: isDark
          ? [const Color(0xFF0f172a), const Color(0xFF1e293b)]
          : [const Color(0xFFfbf3e0), const Color(0xFFf1ede1)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: backgroundGradient),
        child: Center(
          child: FadeTransition(
            opacity: _animation,
            child: Image.asset("assets/images/hadeth_bg.png", width: 150),
          ),
        ),
      ),
    );
  }
}
