import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../AudioButton.dart';
import '../boolGlobleState.dart';

class P3_S3 extends StatefulWidget {
  const P3_S3({super.key});


  @override
  State<P3_S3> createState() => _P1_S1State();
}

class _P1_S1State extends State<P3_S3> {
  late List<bool> _buttonStates;
  late List<String> _audios = [
    "audios/p1/Alif.mp3",
    "audios/p1/Baa.mp3",
    "audios/p1/Taa.mp3",
    "audios/p1/Saa.mp3",
    "audios/p1/Jeem.mp3",
    "audios/p1/Haa.mp3",
    "audios/p1/Khaa.mp3",
    "audios/p1/Daal.mp3",
    "audios/p1/zaal.mp3",
    "audios/p1/raa.mp3",
    "audios/p1/zaa.mp3",
    "audios/p1/seen.mp3",
    "audios/p1/sheen.mp3",
    "audios/p1/saad.mp3",
    "audios/p1/daad.mp3",
    "audios/p1/tuaa.mp3",
    "audios/p1/zuaa.mp3",
    "audios/p1/aain.mp3",
    "audios/p1/gaain.mp3",
    "audios/p1/faa.mp3",
    "audios/p1/qaaf.mp3",
    "audios/p1/kaaf.mp3",
    "audios/p1/laam.mp3",
    "audios/p1/meem.mp3",
    "audios/p1/noon.mp3",
    "audios/p1/wow.mp3",
    "audios/p1/hhaa.mp3",
    "audios/p1/hamza.mp3",
    "audios/p1/yaa.mp3",

  ];

