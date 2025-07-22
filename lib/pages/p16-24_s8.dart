import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../AudioButton.dart';
import '../boolGlobleState.dart';

class P16_S8 extends StatefulWidget {
  const P16_S8({super.key});


  @override
  State<P16_S8> createState() => _P16_S8State();
}

class _P16_S8State extends State<P16_S8> {
  late List<bool> _buttonStates;
  late List<String> _audios = [
    "audios/p1/Alif.mp3",
    "audios/p3/lamAlif.mp3",
    "audios/p3/baAlif.mp3",
    "audios/p3/taAlif.mp3",
    "audios/p3/lamAlif.mp3",
    "audios/p3/yaAlif.mp3",
    "audios/p3/jimAlif.mp3",
    "audios/p3/khaAlif.mp3",
    "audios/p3/seenAlif.mp3",
    "audios/p3/dadAlif.mp3",
    "audios/p3/tuaAlif.mp3",
    "audios/p3/faaAlif.mp3",
    "audios/p3/AinAlif.mp3",
    "audios/p3/miimAlif.mp3",
    "audios/p3/HhaAlif.mp3",
    "audios/p3/kafAlif.mp3",
    "audios/p3/qafAlif.mp3",
    "audios/p3/lamBa.mp3",
    "audios/p3/AinLam.mp3",
    "audios/p3/kafLam.mp3",
    "audios/p3/qafLam.mp3",

    /// ----------------


    "audios/p3/tuaBa.mp3",
    "audios/p3/kafSa.mp3",
    "audios/p3/kafNun.mp3",
    "audios/p3/baShin.mp3",
    "audios/p3/nunShin.mp3",
    "audios/p3/saSin.mp3",
    "audios/p3/qafTua.mp3",
    "audios/p3/gainTa.mp3",
    "audios/p3/dadZua.mp3",
    "audios/p3/baRa.mp3",
    "audios/p3/haRa.mp3",
    "audios/p3/zuaRa.mp3",
    "audios/p3/jimDal.mp3",
    "audios/p3/ainDal.mp3",
    "audios/p3/kafWao.mp3",


  ];

