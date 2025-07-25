import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../AudioButton.dart';
import '../boolGlobleState.dart';

class P5_S3 extends StatefulWidget {
  const P5_S3({super.key});


  @override
  State<P5_S3> createState() => _P5_S3State();
}

class _P5_S3State extends State<P5_S3> {
  late List<bool> _buttonStates;
  late List<String> _audios = [
    "audios/p5/ABJ.mp3",
    "audios/p5/HTuY.mp3",
    "audios/p5/KLM.mp3",
    "audios/p5/NSAi.mp3",
    "audios/p5/SKhZ.mp3",
    "audios/p5/FDQ.mp3",
    "audios/p5/RST.mp3",
    "audios/p5/WZGSh.mp3",
    "audios/p5/bsm.mp3",
    "audios/p5/tjd.mp3",
    "audios/p5/khLQ.mp3",
    "audios/p5/BLG.mp3",
    "audios/p5/TBAi.mp3",
    "audios/p5/NFS.mp3",
    "audios/p5/QTL.mp3",
    "audios/p5/ZLL.mp3",
    "audios/p5/AiLQ.mp3",
    "audios/p5/FLQ.mp3",
    "audios/p5/AiSR.mp3",
    "audios/p5/AiShR.mp3",
    "audios/p5/YLJ.mp3",
    "audios/p5/NSR.mp3",
    "audios/p5/ShkR.mp3",
    "audios/p5/QSTu.mp3",
    "audios/p5/JNT.mp3",
    "audios/p5/GBR.mp3",
    "audios/p5/THT.mp3",
    "audios/p5/YJB.mp3",
    "audios/p5/ShMS.mp3",
    "audios/p5/SFT.mp3",
    "audios/p5/MTR.mp3",
    "audios/p5/KhShY.mp3",

    "audios/p5/3FFAi.mp3",

    "audios/p5/3MAiM.mp3",
    "audios/p5/2FA.mp3",
    "audios/p5/3YWY.mp3",
    "audios/p5/2F-A.mp3",
    "audios/p5/3WWA.mp3",
  ];

