import 'package:flutter/material.dart';

import '../pages/p1-9_s1.dart';
import '../pages/p2-10_s2.dart';
import '../pages/p3-11_s3.dart';
import '../pages/p4-12_s3.dart';
import '../pages/p5-13_s3.dart';
import '../pages/p6-14_s4.dart' as p6;
import '../pages/p7-15_s4.dart' as p7;
import '../pages/p8-16_s4.dart';
import '../pages/p9-17_s5.dart';
import '../pages/p10-18_s5.dart';
import '../pages/p11-19_s6.dart';
import '../pages/p12-20_s6.dart';
import '../pages/p13-21_s7.dart';
import '../pages/p14-22_s7.dart';
import '../pages/p15-23_s7.dart';
import '../pages/p16-24_s8.dart';
import '../pages/p17-25_s8.dart';
import '../pages/p18-26_s9.dart';
import '../pages/p19-27_s9.dart';
import '../pages/p20-28_s9.dart';
import '../pages/p21-29_s9.dart';
import '../pages/p22-30_s10.dart';
import '../pages/p23-31_s10.dart';
import '../pages/p24-32_s10.dart';

void main() {
  runApp(const TasbeehApp());
}

class TasbeehApp extends StatelessWidget {
  const TasbeehApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TasbeehScreen(),
    );
  }
}

class TasbeehScreen extends StatefulWidget {
  const TasbeehScreen({super.key});

  @override
  _TasbeehScreenState createState() => _TasbeehScreenState();
}

class _TasbeehScreenState extends State<TasbeehScreen> {
  int _count = 0;

  void _incrementCounter() {
    setState(() {
      _count++;
    });
  }

  void _resetCounter() {
    setState(() {
      _count = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
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

            // Main Content
            SafeArea(
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: const [
                      SizedBox(height: 40),
                      PageButton(name: "P1_S1", page: P1_S1()),
                      SizedBox(height: 10),
                      PageButton(name: "P2_S2", page: P2_S2()),
                      SizedBox(height: 10),
                      PageButton(name: "P3_S3", page: P3_S3()),
                      SizedBox(height: 10),
                      PageButton(name: "P4_S3", page: P4_S3()),
                      SizedBox(height: 10),
                      PageButton(name: "P5_S3", page: P5_S3()),
                      SizedBox(height: 10),
                      PageButton(name: "P6_S4", page: p6.P6_S4()),
                      SizedBox(height: 10),
                      PageButton(name: "P7_S4", page: p7.P7_S4()),
                      SizedBox(height: 10),
                      PageButton(name: "P8_S4", page: P8_S4()),
                      SizedBox(height: 10),
                      PageButton(name: "P9_S5", page: P9_S5()),
                      SizedBox(height: 10),
                      PageButton(name: "P10_S5", page: P10_S5()),
                      SizedBox(height: 10),
                      PageButton(name: "P11_S6", page: P11_S6()),
                      SizedBox(height: 10),
                      PageButton(name: "P12_S6", page: P12_S6()),
                      SizedBox(height: 10),
                      PageButton(name: "P13_S7", page: P13_S7()),
                      SizedBox(height: 10),
                      PageButton(name: "P14_S7", page: P14_S7()),
                      SizedBox(height: 10),
                      PageButton(name: "P15_S7", page: P15_S7()),
                      SizedBox(height: 10),
                      PageButton(name: "P16_S8", page: P16_S8()),
                      SizedBox(height: 10),

                      PageButton(name: "P17_S8", page: P17_S8()),
                      SizedBox(height: 10),
                      PageButton(name: "P18_S9", page: P18_S9()),
                      SizedBox(height: 10),
                      PageButton(name: "P19_S9", page: P19_S9()),
                      SizedBox(height: 10),
                      PageButton(name: "P20_S9", page: P20_S9()),
                      SizedBox(height: 10),
                      PageButton(name: "P21_S9", page: P21_S9()),
                      SizedBox(height: 10),
                      PageButton(name: "P22_S10", page: P22_S10()),
                      SizedBox(height: 10),
                      PageButton(name: "P23_S10", page: P23_S10()),
                      SizedBox(height: 10),

                      PageButton(name: "P24_S10", page: P24_S10()),
                      SizedBox(height: 10),





                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PageButton extends StatelessWidget {
  final String name;
  final Widget page;

  const PageButton({
    super.key,
    required this.name,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Container(
        height: 50,
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * 0.75,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF13342d),
              Color(0xFFFFD700),
              Color(0xFFFFE066),
              Color(0xFFFFD700),
              Color(0xFF13342d),
            ],
            stops: [0.0, 0.35, 0.5, 0.65, 1.0],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          name,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
