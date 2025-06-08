import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:geolocator/geolocator.dart';

class QiblahScreen extends StatefulWidget {
  const QiblahScreen({super.key});

  @override
  State<QiblahScreen> createState() => _QiblahScreenState();
}

class _QiblahScreenState extends State<QiblahScreen> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController _animationController;
  double begin = 0.0;
  bool isLocationEnabled = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    animation = Tween<double>(begin: 0.0, end: 0.0).animate(_animationController);
    checkLocationPermission();
  }

  Future<void> checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    setState(() {
      isLocationEnabled = true;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand, // Ensures background covers the entire screen
          children: [
            Image.asset(
              'assets/background2.png',
              fit: BoxFit.cover, // Background image
            ),
            isLocationEnabled
                ? StreamBuilder<QiblahDirection>(
                    stream: FlutterQiblah.qiblahStream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        );
                      }

                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            "Error: ${snapshot.error}",
                            style: const TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        );
                      }

                      if (!snapshot.hasData || snapshot.data == null) {
                        return const Center(
                          child: Text(
                            "No data available. Please enable location services.",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                        );
                      }

                      final qiblahDirection = snapshot.data!;
                      double endAngle = (qiblahDirection.qiblah * (pi / 180) * -1);

                      animation = Tween<double>(begin: begin, end: endAngle).animate(_animationController);
                      begin = endAngle;
                      _animationController.forward(from: 0);

                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${qiblahDirection.direction.toInt()}°",
                              style: const TextStyle(
                                color: Color(0xFFFFD700), // Golden color
                                fontSize: 24,
                                fontWeight: FontWeight.bold, // Optional: Make it bold
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 300,
                              child: AnimatedBuilder(
                                animation: animation,
                                builder: (context, child) => Transform.rotate(
                                  angle: animation.value,
                                  child: Image.asset('assets/qibla.png'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Text(
                      "Please enable location services.",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
