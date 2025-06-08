import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(IslamicQuotesApp());
}

class IslamicQuotesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IslamicQuotesScreen(),
    );
  }
}

class IslamicQuotesScreen extends StatefulWidget {
  @override
  _IslamicQuotesScreenState createState() => _IslamicQuotesScreenState();
}

class _IslamicQuotesScreenState extends State<IslamicQuotesScreen> {
  final List<String> quotes = [
    "إِنَّ مَعَ الْعُسْرِ يُسْرًا (Indeed, with hardship comes ease) - Quran 94:6",
    "وَاصْبِرْ فَإِنَّ اللَّهَ لَا يُضِيعُ أَجْرَ الْمُحْسِنِينَ (Be patient, for Allah does not let the reward of the righteous be lost) - Quran 11:115",
    "اللهم اجعل القرآن ربيع قلبي ونور صدري (O Allah, make the Quran the spring of my heart and the light of my chest).",
    "لا يكلف الله نفسا إلا وسعها (Allah does not burden a soul beyond that it can bear) - Quran 2:286",
    "حَسْبِيَ اللَّهُ وَنِعْمَ الْوَكِيلُ (Allah is sufficient for me, and He is the best disposer of affairs) - Quran 3:173",
    "الرَّحْمَٰنُ الرَّحِيمُ (The Most Gracious, The Most Merciful) - Quran 1:3",
    "فَاذْكُرُونِي أَذْكُرْكُمْ (So remember Me, and I will remember you) - Quran 2:152",
    "وَإِذَا مَرِضْتُ فَهُوَ يَشْفِينِ (And when I am ill, it is He who cures me) - Quran 26:80",
    "إِنَّ اللَّهَ مَعَ الصَّابِرِينَ (Indeed, Allah is with the patient) - Quran 2:153",
    "اللهم صل وسلم على نبينا محمد (O Allah, send peace and blessings upon our Prophet Muhammad ﷺ).",
    "اللهم ارزقنا حسن الخاتمة (O Allah, grant us a good ending).",
    "اللهم اجعلنا من أهل الجنة (O Allah, make us among the people of Jannah).",
    "إِنَّ رَبِّي قَرِيبٌ مُّجِيبٌ (Indeed, my Lord is near and responsive) - Quran 11:61",
    "فَإِنَّ مَعَ الْعُسْرِ يُسْرًا (For indeed, with hardship comes ease) - Quran 94:5",
    "إِنَّمَا الْأَعْمَالُ بِالنِّيَّاتِ (Actions are judged by intentions) - Hadith",
    "أَقْرَبُ مَا يَكُونُ الْعَبْدُ مِنْ رَبِّهِ وَهُوَ سَاجِدٌ (The closest a servant comes to his Lord is when he is in prostration) - Hadith",
    "وَتَوَكَّلْ عَلَى اللَّهِ وَكَفَىٰ بِاللَّهِ وَكِيلًا (And rely upon Allah; and sufficient is Allah as Disposer of affairs) - Quran 33:3",
    "رَبِّ زِدْنِي عِلْمًا (My Lord, increase me in knowledge) - Quran 20:114",
    "إِنَّ اللَّهَ غَفُورٌ رَّحِيمٌ (Indeed, Allah is Forgiving and Merciful) - Quran 2:173",
    "اللهم اجعل لي نورًا في قلبي (O Allah, place light in my heart).",
    "إِنَّ اللَّهَ يُحِبُّ الْمُتَوَكِّلِينَ (Indeed, Allah loves those who rely upon Him) - Quran 3:159",
    "لَا تَحْزَنْ إِنَّ اللَّهَ مَعَنَا (Do not grieve; indeed, Allah is with us) - Quran 9:40",
    "اللهم اجعلنا من المتقين (O Allah, make us among the righteous).",
    "اللهم ارزقنا الفردوس الأعلى (O Allah, grant us Al-Firdaws, the highest level of Jannah).",
    "اللهم اهدنا إلى صراطك المستقيم (O Allah, guide us to Your straight path).",
    "اللهم اجعلنا من الذين يحبون القرآن (O Allah, make us among those who love the Quran).",
    "اللهم اجعل القرآن شفيعًا لنا يوم القيامة (O Allah, make the Quran an intercessor for us on the Day of Judgment).",
    "اللهم أعنا على ذكرك وشكرك وحسن عبادتك (O Allah, help us to remember You, to thank You, and to worship You in the best way).",
    "رَضِيتُ بِاللَّهِ رَبًّا وَبِالإِسْلاَمِ دِينًا وَبِمُحَمَّدٍ ﷺ نَبِيًّا (I am pleased with Allah as my Lord, Islam as my religion, and Muhammad ﷺ as my Prophet)."
  ];

  int currentQuoteIndex = 0;

  void changeQuote() {
    setState(() {
      currentQuoteIndex = Random().nextInt(quotes.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            'assets/background2.png', // Ensure this image is added in assets
            fit: BoxFit.cover,
          ),

          // Overlaying Content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Text(
                        "Islamic Quote of the Day",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        quotes[currentQuoteIndex], // Display random quote
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Refresh Button
              ElevatedButton(
  onPressed: changeQuote,
  style: ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    backgroundColor: Colors.transparent, // Required for gradient
    shadowColor: Colors.transparent, // Remove default shadow
  ),
  child: Ink(
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [
          Color(0xFF13342d), // Dark Green (Left)
          Color(0xFFFFD700), // Gold (Middle-left)
          Color(0xFFFFE066), // Lighter Gold (Exact Center)
          Color(0xFFFFD700), // Gold (Middle-right)
          Color(0xFF13342d), // Dark Green (Right)
        ],
        stops: [0.0, 0.35, 0.5, 0.65, 1.0], // Smooth transition
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(20),
    ),
  child: Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: const Text(
      "New Quote",
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black, // Dark text for contrast
      ),
    ),
  ),
  ),
),

            ],
          ),
        ],
      ),
    );
  }
}
