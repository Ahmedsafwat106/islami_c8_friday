import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/notification_service.dart';

class SebhaTab extends StatefulWidget {
  const SebhaTab({super.key});

  @override
  State<SebhaTab> createState() => _SebhaTabState();
}

class _SebhaTabState extends State<SebhaTab> {
  int counter = 0;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  Future<void> _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      counter = prefs.getInt("sebha_counter") ?? 0;
    });
  }

  Future<void> _saveCounter() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("sebha_counter", counter);
  }

  void _increment() {
    setState(() {
      counter++;
    });
    _saveCounter();
  }

  void _reset() {
    setState(() {
      counter = 0;
    });
    _saveCounter();
  }

  Future<void> _scheduleNotification() async {
    await NotificationService.scheduleDaily(
      id: 1,
      title: "تسبيح اليوم",
      body: "لا تنسَ وردك من التسبيح 🌸",
      hour: 8,
      minute: 0,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("تم تفعيل إشعار التسبيح اليومي ✅")),
    );
  }

  Future<void> _cancelNotifications() async {
    await NotificationService.cancelAll();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("تم إلغاء كل الإشعارات ❌")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 🟢 صورة السبحه
            Image.asset(
              "assets/images/Sebha.png",
              height: 150,
            ),
            const SizedBox(height: 20),

            // 🟢 عداد التسبيحات
            Text(
              "عدد التسبيحات: $counter",
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // 🟢 الأزرار
            ElevatedButton(
              onPressed: _increment,
              child: const Text("سبّح"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _reset,
              child: const Text("إعادة التصفير"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _scheduleNotification,
              child: const Text("🔔 تفعيل إشعار يومي"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _cancelNotifications,
              child: const Text("❌ إلغاء الإشعارات"),
            ),
          ],
        ),
      ),
    );
  }
}
