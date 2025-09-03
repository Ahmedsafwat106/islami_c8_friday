import 'package:flutter/material.dart';
import 'package:islami_c8_friday/screens/azkar_screen.dart';
import 'package:islami_c8_friday/screens/radio_screen.dart';
import 'package:islami_c8_friday/tabs/ahadeth.dart';
import 'package:islami_c8_friday/tabs/quran.dart';
import 'package:islami_c8_friday/tabs/radio.dart';
import 'package:islami_c8_friday/tabs/sebha.dart';
import 'package:islami_c8_friday/tabs/settings.dart';
import 'package:islami_c8_friday/tabs/bookmarks_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = "home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  final tabs = [
    const QuranTab(),
    AhadethTab(),
    const SebhaTab(),
    const RadioTab(),
    const SettingsTab(),
    const BookmarksTab(),
  ];

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

    return Container(
      decoration: BoxDecoration(gradient: backgroundGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text("Islami App"),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        drawer: Drawer(
          child: Column(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Theme.of(context).primaryColor),
                child: const Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Islami App",
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.menu_book),
                title: const Text("📿 الأذكار"),
                onTap: () {
                  Navigator.pushNamed(context, AzkarScreen.routeName);
                },
              ),
              ListTile(
                leading: const Icon(Icons.radio),
                title: const Text("📻 الراديو"),
                onTap: () {
                  Navigator.pushNamed(context, RadioScreen.routeName);
                },
              ),
            ],
          ),
        ),
        body: tabs[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (value) => setState(() => currentIndex = value),
          type: BottomNavigationBarType.fixed,
          backgroundColor: isDark ? const Color(0xFF141A2E) : const Color(0xFFB7935F),
          selectedItemColor: isDark ? Colors.yellow : Colors.black,
          unselectedItemColor: Colors.grey.shade700,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.menu_book,
                color: currentIndex == 0 ? (isDark ? Colors.yellow : Colors.black) : Colors.grey.shade700,
              ),
              label: "القرآن",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.menu,
                color: currentIndex == 1 ? (isDark ? Colors.yellow : Colors.black) : Colors.grey.shade700,
              ),
              label: "الأحاديث",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.fiber_manual_record,
                color: currentIndex == 2 ? (isDark ? Colors.yellow : Colors.black) : Colors.grey.shade700,
              ),
              label: "السبحة",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.radio,
                color: currentIndex == 3 ? (isDark ? Colors.yellow : Colors.black) : Colors.grey.shade700,
              ),
              label: "الراديو",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                color: currentIndex == 4 ? (isDark ? Colors.yellow : Colors.black) : Colors.grey.shade700,
              ),
              label: "الإعدادات",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.bookmark,
                color: currentIndex == 5 ? (isDark ? Colors.yellow : Colors.black) : Colors.grey.shade700,
              ),
              label: "المفضلة",
            ),
          ],
        ),
      ),
    );
  }
}
