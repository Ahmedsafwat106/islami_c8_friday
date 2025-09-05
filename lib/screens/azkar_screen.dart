import 'package:flutter/material.dart';

import '../widgets/azkar_content.dart';


class AzkarScreen extends StatelessWidget {
  static const routeName = "azkar";

  final List<String> azkar = const [
    "🌅 أذكار الصباح: أصبحنا وأصبح الملك لله والحمد لله...",
    "🌙 أذكار المساء: أمسينا وأمسى الملك لله والحمد لله...",
    "🤲 سيد الاستغفار: اللهم أنت ربي لا إله إلا أنت، خلقتني وأنا عبدك...",
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
      body: Column(
        children: [
          // 🔹 صورة في الأعلى
          Image.asset(
            "assets/images/azker.jpg",
            fit: BoxFit.cover,
            height: 180,
            width: double.infinity,
          ),

          const SizedBox(height: 10),
          Divider(thickness: 2, color: Colors.teal.shade200),
          const Text(
            "📖 الأذكار",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Divider(thickness: 2, color: Colors.teal.shade200),

          // 🔹 الأذكار في ليست
          Expanded(
            child: ListView.builder(
              itemCount: azkar.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    title: Text(
                      azkar[index],
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AzkarContent.routeName,
                        arguments: azkar[index],
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
