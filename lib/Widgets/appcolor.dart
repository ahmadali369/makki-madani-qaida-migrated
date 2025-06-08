// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class AppColors {
  static const Color kPrimary = Color(0xFF13342d);
  static const Color kWhite = Color(0xFFFEFEFE);
  static const Color kPrimaryy = Color(0xFFD1A661);
  static const Color kWhitee = Color(0xFFFEFEFE);
  static LinearGradient customOnboardingGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      const Color(0xFF110C1D).withOpacity(0.0),
      const Color(0xFF110C1D),
    ],
  );
}