  final audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _buttonStates = List<bool>.filled(29, false);
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
              'assets/images/img (12).jpg',
              fit: BoxFit.fill,
            ),
          ),

          /// -------------------------------------------------------------------------------------- row 1   188

          /// alif

          AudioButtonWidget(
            buttonState: _buttonStates[0],
            audio: _audios[0],
            top: 0.427,
            left: 0.790,
            width: .172,
            heigt: .075,
          ),

          /// baa
          AudioButtonWidget(
            buttonState: _buttonStates[1],
            audio: _audios[1],
            top: 0.427,
            left: 0.602,
            width: .172,
            heigt: .075,
          ),

          /// taa

          AudioButtonWidget(
            buttonState: _buttonStates[2],
            audio: _audios[2],
            top: 0.427,
            left: 0.414,
            width: .172,
            heigt: .075,
          ),

          /// saa

          AudioButtonWidget(
            buttonState: _buttonStates[3],
            audio: _audios[3],
            top: 0.427,
            left: 0.226,
            width: .172,
            heigt: .075,
          ),

          /// jeem

          AudioButtonWidget(
            buttonState: _buttonStates[4],
            audio: _audios[4],
            top: 0.427,
            left: 0.038,
            width: .172,
            heigt: .075,
          ),

          /// ------------------------------------------------------------------------------------------ row 2

          /// haa

          AudioButtonWidget(
            buttonState: _buttonStates[5],
            audio: _audios[5],
            top: 0.515,
            left: 0.790,
            width: .172,
            heigt: .075,
          ),

          /// khaa

          AudioButtonWidget(
            buttonState: _buttonStates[6],
            audio: _audios[6],
            top: 0.515,
            left: 0.602,
            width: .172,
            heigt: .075,
          ),

          /// daal

          AudioButtonWidget(
            buttonState: _buttonStates[7],
            audio: _audios[7],
            top: 0.515,
            left: 0.414,
            width: .172,
            heigt: .075,
          ),

          /// zaal

          AudioButtonWidget(
            buttonState: _buttonStates[8],
            audio: _audios[8],
            top: 0.515,
            left: 0.226,
            width: .172,
            heigt: .075,
          ),

          /// raa

          AudioButtonWidget(
            buttonState: _buttonStates[9],
            audio: _audios[9],
            top: 0.515,
            left: 0.038,
            width: .172,
            heigt: .075,
          ),

          /// ------------------------------------------------------------------------------------------ row 3
          ///
          /// zaa

          AudioButtonWidget(
            buttonState: _buttonStates[10],
            audio: _audios[10],
            top: 0.603,
            left: 0.790,
            width: .172,
            heigt: .075,
          ),

          /// seen
          AudioButtonWidget(
            buttonState: _buttonStates[11],
            audio: _audios[11],
            top: 0.603,
            left: 0.602,
            width: .172,
            heigt: .075,
          ),

          /// sheen

          AudioButtonWidget(
            buttonState: _buttonStates[12],
            audio: _audios[12],
            top: 0.603,
            left: 0.414,
            width: .172,
            heigt: .075,
          ),

          /// suad
          AudioButtonWidget(
            buttonState: _buttonStates[13],
            audio: _audios[13],
            top: 0.603,
            left: 0.226,
            width: .172,
            heigt: .075,
          ),

          /// duad
          AudioButtonWidget(
            buttonState: _buttonStates[14],
            audio: _audios[14],
            top: 0.603,
            left: 0.038,
            width: .172,
            heigt: .075,
          ),

          ///
          ///
          /// ------------------------------------------------------------------------------------------ row 4
          ///
          /// ttaa
          AudioButtonWidget(
            buttonState: _buttonStates[15],
            audio: _audios[15],
            top: 0.691,
            left: 0.790,
            width: .172,
            heigt: .075,
          ),

          /// zuaa

          AudioButtonWidget(
            buttonState: _buttonStates[16],
            audio: _audios[16],
            top: 0.691,
            left: 0.602,
            width: .172,
            heigt: .075,
          ),

          /// aain
          AudioButtonWidget(
            buttonState: _buttonStates[17],
            audio: _audios[17],
            top: 0.691,
            left: 0.414,
            width: .172,
            heigt: .075,
          ),

          /// gaain
          AudioButtonWidget(
            buttonState: _buttonStates[18],
            audio: _audios[18],
            top: 0.691,
            left: 0.226,
            width: .172,
            heigt: .075,
          ),

          /// faa
          AudioButtonWidget(
            buttonState: _buttonStates[19],
            audio: _audios[19],
            top: 0.691,
            left: 0.038,
            width: .172,
            heigt: .075,
          ),

          ///
          ///
          /// ------------------------------------------------------------------------------------------ row 5
          ///
          /// Qaaf

          AudioButtonWidget(
            buttonState: _buttonStates[20],
            audio: _audios[20],
            top: 0.779,
            left: 0.790,
            width: .172,
            heigt: .075,
          ),

          /// kaaf
          AudioButtonWidget(
            buttonState: _buttonStates[21],
            audio: _audios[21],
            top: 0.779,
            left: 0.602,
            width: .172,
            heigt: .075,
          ),

          /// laam
          AudioButtonWidget(
            buttonState: _buttonStates[22],
            audio: _audios[22],
            top: 0.779,
            left: 0.414,
            width: .172,
            heigt: .075,
          ),

          /// meem
          AudioButtonWidget(
            buttonState: _buttonStates[23],
            audio: _audios[23],
            top: 0.779,
            left: 0.226,
            width: .172,
            heigt: .075,
          ),

          /// noon

          AudioButtonWidget(
            buttonState: _buttonStates[24],
            audio: _audios[24],
            top: 0.779,
            left: 0.038,
            width: .172,
            heigt: .075,
          ),

          ///
          /// ------------------------------------------------------------------------------------------ row 6

          /// waw

          AudioButtonWidget(
            buttonState: _buttonStates[25],
            audio: _audios[25],
            top: 0.867,
            left: 0.699,
            width: .172,
            heigt: .075,
          ),

          /// haa
          AudioButtonWidget(
            buttonState: _buttonStates[26],
            audio: _audios[26],
            top: 0.867,
            left: 0.509,
            width: .172,
            heigt: .075,
          ),

          /// hamza
          AudioButtonWidget(
            buttonState: _buttonStates[27],
            audio: _audios[27],
            top: 0.867,
            left: 0.320,
            width: .172,
            heigt: .075,
          ),

          /// yaa

          AudioButtonWidget(
            buttonState: _buttonStates[28],
            audio: _audios[28],
            top: 0.867,
            left: 0.130,
            width: .172,
            heigt: .075,
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


