import 'package:flutter/material.dart';
import 'package:makki_madani_qaida_migrated/pages/p1-9_s1.dart';
import 'package:makki_madani_qaida_migrated/pages/p2-10_s2.dart';
import 'package:makki_madani_qaida_migrated/pages/p3-11_s3.dart';



import 'SplashScreen/SplashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Makki Madani Qaida',
      // theme: ThemeData(
      //
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      // home: const HomePageButtonList(),

      home: SplashScreen(),



    );
  }
}



class HomePageButtonList extends StatefulWidget {
  const HomePageButtonList({super.key});

  @override
  State<HomePageButtonList> createState() => _HomePageButtonListState();
}

class _HomePageButtonListState extends State<HomePageButtonList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Makki Madani Qaida'),backgroundColor: Colors.blue,),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: (){

                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const P1_S1()));

            }, child: const Text("P1_s1")),
            const SizedBox(height: 10,),


            TextButton(
                onPressed: (){

                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const P2_S2()));

                }, child: const Text("P2_s2")),
            const SizedBox(height: 10,),


            TextButton(
                onPressed: (){

                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const P3_S3()));

                }, child: const Text("P3_s3")),
            const SizedBox(height: 10,),


          ],
        ),
      ),
    );
  }
}






