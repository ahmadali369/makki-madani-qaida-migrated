import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../AudioButton.dart';
import '../boolGlobleState.dart';

class P6_S4 extends StatefulWidget {
  const P6_S4({super.key});


  @override
  State<P6_S4> createState() => _P6_S4State();
}

class _P6_S4State extends State<P6_S4> {
  late List<bool> _buttonStates;
  late List<String> _audios = [
    "audios/p6/a.mp3",
    "audios/p6/b.mp3",
    "audios/p6/t.mp3",
    "audios/p6/sa.mp3",
    "audios/p6/ja.mp3",
    "audios/p6/ha.mp3",
    "audios/p6/kh.mp3",
    "audios/p6/dal.mp3",
    "audios/p6/zal.mp3",
    "audios/p6/ra.mp3",
    "audios/p6/za.mp3",
    "audios/p6/sin.mp3",
    "audios/p6/shin.mp3",
    "audios/p6/sad.mp3",
    "audios/p6/dad.mp3",
    "audios/p6/tua.mp3",
    "audios/p6/zua.mp3",
    "audios/p6/ain.mp3",
    "audios/p6/gin.mp3",
    "audios/p6/fa.mp3",
    "audios/p6/qaf.mp3",
    "audios/p6/kaf.mp3",
    "audios/p6/lam.mp3",
    "audios/p6/mim.mp3",
    "audios/p6/nun.mp3",
    "audios/p6/wao.mp3",
    "audios/p6/hha.mp3",
    "audios/p6/hm.mp3",
    "audios/p6/ya.mp3",




  ];

