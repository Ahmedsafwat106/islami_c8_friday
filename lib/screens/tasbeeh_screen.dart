import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TasbeehScreen extends StatefulWidget {
  const TasbeehScreen({super.key});

  @override
  State<TasbeehScreen> createState() => _TasbeehScreenState();
}

class _TasbeehScreenState extends State<TasbeehScreen> {
  int counter = 0;

  @override
  void initState() {
    super.initState();
    _loadCounter(); // تحميل العداد المحفوظ
  }

  /// 🟢 تحميل العداد من SharedPreferences
  Future<void> _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      counter = prefs.getInt('tasbeeh_counter') ?? 0;
    });
  }

  /// 🟢 حفظ العداد في SharedPreferences
  Future<void> _saveCounter() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('tasbeeh_counter', counter);
  }

  /// 🟢 زيادة العداد
  void _incrementCounter() {
    setState(() {
      counter++;
    });
    _saveCounter();
  }

  /// 🔴 تصفير العداد
  void _resetCounter() {
    setState(() {
      counter = 0;
    });
    _saveCounter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("السبحة")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("عدد التسبيحات", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            Text(
              "$counter",
              style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _incrementCounter,
              child: const Text("سبّح"),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: _resetCounter,
              child: const Text("إعادة التصفير"),
            ),
          ],
        ),
      ),
    );
  }
}
