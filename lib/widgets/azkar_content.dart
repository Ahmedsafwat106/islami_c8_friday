import 'package:flutter/material.dart';

class AzkarContent extends StatelessWidget {
  static const routeName = "azkar_content";

  @override
  Widget build(BuildContext context) {
    final String zekr = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: const Text("ذكر"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Text(
                zekr,
                style: const TextStyle(fontSize: 22, height: 1.8),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
