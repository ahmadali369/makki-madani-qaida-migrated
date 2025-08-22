import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PrayerTimingsScreen extends StatefulWidget {
  @override
  _PrayerTimingsScreenState createState() => _PrayerTimingsScreenState();
}

class _PrayerTimingsScreenState extends State<PrayerTimingsScreen> {
  Map<String, String> prayerTimes = {};
  String nextPrayer = 'Loading...';
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchPrayerTimes();
  }

  Future<void> _fetchPrayerTimes() async {
    try {
      // Request location permission
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        setState(() {
          errorMessage = "Location permission denied";
        });
        return;
      }

      // Get current location
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);

      double lat = position.latitude;
      double lon = position.longitude;

      // Current timestamp (for today's timings)
      final timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      // Call AlAdhan API
      final response = await http.get(Uri.parse(
        'https://api.aladhan.com/v1/timings/$timestamp?latitude=$lat&longitude=$lon&method=2',
      ));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final timings = data['data']['timings'];

        setState(() {
          prayerTimes = {
            'Fajr': timings['Fajr'],
            'Dhuhr': timings['Dhuhr'],
            'Asr': timings['Asr'],
            'Maghrib': timings['Maghrib'],
            'Isha': timings['Isha'],
          };
          nextPrayer = getNextPrayer();
        });
      } else {
        setState(() {
          errorMessage = 'Failed to load prayer times';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "Error: $e";
      });
    }
  }

  String getNextPrayer() {
    if (prayerTimes.isEmpty) return "Loading...";

    DateTime now = DateTime.now();
    for (var entry in prayerTimes.entries) {
      try {
        DateTime prayerTime;

        // Try parsing 24-hour format first
        try {
          prayerTime = DateFormat('HH:mm').parse(entry.value);
        } catch (_) {
          // If it fails, try 12-hour with AM/PM
          prayerTime = DateFormat('hh:mm a').parse(entry.value);
        }

        // Adjust to today's date
        prayerTime = DateTime(
          now.year,
          now.month,
          now.day,
          prayerTime.hour,
          prayerTime.minute,
        );

        if (prayerTime.isAfter(now)) {
          return entry.key;
        }
      } catch (_) {}
    }
    return 'Fajr'; // fallback to next day
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

                const SizedBox(height: 10),

                // Next Prayer
                Text(
                  errorMessage.isNotEmpty
                      ? errorMessage
                      : 'Next Prayer: $nextPrayer',
                  style: TextStyle(
                    fontSize: 20,
                    color: errorMessage.isNotEmpty
                        ? Colors.redAccent
                        : Colors.yellowAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                // Prayer Times List
                Expanded(
                  child: prayerTimes.isEmpty
                      ? Center(child: CircularProgressIndicator())
                      : ListView.builder(
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
