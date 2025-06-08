import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class PrayerTimingsScreen extends StatefulWidget {
  @override
  _PrayerTimingsScreenState createState() => _PrayerTimingsScreenState();
}

class _PrayerTimingsScreenState extends State<PrayerTimingsScreen> {
  final Map<String, String> prayerTimes = {
    'Fajr': '05:10 AM',
    'Dhuhr': '12:30 PM',
    'Asr': '04:15 PM',
    'Maghrib': '06:45 PM',
    'Isha': '08:00 PM',
  };

  String getNextPrayer() {
    DateTime now = DateTime.now();
    DateFormat format = DateFormat('hh:mm a');
    for (var entry in prayerTimes.entries) {
      DateTime prayerTime = format.parse(entry.value);
      if (prayerTime.isAfter(now)) {
        return entry.key;
      }
    }
    return 'Fajr';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background2.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Gradient Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black.withOpacity(0.4), Colors.transparent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Title
                Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: Text(
                    'Prayer Timings',
                    style: GoogleFonts.amiri(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),

                // Next Prayer Section
                
                const SizedBox(height: 10),

                // Prayer Times List
                Expanded(
                  child: ListView.builder(
                    itemCount: prayerTimes.length,
                    itemBuilder: (context, index) {
                      String prayer = prayerTimes.keys.elementAt(index);
                      String time = prayerTimes.values.elementAt(index);
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Card(
                          elevation: 5,
                          color: Colors.white.withOpacity(0.9),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ListTile(
                            title: Text(
                              prayer,
                              style: GoogleFonts.amiri(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            subtitle: Text(
                              time,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black54,
                              ),
                            ),
                            trailing: const Icon(
                              Icons.access_time,
                              color: Color(0xFFFFD700),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
