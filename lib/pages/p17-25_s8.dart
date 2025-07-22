import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../AudioButton.dart';
import '../boolGlobleState.dart';

class P17_S8 extends StatefulWidget {
  const P17_S8({super.key});


  @override
  State<P17_S8> createState() => _P17_S8State();
}

class _P17_S8State extends State<P17_S8> {
  late List<bool> _buttonStates;
  late List<String> _audios = [
    "audios/p4/shinQaf.mp3",
    "audios/p4/lamKaf.mp3",
    "audios/p4/faQaf.mp3",
    "audios/p4/qafKaf.mp3",
    "audios/p4/faSad.mp3",
    "audios/p4/nunSad.mp3",
    "audios/p4/baYa.mp3",
    "audios/p4/nunYa.mp3",
    "audios/p4/taYa.mp3",
    "audios/p4/yaYa.mp3",
    "audios/p4/hamzaWao.mp3",
    "audios/p4/yaHamza.mp3",
    "audios/p4/HhaWao.mp3",
    "audios/p4/mimWao.mp3",
    "audios/p4/taHha.mp3",
    "audios/p4/nunTa.mp3",
    "audios/p4/Hha.mp3",
    "audios/p4/taHha.mp3",

    "audios/p4/baMim.mp3",
    "audios/p4/baJim.mp3",
    "audios/p4/taHa.mp3",




    "audios/p4/saJim.mp3",
    "audios/p4/haJim.mp3",
    "audios/p4/lamHa.mp3",
    "audios/p4/ainJim.mp3",
    "audios/p4/nunKha.mp3",
    "audios/p4/yaHa.mp3",
    "audios/p4/SMN.mp3",

    "audios/p4/YHhB.mp3",

    "audios/p4/BHhM.mp3",
    "audios/p4/AiBD.mp3",
    "audios/p4/BAiD.mp3",
    "audios/p4/BLB.mp3",
    "audios/p4/HSN.mp3",
    "audios/p4/QSL.mp3",
    "audios/p4/BKhT.mp3",

    "audios/p4/HMD.mp3",
    "audios/p4/KhTF.mp3",
    "audios/p4/SKhTu.mp3",
    "audios/p4/BLB.mp3",
    "audios/p4/HhLK.mp3",
    "audios/p4/BKT.mp3",
    "audios/p4/TGZ.mp3",
    "audios/p4/BHhM.mp3",
    "audios/p4/FHmT.mp3",
    "audios/p4/BHhA.mp3",


    "audios/p4/YTN.mp3",
    "audios/p4/STN.mp3",
    "audios/p4/NBN.mp3",
    "audios/p4/BYL.mp3",
    "audios/p4/TNL.mp3",
    "audios/p4/NBL.mp3",

    "audios/p4/STL.mp3",
    "audios/p4/YTL.mp3",


  ];

