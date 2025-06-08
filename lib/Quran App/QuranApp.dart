// import 'package:al_quran/Screens/NamazTimings.dart';
// import 'package:al_quran/Screens/Quotes.dart';
// import 'package:al_quran/Screens/Tasbeeh_Counter.dart';
// import 'package:al_quran/Screens/qibla.dart';
// import 'package:al_quran/Widgets/bottamnavigator.dart';
import 'package:flutter/material.dart';

import '../Screens/NamazTimings.dart';
import '../Screens/Quotes.dart';
import '../Screens/Tasbeeh_Counter.dart';
import '../Screens/qibla.dart';
import '../Widgets/bottamnavigator.dart';

class QuranApp extends StatefulWidget {
  const QuranApp({super.key});

  @override
  State<QuranApp> createState() => _QuranAppState();
}

class _QuranAppState extends State<QuranApp> {
  final List<Map<String, dynamic>> containerData = [
    {"image": "assets/t.png", "label": "Tasbeeh Counter", "screen": TasbeehApp()},
    {"image": "assets/q.png", "label": "Qibla Tracker ", "screen": const QiblahScreen()},
    {"image": "assets/qu.png", "label": "Quranic Quotes", "screen": IslamicQuotesApp()}, 
    {"image": "assets/MMM.png", "label": "Prayer Timings", "screen": PrayerTimingsScreen()},
  ];

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          // Fullscreen Background Image
          Positioned.fill(
            child: Image.asset(
              "assets/2.png",
              fit: BoxFit.cover,
            ),
          ),
          // Container Section
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 120.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Asalam Alaikum',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 2x2 Grid Layout for Containers
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: containerData.sublist(0, 2).map((data) => _buildContainer(data)).toList(),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: containerData.sublist(2, 4).map((data) => _buildContainer(data)).toList(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomNavBarCurved(),
    );
  }

  Widget _buildContainer(Map<String, dynamic> data) {
    return GestureDetector(
      onTap: () {
        if (data["screen"] != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => data["screen"]),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("${data['label']} is not available yet.")),
          );
        }
      },
      child: Container(
        width: 150,
        height: 100,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color:  const Color(0xFFFFD700),
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              data["image"],
              width: 50,
              height: 50,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 5),
            Text(
              data["label"],
              style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
