// ignore_for_file: file_names, use_key_in_widget_constructors, library_private_types_in_public_api, unused_import

import 'dart:async'; // Correct import for Timer

import 'package:flutter/material.dart';

import '../Boarding Screen/OnboardingScreen.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Using Future.delayed instead of Timer for better readability
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) { // Check if the widget is still in the tree
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OnBoarding()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Wrapping with Scaffold to prevent layout issues
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Image.asset(
          'assets/SplashScreen.png', // Your splash image
          fit: BoxFit.cover // Ensures the image fills the entire screen
        ),
      ),
    );
  }
}
