import 'package:flutter/material.dart';

class AzkarScreen extends StatelessWidget {
  static const routeName = "azkar";

  final List<String> azkar = const [
    "🌅 أذكار الصباح: أصبحنا وأصبح الملك لله...",
    "🌙 أذكار المساء: أمسينا وأمسى الملك لله...",
    "🤲 سيد الاستغفار: اللهم أنت ربي لا إله إلا أنت...",
    "💤 دعاء النوم: باسمك اللهم أموت وأحيا...",
    "🚶‍♂️ دعاء الخروج من المنزل: بسم الله توكلت على الله..."
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الأذكار"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        itemCount: azkar.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                azkar[index],
                style: const TextStyle(fontSize: 18, height: 1.6),
              ),
            ),
          );
        },
      ),
    );
  }
}