  final audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _buttonStates = List<bool>.filled(29, false);
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
              'assets/images/img (15).jpg',
              fit: BoxFit.fill,
            ),
          ),


          /// ------------------------------------------------------------------------------------------ row 2

          /// J-A

          AudioButtonWidget(
            buttonState: _buttonStates[0],
            audio: _audios[0],
            top: 0.460,
            left: 0.817,
            width: .145,
            heigt: .089,
          ),

          /// khaa

          AudioButtonWidget(
            buttonState: _buttonStates[1],
            audio: _audios[1],
            top: 0.460,
            left: 0.660,
            width: .145,
            heigt: .089,
          ),

          /// daal

          AudioButtonWidget(
            buttonState: _buttonStates[2],
            audio: _audios[2],
            top: 0.460,
            left: 0.505,
            width: .145,
            heigt: .089,
          ),

          /// zaal

          AudioButtonWidget(
            buttonState: _buttonStates[3],
            audio: _audios[3],
            top: 0.460,
            left: 0.350,
            width: .145,
            heigt: .089,
          ),

          /// raa

          AudioButtonWidget(
            buttonState: _buttonStates[4],
            audio: _audios[4],
            top: 0.460,
            left: 0.195,
            width: .145,
            heigt: .089,
          ),

          /// raa

          AudioButtonWidget(
            buttonState: _buttonStates[5],
            audio: _audios[5],
            top: 0.460,
            left: 0.040,
            width: .145,
            heigt: .089,
          ),

          /// ------------------------------------------------------------------------------------------ row 3
          ///
          /// zaa

          AudioButtonWidget(
            buttonState: _buttonStates[6],
            audio: _audios[6],
            top: 0.556,
            left: 0.817,
            width: .145,
            heigt: .089,
          ),

          /// seen
          AudioButtonWidget(
            buttonState: _buttonStates[7],
            audio: _audios[7],
            top: 0.556,
            left: 0.660,
            width: .145,
            heigt: .089,
          ),

          /// sheen

          AudioButtonWidget(
            buttonState: _buttonStates[8],
            audio: _audios[8],
            top: 0.556,
            left: 0.505,
            width: .145,
            heigt: .089,
          ),

          /// suad
          AudioButtonWidget(
            buttonState: _buttonStates[9],
            audio: _audios[9],
            top: 0.556,
            left: 0.350,
            width: .145,
            heigt: .089,
          ),

          /// duad
          AudioButtonWidget(
            buttonState: _buttonStates[10],
            audio: _audios[10],
            top: 0.556,
            left: 0.195,
            width: .145,
            heigt: .089,
          ),

          /// duad
          AudioButtonWidget(
            buttonState: _buttonStates[11],
            audio: _audios[11],
            top: 0.556,
            left: 0.040,
            width: .145,
            heigt: .089,
          ),

          ///
          ///
          /// ------------------------------------------------------------------------------------------ row 4
          ///
          /// ttaa
          AudioButtonWidget(
            buttonState: _buttonStates[12],
            audio: _audios[12],
            top: 0.656,
            left: 0.817,
            width: .145,
            heigt: .089,
          ),

          /// zuaa

          AudioButtonWidget(
            buttonState: _buttonStates[13],
            audio: _audios[13],
            top: 0.656,
            left: 0.660,
            width: .145,
            heigt: .089,
          ),

          /// aain
          AudioButtonWidget(
            buttonState: _buttonStates[14],
            audio: _audios[14],
            top: 0.656,
            left: 0.505,
            width: .145,
            heigt: .089,
          ),

          /// gaain
          AudioButtonWidget(
            buttonState: _buttonStates[15],
            audio: _audios[15],
            top: 0.656,
            left: 0.350,
            width: .145,
            heigt: .089,
          ),

          /// faa
          AudioButtonWidget(
            buttonState: _buttonStates[16],
            audio: _audios[16],
            top: 0.656,
            left: 0.195,
            width: .145,
            heigt: .089,
          ),


          /// faa
          AudioButtonWidget(
            buttonState: _buttonStates[17],
            audio: _audios[17],
            top: 0.656,
            left: 0.040,
            width: .145,
            heigt: .089,
          ),
          ///
          ///
          /// ------------------------------------------------------------------------------------------ row 5
          ///
          /// Qaaf

          AudioButtonWidget(
            buttonState: _buttonStates[18],
            audio: _audios[18],
            top: 0.753,
            left: 0.817,
            width: .145,
            heigt: .089,
          ),

          /// kaaf
          AudioButtonWidget(
            buttonState: _buttonStates[19],
            audio: _audios[19],
            top: 0.753,
            left: 0.660,
            width: .145,
            heigt: .089,
          ),

          /// laam
          AudioButtonWidget(
            buttonState: _buttonStates[20],
            audio: _audios[20],
            top: 0.753,
            left: 0.505,
            width: .145,
            heigt: .089,
          ),

          /// meem
          AudioButtonWidget(
            buttonState: _buttonStates[21],
            audio: _audios[21],
            top: 0.753,
            left: 0.350,
            width: .145,
            heigt: .089,
          ),

          /// noon

          AudioButtonWidget(
            buttonState: _buttonStates[22],
            audio: _audios[22],
            top: 0.753,
            left: 0.195,
            width: .145,
            heigt: .089,
          ),

          /// noon

          AudioButtonWidget(
            buttonState: _buttonStates[23],
            audio: _audios[23],
            top: 0.753,
            left: 0.04,
            width: .145,
            heigt: .089,
          ),

          ///
          /// ------------------------------------------------------------------------------------------ row 6



          /// haa
          AudioButtonWidget(
            buttonState: _buttonStates[24],
            audio: _audios[24],
            top: 0.850,
            left: 0.739,
            width: .145,
            heigt: .089,
          ),

          /// hamza
          AudioButtonWidget(
            buttonState: _buttonStates[25],
            audio: _audios[25],
            top: 0.850,
            left: 0.585,
            width: .145,
            heigt: .089,
          ),

          /// yaa

          AudioButtonWidget(
            buttonState: _buttonStates[26],
            audio: _audios[26],
            top: 0.850,
            left: 0.428,
            width: .145,
            heigt: .089,
          ),

          /// yaa

          AudioButtonWidget(
            buttonState: _buttonStates[27],
            audio: _audios[27],
            top: 0.850,
            left: 0.275,
            width: .145,
            heigt: .089,
          ),


          /// yaa

          AudioButtonWidget(
            buttonState: _buttonStates[28],
            audio: _audios[28],
            top: 0.850,
            left: 0.120,
            width: .145,
            heigt: .089,
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


