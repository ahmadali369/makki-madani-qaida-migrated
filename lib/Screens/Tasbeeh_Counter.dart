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

void main() {
  runApp(TasbeehApp());
}

class TasbeehApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TasbeehScreen(),
    );
  }
}

class TasbeehScreen extends StatefulWidget {
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

          Center(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    SizedBox(height: 120,),

                    PageButton(name: "P1_S1", Page: P1_S1()),

                    SizedBox(height: 10,),

                    PageButton(name: "P2_S2", Page: P2_S2()),

                    //
                    SizedBox(height: 10,),

                    PageButton(name: "P3_S3", Page: P3_S3()),


                    SizedBox(height: 10,),

                    PageButton(name: "P4_S3", Page: P4_S3()),


                    SizedBox(height: 10,),

                    PageButton(name: "P5_S3", Page: P5_S3()),

                    SizedBox(height: 10,),

                    PageButton(name: "P6_S4", Page: p6.P6_S4()),

                    SizedBox(height: 10,),

                    PageButton(name: "P7_S4", Page: p7.P7_S4()),

                    SizedBox(height: 10,),
                    PageButton(name: "P8_S4", Page: P8_S4()),

                    SizedBox(height: 10,),
                    PageButton(name: "P9_S5", Page: P9_S5()),

                    SizedBox(height: 10,),
                    PageButton(name: "P10_S5", Page: P10_S5()),
                  ],
                ),
              ),
            ),
          )


        ],
      ),
    );
  }
}




class PageButton extends StatefulWidget {

  const PageButton({super.key, required this.name, required this.Page});

  final String name;
  final Widget Page;


  @override
  State<PageButton> createState() => _PageButtonState();
}

class _PageButtonState extends State<PageButton> {
  @override
  Widget build(BuildContext context) {
    return                     GestureDetector(
      onTap: () {

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => widget.Page));
        // Handle login
      },
      child: Container(
        height: 50,
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * .75,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF13342d), // Dark Green
              Color(0xFFFFD700), // Gold
              Color(0xFFFFE066), // Light Gold (Center)
              Color(0xFFFFD700), // Gold
              Color(0xFF13342d), // Dark Green
            ],
            stops: [0.0, 0.35, 0.5, 0.65, 1.0],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          widget.name,
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

