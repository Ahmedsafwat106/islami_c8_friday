import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';

class RadioScreen extends StatefulWidget {
  static const routeName = "radio";

  @override
  State<RadioScreen> createState() => _RadioScreenState();
}

class _RadioScreenState extends State<RadioScreen> {
  final player = AudioPlayer();
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _initRadio();
  }

  Future<void> _initRadio() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.music());
    // 🟢 محطة قرآن مباشر (تقدر تغير اللينك لو حابب)
    await player.setUrl("https://qurango.net/radio/tarateel");
  }

  void _togglePlay() async {
    if (isPlaying) {
      await player.pause();
    } else {
      await player.play();
    }
    setState(() => isPlaying = !isPlaying);
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الراديو 📻"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 🟢 صورة الراديو
            Image.asset(
              "assets/images/radio.png",
              height: 150,
            ),
            const SizedBox(height: 30),

            const Text(
              "Quran Radio Live",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),

            ElevatedButton.icon(
              onPressed: _togglePlay,
              icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
              label: Text(isPlaying ? "إيقاف" : "استمع الآن"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 14,
                ),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
