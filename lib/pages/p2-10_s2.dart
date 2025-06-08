import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../AudioButton.dart';
import '../boolGlobleState.dart';

class P2_S2 extends StatefulWidget {
  const P2_S2({super.key});


  @override
  State<P2_S2> createState() => _P1_S1State();
}

class _P1_S1State extends State<P2_S2> {
  late List<bool> _buttonStates;
  late List<String> _audios = [
    "audios/p1/Baa.mp3",
    "audios/p1/Taa.mp3",
    "audios/p1/Saa.mp3",
    "audios/p1/Jeem.mp3",
    "audios/p1/Haa.mp3",
    "audios/p1/Khaa.mp3",
    "audios/p1/Daal.mp3",
    "audios/p1/zaal.mp3",
    "audios/p1/zaa.mp3",
    "audios/p1/seen.mp3",
    "audios/p1/sheen.mp3",
    "audios/p1/saad.mp3",
    "audios/p1/daad.mp3",
    "audios/p1/aain.mp3",
    "audios/p1/gaain.mp3",
    "audios/p1/faa.mp3",
    "audios/p1/qaaf.mp3",
    "audios/p1/kaaf.mp3",
    "audios/p1/laam.mp3",
    "audios/p1/meem.mp3",
    "audios/p1/noon.mp3",
    "audios/p1/hhaa.mp3",
    "audios/p1/raa.mp3",
    "audios/p1/yaa.mp3",


    // "audios/p1/tuaa.mp3",
    // "audios/p1/zuaa.mp3",
    //
    // "audios/p1/wow.mp3",
    // "audios/p1/hamza.mp3",



    "audios/p2/baa-daal.mp3",
    "audios/p2/saad-baa.mp3",
    "audios/p2/lam-meem.mp3",
    "audios/p2/hhaa_lam.mp3",
    "audios/p2/seen-dal.mp3",
    "audios/p2/sheen-raa.mp3",
    "audios/p2/kaaf-noon.mp3",
    "audios/p2/faa-baa.mp3",
    "audios/p2/khaa-tuaa.mp3",
    "audios/p2/faa-dal.mp3",
    "audios/p2/qaaf-lam.mp3",
    "audios/p2/baa-seen.mp3",
    "audios/p2/haa-jeem.mp3",
    "audios/p2/gaain-meem.mp3",




    "audios/p1/daad.mp3",

    "audios/p1/tuaa.mp3",
    "audios/p1/zuaa.mp3",
    "audios/p1/aain.mp3",
    "audios/p1/gaain.mp3",
    "audios/p1/faa.mp3",

    "audios/p1/tuaa.mp3",
    "audios/p1/zuaa.mp3",
    "audios/p1/aain.mp3",
    "audios/p1/gaain.mp3",
    "audios/p1/faa.mp3",






  ];