  final audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _buttonStates = List<bool>.filled(38, false);
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
  void dispose() {
    // TODO: implement dispose
    audioPlayer.dispose();
    BoolState.setOneButtonRunning(false);
    BoolState.setOneStreamRunning(false);
    BoolState.setPlayPause(false);
    super.dispose();
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
              'assets/images/img (14).jpg',
              fit: BoxFit.fill,
            ),
          ),

          /// -------------------------------------------------------------------------------------- row 1   188

          /// alif

          AudioButtonWidget(
            buttonState: _buttonStates[0],
            audio: _audios[0],
            top: 0.055,
            left: 0.817,
            width: .145,
            heigt: .095,
          ),

          /// LA
          AudioButtonWidget(
            buttonState: _buttonStates[1],
            audio: _audios[1],
            top: 0.055,
            left: 0.660,
            width: .145,
            heigt: .095,
          ),

          /// taa

          AudioButtonWidget(
            buttonState: _buttonStates[2],
            audio: _audios[2],
            top: 0.055,
            left: 0.505,
            width: .145,
            heigt: .095,
          ),

          /// saa

          AudioButtonWidget(
            buttonState: _buttonStates[3],
            audio: _audios[3],
            top: 0.055,
            left: 0.350,
            width: .145,
            heigt: .095,
          ),

          /// jeem

          AudioButtonWidget(
            buttonState: _buttonStates[4],
            audio: _audios[4],
            top: 0.055,
            left: 0.195,
            width: .145,
            heigt: .095,
          ),


          AudioButtonWidget(
            buttonState: _buttonStates[5],
            audio: _audios[5],
            top: 0.055,
            left: 0.040,
            width: .145,
            heigt: .095,
          ),
          /// ------------------------------------------------------------------------------------------ row 2


          /// daal

          AudioButtonWidget(
            buttonState: _buttonStates[6],
            audio: _audios[6],
            top: 0.157,
            left: 0.505,
            width: .199,
            heigt: .090,
          ),

          /// zaal

          AudioButtonWidget(
            buttonState: _buttonStates[7],
            audio: _audios[7],
            top: 0.157,
            left: 0.2950,
            width: .199,
            heigt: .090,
          ),

          /// raa



          /// ------------------------------------------------------------------------------------------ row 3
          ///
          /// zaa

          AudioButtonWidget(
            buttonState: _buttonStates[8],
            audio: _audios[8],
            top: 0.253,
            left: 0.817,
            width: .145,
            heigt: .095,
          ),

          /// seen
          AudioButtonWidget(
            buttonState: _buttonStates[9],
            audio: _audios[9],
            top: 0.253,
            left: 0.660,
            width: .145,
            heigt: .095,
          ),

          /// sheen

          AudioButtonWidget(
            buttonState: _buttonStates[10],
            audio: _audios[10],
            top: 0.253,
            left: 0.505,
            width: .145,
            heigt: .095,
          ),

          /// suad
          AudioButtonWidget(
            buttonState: _buttonStates[11],
            audio: _audios[11],
            top: 0.253,
            left: 0.350,
            width: .145,
            heigt: .095,
          ),

          /// duad
          AudioButtonWidget(
            buttonState: _buttonStates[12],
            audio: _audios[12],
            top: 0.253,
            left: 0.195,
            width: .145,
            heigt: .095,
          ),

          /// duad
          AudioButtonWidget(
            buttonState: _buttonStates[13],
            audio: _audios[13],
            top: 0.253,
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
            buttonState: _buttonStates[14],
            audio: _audios[14],
            top: 0.353,
            left: 0.817,
            width: .145,
            heigt: .095,
          ),

          /// zuaa

          AudioButtonWidget(
            buttonState: _buttonStates[15],
            audio: _audios[15],
            top: 0.353,
            left: 0.660,
            width: .145,
            heigt: .095,
          ),

          /// aain
          AudioButtonWidget(
            buttonState: _buttonStates[16],
            audio: _audios[16],
            top: 0.353,
            left: 0.505,
            width: .145,
            heigt: .095,
          ),

          /// gaain
          AudioButtonWidget(
            buttonState: _buttonStates[17],
            audio: _audios[17],
            top: 0.353,
            left: 0.350,
            width: .145,
            heigt: .095,
          ),

          /// faa
          AudioButtonWidget(
            buttonState: _buttonStates[18],
            audio: _audios[18],
            top: 0.353,
            left: 0.195,
            width: .145,
            heigt: .095,
          ),


          /// faa
          AudioButtonWidget(
            buttonState: _buttonStates[19],
            audio: _audios[19],
            top: 0.353,
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
            buttonState: _buttonStates[20],
            audio: _audios[20],
            top: 0.453,
            left: 0.817,
            width: .145,
            heigt: .095,
          ),

          /// kaaf
          AudioButtonWidget(
            buttonState: _buttonStates[21],
            audio: _audios[21],
            top: 0.453,
            left: 0.660,
            width: .145,
            heigt: .095,
          ),

          /// laam
          AudioButtonWidget(
            buttonState: _buttonStates[22],
            audio: _audios[22],
            top: 0.453,
            left: 0.505,
            width: .145,
            heigt: .095,
          ),

          /// meem
          AudioButtonWidget(
            buttonState: _buttonStates[23],
            audio: _audios[23],
            top: 0.453,
            left: 0.350,
            width: .145,
            heigt: .095,
          ),

          /// noon

          AudioButtonWidget(
            buttonState: _buttonStates[24],
            audio: _audios[24],
            top: 0.453,
            left: 0.195,
            width: .145,
            heigt: .095,
          ),

          /// noon

          AudioButtonWidget(
            buttonState: _buttonStates[25],
            audio: _audios[25],
            top: 0.453,
            left: 0.04,
            width: .145,
            heigt: .095,
          ),

          ///
          /// ------------------------------------------------------------------------------------------ row 6

          /// waw

          AudioButtonWidget(
            buttonState: _buttonStates[26],
            audio: _audios[26],
            top: 0.553,
            left: 0.817,
            width: .145,
            heigt: .095,
          ),

          /// haa
          AudioButtonWidget(
            buttonState: _buttonStates[27],
            audio: _audios[27],
            top: 0.553,
            left: 0.660,
            width: .145,
            heigt: .095,
          ),

          /// hamza
          AudioButtonWidget(
            buttonState: _buttonStates[28],
            audio: _audios[28],
            top: 0.553,
            left: 0.505,
            width: .145,
            heigt: .095,
          ),

          /// yaa

          AudioButtonWidget(
            buttonState: _buttonStates[29],
            audio: _audios[29],
            top: 0.553,
            left: 0.350,
            width: .145,
            heigt: .095,
          ),

          /// yaa

          AudioButtonWidget(
            buttonState: _buttonStates[30],
            audio: _audios[30],
            top: 0.553,
            left: 0.195,
            width: .145,
            heigt: .095,
          ),


          /// yaa

          AudioButtonWidget(
            buttonState: _buttonStates[31],
            audio: _audios[31],
            top: 0.553,
            left: 0.04,
            width: .145,
            heigt: .095,
          ),


          ///
          /// ------------------------------------------------------------------------------------------ row 6

          /// waw

          AudioButtonWidget(
            buttonState: _buttonStates[32],
            audio: _audios[32],
            top: 0.653,
            left: 0.505,
            width: .455,
            heigt: .095,
          ),

          /// haa
          AudioButtonWidget(
            buttonState: _buttonStates[33],
            audio: _audios[33],
            top: 0.653,
            left: 0.040,
            width: .455,
            heigt: .095,
          ),

          ///
          /// ------------------------------------------------------------------------------------------ row 6

          /// waw

          AudioButtonWidget(
            buttonState: _buttonStates[34],
            audio: _audios[34],
            top: 0.753,
            left: 0.505,
            width: .455,
            heigt: .095,
          ),

          /// haa
          AudioButtonWidget(
            buttonState: _buttonStates[35],
            audio: _audios[35],
            top: 0.753,
            left: 0.040,
            width: .455,
            heigt: .095,
          ),


          ///
          /// ------------------------------------------------------------------------------------------ row 6

          /// waw

          AudioButtonWidget(
            buttonState: _buttonStates[36],
            audio: _audios[36],
            top: 0.853,
            left: 0.505,
            width: .455,
            heigt: .095,
          ),

          /// haa
          AudioButtonWidget(
            buttonState: _buttonStates[37],
            audio: _audios[37],
            top: 0.853,
            left: 0.040,
            width: .455,
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


