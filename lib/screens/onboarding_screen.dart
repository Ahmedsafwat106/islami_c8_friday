import 'package:flutter/material.dart';
import '../home_screen.dart';

class OnboardingScreen extends StatelessWidget {
  static const routeName = "onboarding";

  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          Center(child: Text("📖 اقرأ القرآن بسهولة")),
          Center(child: Text("🕌 أذكارك في مكان واحد")),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, HomeScreen.routeName);
              },
              child: Text("ابدأ"),
            ),
          ),
        ],
      ),
    );
  }
}