  final audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _buttonStates = List<bool>.filled(49, false);
  }

  @override
  void dispose() {
    // Release all sources and dispose the player.
    audioPlayer.dispose();

    super.dispose();
  }


  void _triggerButton(int index) {
    setState(() {
      _buttonStates[index] = !_buttonStates[index];
    });
  }

  Future<void> _triggerButtonsSequentially() async {
    setState(() {
      BoolState.toggleOneStreamRunning();
    });

    for (int i = 0; i < _buttonStates.length; i++) {

      if(BoolState.playPause ==  true){

        _triggerButton(i);
        if (i > 0) {
          _triggerButton(i - 1); // Reset the previous button
        }

        await audioPlayer.release();
        await audioPlayer.play(AssetSource(_audios[i]));

        /// duartion
        Future<Duration?> nullableFutureDuration = audioPlayer.getDuration();
        Duration? nullableDuration = await nullableFutureDuration;
        if (nullableDuration == null) {
          throw Exception('Nullable duration is null');
        }

        await Future.delayed(nullableDuration);

        if(i == _buttonStates.length - 1){
          // Reset the last button after the loop ends
          _triggerButton(_buttonStates.length - 1);
          setState(() {
            BoolState.togglePlayPause();
          });
        }

      }else{
        if (i > 0) {
          _triggerButton(i - 1); // Reset the previous button
        }
        break;
      }
    }

    setState(() {
      BoolState.toggleOneStreamRunning();
    });



  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          // Background image

          Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              'assets/images/img (11).jpg',
              fit: BoxFit.fill,
            ),
          ),

          /// -------------------------------------------------------------------------------------- row 1   188

          /// alif

          AudioButtonWidget(
            buttonState: _buttonStates[0],
            audio: _audios[0],
            top: 0.171,
            left: 0.799,
            width: .160,
            heigt: .070,
          ),

          /// baa
          AudioButtonWidget(
            buttonState: _buttonStates[1],
            audio: _audios[1],
            top: 0.171,
            left: 0.610,
            width: .160,
            heigt: .070,
          ),

          /// taa

          AudioButtonWidget(
            buttonState: _buttonStates[2],
            audio: _audios[2],
            top: 0.171,
            left: 0.420,
            width: .160,
            heigt: .070,
          ),

          /// saa

          AudioButtonWidget(
            buttonState: _buttonStates[3],
            audio: _audios[3],
            top: 0.171,
            left: 0.231,
            width: .160,
            heigt: .070,
          ),

          /// jeem

          AudioButtonWidget(
            buttonState: _buttonStates[4],
            audio: _audios[4],
            top: 0.171,
            left: 0.040,
            width: .160,
            heigt: .070,
          ),

          /// ------------------------------------------------------------------------------------------ row 2

          /// haa

          AudioButtonWidget(
            buttonState: _buttonStates[5],
            audio: _audios[5],
            top: 0.250,
            left: 0.799,
            width: .160,
            heigt: .070,
          ),

          /// khaa

          AudioButtonWidget(
            buttonState: _buttonStates[6],
            audio: _audios[6],
            top: 0.250,

            left: 0.610,
            width: .160,
            heigt: .070,
          ),

          /// daal

          AudioButtonWidget(
            buttonState: _buttonStates[7],
            audio: _audios[7],
            top: 0.250,
            left: 0.420,
            width: .160,
            heigt: .070,
          ),

          /// zaal

          AudioButtonWidget(
            buttonState: _buttonStates[8],
            audio: _audios[8],
            top: 0.250,
            left: 0.231,
            width: .160,
            heigt: .070,
          ),

          /// raa

          AudioButtonWidget(
            buttonState: _buttonStates[9],
            audio: _audios[9],
            top: 0.250,
            left: 0.040,
            width: .160,
            heigt: .070,
          ),

          /// ------------------------------------------------------------------------------------------ row 3
          ///
          /// zaa

          AudioButtonWidget(
            buttonState: _buttonStates[10],
            audio: _audios[10],
            top: 0.328,
            left: 0.799,
            width: .160,
            heigt: .070,
          ),

          /// seen
          AudioButtonWidget(
            buttonState: _buttonStates[11],
            audio: _audios[11],
            top: 0.328,

            left: 0.610,
            width: .160,
            heigt: .070,
          ),

          /// sheen

          AudioButtonWidget(
            buttonState: _buttonStates[12],
            audio: _audios[12],
            top: 0.328,

            left: 0.420,
            width: .160,
            heigt: .070,
          ),

          /// suad
          AudioButtonWidget(
            buttonState: _buttonStates[13],
            audio: _audios[13],
            top: 0.328,

            left: 0.231,
            width: .160,
            heigt: .070,
          ),

          /// duad
          AudioButtonWidget(
            buttonState: _buttonStates[14],
            audio: _audios[14],
            top: 0.328,
            left: 0.040,
            width: .160,
            heigt: .070,
          ),

          ///
          ///
          /// ------------------------------------------------------------------------------------------ row 4
          ///
          /// ttaa
          AudioButtonWidget(
            buttonState: _buttonStates[15],
            audio: _audios[15],
            top: 0.407,
            left: 0.799,
            width: .160,
            heigt: .070,
          ),

          /// zuaa

          AudioButtonWidget(
            buttonState: _buttonStates[16],
            audio: _audios[16],
            top: 0.407,
            left: 0.610,
            width: .160,
            heigt: .070,
          ),

          /// aain
          AudioButtonWidget(
            buttonState: _buttonStates[17],
            audio: _audios[17],
            top: 0.407,
            left: 0.420,
            width: .160,
            heigt: .070,
          ),

          /// gaain
          AudioButtonWidget(
            buttonState: _buttonStates[18],
            audio: _audios[18],
            top: 0.407,
            left: 0.231,
            width: .160,
            heigt: .070,
          ),

          /// faa
          AudioButtonWidget(
            buttonState: _buttonStates[19],
            audio: _audios[19],
            top: 0.407,
            left: 0.040,
            width: .160,
            heigt: .070,
          ),

          ///
          ///
          /// ------------------------------------------------------------------------------------------ row 5
          ///
          /// Qaaf

          AudioButtonWidget(
            buttonState: _buttonStates[20],
            audio: _audios[20],
            top: 0.486,
            left: 0.799,
            width: .160,
            heigt: .070,
          ),

          /// kaaf
          AudioButtonWidget(
            buttonState: _buttonStates[21],
            audio: _audios[21],
            top: 0.486,

            left: 0.610,
            width: .160,
            heigt: .070,
          ),

          /// laam
          AudioButtonWidget(
            buttonState: _buttonStates[22],
            audio: _audios[22],
            top: 0.486,
            left: 0.420,
            width: .160,
            heigt: .070,
          ),

          /// meem
          AudioButtonWidget(
            buttonState: _buttonStates[23],
            audio: _audios[23],
            top: 0.486,

            left: 0.231,
            width: .160,
            heigt: .070,
          ),


          /// ------------------------------------------------------------------------------------------ row 6
          /// ------------------------------------------------------------------------------------------ row 6


          /// noon

          AudioButtonWidget(
            buttonState: _buttonStates[24],
            audio: _audios[24],
            top: 0.600,
            left: 0.800,
            width: .160,
            heigt: .061,
          ),


          /// waw

          AudioButtonWidget(
            buttonState: _buttonStates[25],
            audio: _audios[25],
            top: 0.600,
            left: 0.612,
            width: .160,
            heigt: .061,
          ),

          /// haa
          AudioButtonWidget(
            buttonState: _buttonStates[26],
            audio: _audios[26],
            top: 0.600,

            left: 0.4232,
            width: .160,
            heigt: .061,
          ),

          /// hamza
          AudioButtonWidget(
            buttonState: _buttonStates[27],
            audio: _audios[27],
            top: 0.600,

            left: 0.232,
            width: .160,
            heigt: .061,
          ),

          /// yaa

          AudioButtonWidget(
            buttonState: _buttonStates[28],
            audio: _audios[28],
            top: 0.600,

            left: 0.043,
            width: .160,
            heigt: .061,
          ),

          /// ------------------------------------------------------------------------------------------ row 7

          AudioButtonWidget(
            buttonState: _buttonStates[29],
            audio: _audios[29],
            top: 0.671,
            left: 0.800,
            width: .160,
            heigt: .061,
          ),



          /// waw

          AudioButtonWidget(
            buttonState: _buttonStates[30],
            audio: _audios[30],
            top: 0.671,

            left: 0.612,
            width: .160,
            heigt: .061,
          ),

          /// haa
          AudioButtonWidget(
            buttonState: _buttonStates[31],
            audio: _audios[31],
            top: 0.671,

            left: 0.420,
            width: .160,
            heigt: .061,
          ),

          /// hamza
          AudioButtonWidget(
            buttonState: _buttonStates[32],
            audio: _audios[32],
            top: 0.671,


            left: 0.232,
            width: .160,
            heigt: .061,
          ),

          /// yaa

          AudioButtonWidget(
            buttonState: _buttonStates[33],
            audio: _audios[33],
            top: 0.671,
            left: 0.043,
            width: .160,
            heigt: .061,
          ),



          /// ------------------------------------------------------------------------------------------ row 8
          AudioButtonWidget(
            buttonState: _buttonStates[34],
            audio: _audios[34],
            top: 0.741,
            left: 0.800,
            width: .160,
            heigt: .061,
          ),


          /// waw

          AudioButtonWidget(
            buttonState: _buttonStates[35],
            audio: _audios[35],
            top: 0.741,


            left: 0.612,
            width: .160,
            heigt: .061,
          ),

          /// haa
          AudioButtonWidget(
            buttonState: _buttonStates[36],
            audio: _audios[36],
            top: 0.741,


            left: 0.420,
            width: .160,
            heigt: .061,
          ),

          /// hamza
          AudioButtonWidget(
            buttonState: _buttonStates[37],
            audio: _audios[37],
            top: 0.741,



            left: 0.232,
            width: .160,
            heigt: .061,
          ),

          /// yaa

          AudioButtonWidget(
            buttonState: _buttonStates[38],
            audio: _audios[38],
            top: 0.741,
            left: 0.043,
            width: .160,
            heigt: .061,
          ),




          /// ------------------------------------------------------------------------------------------ row 9

          AudioButtonWidget(
            buttonState: _buttonStates[39],
            audio: _audios[39],
            top: 0.811,
            left: 0.800,
            width: .160,
            heigt: .061,
          ),


          /// waw

          AudioButtonWidget(
            buttonState: _buttonStates[40],
            audio: _audios[40],
            top: 0.811,



            left: 0.612,
            width: .160,
            heigt: .061,
          ),

          /// haa
          AudioButtonWidget(
            buttonState: _buttonStates[41],
            audio: _audios[41],
            top: 0.811,



            left: 0.420,
            width: .160,
            heigt: .061,
          ),

          /// hamza
          AudioButtonWidget(
            buttonState: _buttonStates[42],
            audio: _audios[42],
            top: 0.811,




            left: 0.232,
            width: .160,
            heigt: .061,
          ),

          /// yaa

          AudioButtonWidget(
            buttonState: _buttonStates[43],
            audio: _audios[43],
            top: 0.811,
            left: 0.043,
            width: .160,
            heigt: .061,
          ),


          /// ------------------------------------------------------------------------------------------ row 10


          AudioButtonWidget(
            buttonState: _buttonStates[44],
            audio: _audios[44],
            top: 0.880,
            left: 0.800,
            width: .160,
            heigt: .061,
          ),


          /// waw

          AudioButtonWidget(
            buttonState: _buttonStates[45],
            audio: _audios[45],
            top: 0.880,




            left: 0.612,
            width: .160,
            heigt: .061,
          ),

          /// haa
          AudioButtonWidget(
            buttonState: _buttonStates[46],
            audio: _audios[46],
            top: 0.880,




            left: 0.420,
            width: .160,
            heigt: .061,
          ),

          /// hamza
          AudioButtonWidget(
            buttonState: _buttonStates[47],
            audio: _audios[47],
            top: 0.880,


            left: 0.232,
            width: .160,
            heigt: .061,
          ),

          /// yaa

          AudioButtonWidget(
            buttonState: _buttonStates[48],
            audio: _audios[48],
            top: 0.880,

            left: 0.043,
            width: .160,
            heigt: .061,
          ),




          // Add more Positioned containers as needed.
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (BoolState.oneButtonRunning == false &&
              BoolState.oneStreamRunning == false) {
            setState(() {
              BoolState.togglePlayPause();
            });
            _triggerButtonsSequentially();


          } else {
            setState(() {
              BoolState.togglePlayPause();

            });
          }
        },
        child: Icon(
          BoolState.playPause ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}