  final audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _buttonStates = List<bool>.filled(54, false);
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
              'assets/images/img (26).jpg',
              fit: BoxFit.fill,
            ),
          ),

          /// -------------------------------------------------------------------------------------- row 1   188

          /// alif

          AudioButtonWidget(
            buttonState: _buttonStates[0],
            audio: _audios[0],
            top: 0.0597,
            left: 0.817,
            width: .145,
            heigt: .086,
          ),

          /// LA
          AudioButtonWidget(
            buttonState: _buttonStates[1],
            audio: _audios[1],
            top: 0.0597,
            left: 0.660,
            width: .145,
            heigt: .086,
          ),

          /// taa

          AudioButtonWidget(
            buttonState: _buttonStates[2],
            audio: _audios[2],
            top: 0.0597,
            left: 0.505,
            width: .145,
            heigt: .086,
          ),

          /// saa

          AudioButtonWidget(
            buttonState: _buttonStates[3],
            audio: _audios[3],
            top: 0.0597,
            left: 0.350,
            width: .145,
            heigt: .086,
          ),

          /// jeem

          AudioButtonWidget(
            buttonState: _buttonStates[4],
            audio: _audios[4],
            top: 0.0597,
            left: 0.195,
            width: .145,
            heigt: .086,
          ),


          AudioButtonWidget(
            buttonState: _buttonStates[5],
            audio: _audios[5],
            top: 0.0597,
            left: 0.040,
            width: .145,
            heigt: .086,
          ),
          /// ------------------------------------------------------------------------------------------ row 2

          /// J-A

          AudioButtonWidget(
            buttonState: _buttonStates[6],
            audio: _audios[6],
            top: 0.17,
            left: 0.817,
            width: .145,
            heigt: .086,
          ),

          /// khaa

          AudioButtonWidget(
            buttonState: _buttonStates[7],
            audio: _audios[7],
            top: 0.17,
            left: 0.660,
            width: .145,
            heigt: .086,
          ),

          /// daal

          AudioButtonWidget(
            buttonState: _buttonStates[8],
            audio: _audios[8],
            top: 0.17,
            left: 0.505,
            width: .145,
            heigt: .086,
          ),

          /// zaal

          AudioButtonWidget(
            buttonState: _buttonStates[9],
            audio: _audios[9],
            top: 0.17,
            left: 0.350,
            width: .145,
            heigt: .086,
          ),

          /// raa

          AudioButtonWidget(
            buttonState: _buttonStates[10],
            audio: _audios[10],
            top: 0.17,
            left: 0.195,
            width: .145,
            heigt: .086,
          ),

          /// raa

          AudioButtonWidget(
            buttonState: _buttonStates[11],
            audio: _audios[11],
            top: 0.17,
            left: 0.040,
            width: .145,
            heigt: .086,
          ),

          /// ------------------------------------------------------------------------------------------ row 3
          ///
          /// zaa

          AudioButtonWidget(
            buttonState: _buttonStates[12],
            audio: _audios[12],
            top: 0.285,
            left: 0.817,
            width: .145,
            heigt: .086,
          ),

          /// seen
          AudioButtonWidget(
            buttonState: _buttonStates[13],
            audio: _audios[13],
            top: 0.285,
            left: 0.660,
            width: .145,
            heigt: .086,
          ),

          /// sheen

          AudioButtonWidget(
            buttonState: _buttonStates[14],
            audio: _audios[14],
            top: 0.285,
            left: 0.505,
            width: .145,
            heigt: .086,
          ),

          /// suad
          AudioButtonWidget(
            buttonState: _buttonStates[15],
            audio: _audios[15],
            top: 0.285,
            left: 0.350,
            width: .145,
            heigt: .086,
          ),

          /// duad
          AudioButtonWidget(
            buttonState: _buttonStates[16],
            audio: _audios[16],
            top: 0.285,
            left: 0.195,
            width: .145,
            heigt: .086,
          ),

          /// duad
          AudioButtonWidget(
            buttonState: _buttonStates[17],
            audio: _audios[17],
            top: 0.285,
            left: 0.040,
            width: .145,
            heigt: .086,
          ),

          ///
          ///
          /// ------------------------------------------------------------------------------------------ row 4
          ///
          /// ttaa
          AudioButtonWidget(
            buttonState: _buttonStates[18],
            audio: _audios[18],
            top: 0.395,
            left: 0.817,
            width: .145,
            heigt: .086,
          ),

          /// zuaa

          AudioButtonWidget(
            buttonState: _buttonStates[19],
            audio: _audios[19],
            top: 0.395,
            left: 0.660,
            width: .145,
            heigt: .086,
          ),

          /// aain
          AudioButtonWidget(
            buttonState: _buttonStates[20],
            audio: _audios[20],
            top: 0.395,
            left: 0.505,
            width: .145,
            heigt: .086,
          ),

          /// gaain
          AudioButtonWidget(
            buttonState: _buttonStates[21],
            audio: _audios[21],
            top: 0.395,
            left: 0.350,
            width: .145,
            heigt: .086,
          ),

          /// faa
          AudioButtonWidget(
            buttonState: _buttonStates[22],
            audio: _audios[22],
            top: 0.395,
            left: 0.195,
            width: .145,
            heigt: .086,
          ),


          /// faa
          AudioButtonWidget(
            buttonState: _buttonStates[23],
            audio: _audios[23],
            top: 0.395,
            left: 0.040,
            width: .145,
            heigt: .086,
          ),
          ///
          ///
          /// ------------------------------------------------------------------------------------------ row 5
          ///
          /// Qaaf

          AudioButtonWidget(
            buttonState: _buttonStates[24],
            audio: _audios[24],
            top: 0.507,
            left: 0.817,
            width: .145,
            heigt: .086,
          ),

          /// kaaf
          AudioButtonWidget(
            buttonState: _buttonStates[25],
            audio: _audios[25],
            top: 0.507,
            left: 0.660,
            width: .145,
            heigt: .086,
          ),

          /// laam
          AudioButtonWidget(
            buttonState: _buttonStates[26],
            audio: _audios[26],
            top: 0.507,
            left: 0.505,
            width: .145,
            heigt: .086,
          ),

          /// meem
          AudioButtonWidget(
            buttonState: _buttonStates[27],
            audio: _audios[27],
            top: 0.507,
            left: 0.350,
            width: .145,
            heigt: .086,
          ),

          /// noon

          AudioButtonWidget(
            buttonState: _buttonStates[28],
            audio: _audios[28],
            top: 0.507,
            left: 0.195,
            width: .145,
            heigt: .086,
          ),

          /// noon

          AudioButtonWidget(
            buttonState: _buttonStates[29],
            audio: _audios[29],
            top: 0.505,
            left: 0.04,
            width: .145,
            heigt: .086,
          ),

          ///
          /// ------------------------------------------------------------------------------------------ row 6

          /// waw

          AudioButtonWidget(
            buttonState: _buttonStates[30],
            audio: _audios[30],
            top: 0.625,
            left: 0.817,
            width: .145,
            heigt: .086,
          ),

          /// haa
          AudioButtonWidget(
            buttonState: _buttonStates[31],
            audio: _audios[31],
            top: 0.625,
            left: 0.660,
            width: .145,
            heigt: .086,
          ),

          /// hamza
          AudioButtonWidget(
            buttonState: _buttonStates[32],
            audio: _audios[32],
            top: 0.625,
            left: 0.505,
            width: .145,
            heigt: .086,
          ),

          /// yaa

          AudioButtonWidget(
            buttonState: _buttonStates[33],
            audio: _audios[33],
            top: 0.625,
            left: 0.350,
            width: .145,
            heigt: .086,
          ),

          /// yaa

          AudioButtonWidget(
            buttonState: _buttonStates[34],
            audio: _audios[34],
            top: 0.625,
            left: 0.195,
            width: .145,
            heigt: .086,
          ),


          /// yaa

          AudioButtonWidget(
            buttonState: _buttonStates[35],
            audio: _audios[35],
            top: 0.625,
            left: 0.04,
            width: .145,
            heigt: .086,
          ),


          ///
          /// ------------------------------------------------------------------------------------------ row 6

          /// waw

          AudioButtonWidget(
            buttonState: _buttonStates[36],
            audio: _audios[36],
            top: 0.735,
            left: 0.817,
            width: .145,
            heigt: .086,
          ),

          /// haa
          AudioButtonWidget(
            buttonState: _buttonStates[37],
            audio: _audios[37],
            top: 0.735,
            left: 0.660,
            width: .145,
            heigt: .086,
          ),

          /// hamza
          AudioButtonWidget(
            buttonState: _buttonStates[38],
            audio: _audios[38],
            top: 0.735,
            left: 0.505,
            width: .145,
            heigt: .086,
          ),

          /// yaa

          AudioButtonWidget(
            buttonState: _buttonStates[39],
            audio: _audios[39],
            top: 0.735,
            left: 0.350,
            width: .145,
            heigt: .086,
          ),

          /// yaa

          AudioButtonWidget(
            buttonState: _buttonStates[40],
            audio: _audios[40],
            top: 0.735,
            left: 0.195,
            width: .145,
            heigt: .086,
          ),


          /// yaa

          AudioButtonWidget(
            buttonState: _buttonStates[41],
            audio: _audios[41],
            top: 0.735,
            left: 0.04,
            width: .145,
            heigt: .086,
          ),



          ///
          /// ------------------------------------------------------------------------------------------ row 6

          /// waw

          AudioButtonWidget(
            buttonState: _buttonStates[42],
            audio: _audios[42],
            top: 0.845,
            left: 0.817,
            width: .145,
            heigt: .086,
          ),

          /// haa
          AudioButtonWidget(
            buttonState: _buttonStates[43],
            audio: _audios[43],
            top: 0.845,
            left: 0.660,
            width: .145,
            heigt: .086,
          ),

          /// hamza
          AudioButtonWidget(
            buttonState: _buttonStates[44],
            audio: _audios[44],
            top: 0.845,
            left: 0.505,
            width: .145,
            heigt: .086,
          ),

          /// yaa

          AudioButtonWidget(
            buttonState: _buttonStates[45],
            audio: _audios[45],
            top: 0.845,
            left: 0.350,
            width: .145,
            heigt: .086,
          ),

          /// yaa

          AudioButtonWidget(
            buttonState: _buttonStates[46],
            audio: _audios[46],
            top: 0.845,
            left: 0.195,
            width: .145,
            heigt: .086,
          ),


          /// yaa

          AudioButtonWidget(
            buttonState: _buttonStates[47],
            audio: _audios[47],
            top: 0.845,
            left: 0.04,
            width: .145,
            heigt: .086,
          ),

          ///
          /// ------------------------------------------------------------------------------------------ row 6

        

          


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