  final audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _buttonStates = List<bool>.filled(36, false);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    audioPlayer.dispose();
    BoolState.setOneButtonRunning(false);
    BoolState.setOneStreamRunning(false);
    BoolState.setPlayPause(false);
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
              'assets/images/img (25).jpg',
              fit: BoxFit.fill,
            ),
          ),

          /// -------------------------------------------------------------------------------------- row 1   188

          /// alif

          AudioButtonWidget(
            buttonState: _buttonStates[0],
            audio: _audios[0],
            top: 0.340,
            left: 0.817,
            width: .145,
            heigt: .095,
          ),

          /// LA
          AudioButtonWidget(
            buttonState: _buttonStates[1],
            audio: _audios[1],
            top: 0.340,
            left: 0.660,
            width: .145,
            heigt: .095,
          ),

          /// taa

          AudioButtonWidget(
            buttonState: _buttonStates[2],
            audio: _audios[2],
            top: 0.340,
            left: 0.505,
            width: .145,
            heigt: .095,
          ),

          /// saa

          AudioButtonWidget(
            buttonState: _buttonStates[3],
            audio: _audios[3],
            top: 0.340,
            left: 0.350,
            width: .145,
            heigt: .095,
          ),

          /// jeem

          AudioButtonWidget(
            buttonState: _buttonStates[4],
            audio: _audios[4],
            top: 0.340,
            left: 0.195,
            width: .145,
            heigt: .095,
          ),


          AudioButtonWidget(
            buttonState: _buttonStates[5],
            audio: _audios[5],
            top: 0.340,
            left: 0.040,
            width: .145,
            heigt: .095,
          ),
          /// ------------------------------------------------------------------------------------------ row 2

          /// J-A

          AudioButtonWidget(
            buttonState: _buttonStates[6],
            audio: _audios[6],
            top: 0.440,
            left: 0.817,
            width: .145,
            heigt: .095,
          ),

          /// khaa

          AudioButtonWidget(
            buttonState: _buttonStates[7],
            audio: _audios[7],
            top: 0.440,
            left: 0.660,
            width: .145,
            heigt: .095,
          ),

          /// daal

          AudioButtonWidget(
            buttonState: _buttonStates[8],
            audio: _audios[8],
            top: 0.440,
            left: 0.505,
            width: .145,
            heigt: .095,
          ),

          /// zaal

          AudioButtonWidget(
            buttonState: _buttonStates[9],
            audio: _audios[9],
            top: 0.440,
            left: 0.350,
            width: .145,
            heigt: .095,
          ),

          /// raa

          AudioButtonWidget(
            buttonState: _buttonStates[10],
            audio: _audios[10],
            top: 0.440,
            left: 0.195,
            width: .145,
            heigt: .095,
          ),

          /// raa

          AudioButtonWidget(
            buttonState: _buttonStates[11],
            audio: _audios[11],
            top: 0.440,
            left: 0.040,
            width: .145,
            heigt: .095,
          ),

          /// ------------------------------------------------------------------------------------------ row 3
          ///
          /// zaa

          AudioButtonWidget(
            buttonState: _buttonStates[12],
            audio: _audios[12],
            top: 0.543,
            left: 0.817,
            width: .145,
            heigt: .095,
          ),

          /// seen
          AudioButtonWidget(
            buttonState: _buttonStates[13],
            audio: _audios[13],
            top: 0.543,
            left: 0.660,
            width: .145,
            heigt: .095,
          ),

          /// sheen

          AudioButtonWidget(
            buttonState: _buttonStates[14],
            audio: _audios[14],
            top: 0.543,
            left: 0.505,
            width: .145,
            heigt: .095,
          ),

          /// suad
          AudioButtonWidget(
            buttonState: _buttonStates[15],
            audio: _audios[15],
            top: 0.543,
            left: 0.350,
            width: .145,
            heigt: .095,
          ),

          /// duad
          AudioButtonWidget(
            buttonState: _buttonStates[16],
            audio: _audios[16],
            top: 0.543,
            left: 0.195,
            width: .145,
            heigt: .095,
          ),

          /// duad
          AudioButtonWidget(
            buttonState: _buttonStates[17],
            audio: _audios[17],
            top: 0.543,
            left: 0.040,
            width: .145,
            heigt: .095,
          ),

          ///
          ///
          /// ------------------------------------------------------------------------------------------ row 4
          ///
          /// ttaa
          AudioButtonWidget(
            buttonState: _buttonStates[18],
            audio: _audios[18],
            top: 0.645,
            left: 0.817,
            width: .145,
            heigt: .095,
          ),

          /// zuaa

          AudioButtonWidget(
            buttonState: _buttonStates[19],
            audio: _audios[19],
            top: 0.645,
            left: 0.660,
            width: .145,
            heigt: .095,
          ),

          /// aain
          AudioButtonWidget(
            buttonState: _buttonStates[20],
            audio: _audios[20],
            top: 0.645,
            left: 0.505,
            width: .145,
            heigt: .095,
          ),

          /// gaain
          AudioButtonWidget(
            buttonState: _buttonStates[21],
            audio: _audios[21],
            top: 0.645,
            left: 0.350,
            width: .145,
            heigt: .095,
          ),

          /// faa
          AudioButtonWidget(
            buttonState: _buttonStates[22],
            audio: _audios[22],
            top: 0.645,
            left: 0.195,
            width: .145,
            heigt: .095,
          ),


          /// faa
          AudioButtonWidget(
            buttonState: _buttonStates[23],
            audio: _audios[23],
            top: 0.645,
            left: 0.040,
            width: .145,
            heigt: .095,
          ),
          ///
          ///
          /// ------------------------------------------------------------------------------------------ row 5
          ///
          /// Qaaf

          AudioButtonWidget(
            buttonState: _buttonStates[24],
            audio: _audios[24],
            top: 0.746,
            left: 0.817,
            width: .145,
            heigt: .095,
          ),

          /// kaaf
          AudioButtonWidget(
            buttonState: _buttonStates[25],
            audio: _audios[25],
            top: 0.746,
            left: 0.660,
            width: .145,
            heigt: .095,
          ),

          /// laam
          AudioButtonWidget(
            buttonState: _buttonStates[26],
            audio: _audios[26],
            top: 0.746,
            left: 0.505,
            width: .145,
            heigt: .095,
          ),

          /// meem
          AudioButtonWidget(
            buttonState: _buttonStates[27],
            audio: _audios[27],
            top: 0.746,
            left: 0.350,
            width: .145,
            heigt: .095,
          ),

          /// noon

          AudioButtonWidget(
            buttonState: _buttonStates[28],
            audio: _audios[28],
            top: 0.746,
            left: 0.195,
            width: .145,
            heigt: .095,
          ),

          /// noon

          AudioButtonWidget(
            buttonState: _buttonStates[29],
            audio: _audios[29],
            top: 0.746,
            left: 0.04,
            width: .145,
            heigt: .095,
          ),

          ///
          /// ------------------------------------------------------------------------------------------ row 6

          /// waw

          AudioButtonWidget(
            buttonState: _buttonStates[30],
            audio: _audios[30],
            top: 0.850,
            left: 0.817,
            width: .145,
            heigt: .095,
          ),

          /// haa
          AudioButtonWidget(
            buttonState: _buttonStates[31],
            audio: _audios[31],
            top: 0.850,
            left: 0.660,
            width: .145,
            heigt: .095,
          ),

          /// hamza
          AudioButtonWidget(
            buttonState: _buttonStates[32],
            audio: _audios[32],
            top: 0.850,
            left: 0.505,
            width: .145,
            heigt: .095,
          ),

          /// yaa

          AudioButtonWidget(
            buttonState: _buttonStates[33],
            audio: _audios[33],
            top: 0.850,
            left: 0.350,
            width: .145,
            heigt: .095,
          ),

          /// yaa

          AudioButtonWidget(
            buttonState: _buttonStates[34],
            audio: _audios[34],
            top: 0.850,
            left: 0.195,
            width: .145,
            heigt: .095,
          ),


          /// yaa

          AudioButtonWidget(
            buttonState: _buttonStates[35],
            audio: _audios[35],
            top: 0.850,
            left: 0.04,
            width: .145,
            heigt: .095,
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


