import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../AudioButton.dart';
import '../boolGlobleState.dart';

class P31_S14 extends StatefulWidget {
  const P31_S14({super.key});

  @override
  State<P31_S14> createState() => _P31_S14State();
}

class _P31_S14State extends State<P31_S14> {
  late List<bool> _buttonStates;
  late final List<String> _audios;

  final audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _buttonStates = List<bool>.filled(36, false);
    _audios = List.generate(
      36,
      (index) => 'audios/p39/${index + 1}.mp3',
    );
  }

  @override
  void dispose() {
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
      if (BoolState.playPause == true) {
        _triggerButton(i);
        if (i > 0) _triggerButton(i - 1);

        try {
          await audioPlayer.play(AssetSource(_audios[i]));
          Duration? duration = await audioPlayer.getDuration();
          if (duration != null) await Future.delayed(duration);
        } catch (e) {
          print('Error playing ${_audios[i]}: $e');
        }

        if (i == _buttonStates.length - 1) {
          _triggerButton(_buttonStates.length - 1);
          setState(() {
            BoolState.togglePlayPause();
          });
        }
      } else {
        if (i > 0) _triggerButton(i - 1);
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
          Positioned.fill(
            child: Image.asset(
              'assets/images/img (40).jpg', 
              fit: BoxFit.fill,
            ),
          ),
           AudioButtonWidget(
            buttonState: _buttonStates[0],
            audio: _audios[0],
            top: 0.057,
            left: 0.750,
            width: .22,
            heigt: .075,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[1],
            audio: _audios[1],
            top: 0.057,
            left: .480,
            width: .26,
            heigt: .075,
          ),
           
          AudioButtonWidget(
            buttonState: _buttonStates[2],
            audio: _audios[2],
            top: 0.057,
            left: .29,
            width: .18,
            heigt: .075,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[3],
            audio: _audios[3],
            top: 0.057,
            left: .04,
            width: .24,
            heigt: .075,
          ),
          //...............
           AudioButtonWidget(
            buttonState: _buttonStates[4],
            audio: _audios[4],
            top: 0.146,
            left: 0.750,
            width: .22,
            heigt: .075,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[5],
            audio: _audios[5],
            top: 0.146,
            left: .480,
            width: .26,
            heigt: .075,
          ),
           
          AudioButtonWidget(
            buttonState: _buttonStates[6],
            audio: _audios[6],
            top: 0.146,
            left: .29,
            width: .18,
            heigt: .075,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[7],
            audio: _audios[7],
            top: 0.146,
            left: .04,
            width: .24,
            heigt: .075,
          ),
          //...............
           AudioButtonWidget(
            buttonState: _buttonStates[8],
            audio: _audios[8],
            top: 0.23,
            left: 0.750,
            width: .22,
            heigt: .075,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[9],
            audio: _audios[9],
            top: 0.23,
            left: .480,
            width: .26,
            heigt: .075,
          ),
           
          AudioButtonWidget(
            buttonState: _buttonStates[10],
            audio: _audios[10],
            top: 0.23,
            left: .29,
            width: .18,
            heigt: .075,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[11],
            audio: _audios[11],
            top: 0.23,
            left: .04,
            width: .24,
            heigt: .075,
          ),
          //...............
           AudioButtonWidget(
            buttonState: _buttonStates[12],
            audio: _audios[12],
            top: 0.32,
            left: 0.750,
            width: .22,
            heigt: .075,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[13],
            audio: _audios[13],
            top: 0.32,
            left: .480,
            width: .26,
            heigt: .075,
          ),
           
          AudioButtonWidget(
            buttonState: _buttonStates[14],
            audio: _audios[14],
            top: 0.32,
            left: .29,
            width: .18,
            heigt: .075,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[15],
            audio: _audios[15],
            top: 0.32,
            left: .04,
            width: .24,
            heigt: .075,
          ),
          //...............
           AudioButtonWidget(
            buttonState: _buttonStates[16],
            audio: _audios[16],
            top: 0.405,
            left: 0.750,
            width: .22,
            heigt: .075,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[17],
            audio: _audios[17],
            top: 0.405,
            left: .480,
            width: .26,
            heigt: .075,
          ),
           
          AudioButtonWidget(
            buttonState: _buttonStates[18],
            audio: _audios[18],
            top: 0.405,
            left: .29,
            width: .18,
            heigt: .075,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[19],
            audio: _audios[19],
            top: 0.405,
            left: .04,
            width: .24,
            heigt: .075,
          ),
          //...............
           AudioButtonWidget(
            buttonState: _buttonStates[20],
            audio: _audios[20],
            top: 0.494,
            left: 0.750,
            width: .22,
            heigt: .075,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[21],
            audio: _audios[21],
            top: 0.494,
            left: .480,
            width: .26,
            heigt: .075,
          ),
           
          AudioButtonWidget(
            buttonState: _buttonStates[22],
            audio: _audios[22],
            top: 0.494,
            left: .29,
            width: .18,
            heigt: .075,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[23],
            audio: _audios[23],
            top: 0.494,
            left: .04,
            width: .24,
            heigt: .075,
          ),
          //...............
           AudioButtonWidget(
            buttonState: _buttonStates[24],
            audio: _audios[24],
            top: 0.58,
            left: 0.750,
            width: .22,
            heigt: .075,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[25],
            audio: _audios[25],
            top: 0.58,
            left: .480,
            width: .26,
            heigt: .075,
          ),
           
          AudioButtonWidget(
            buttonState: _buttonStates[26],
            audio: _audios[26],
            top: 0.58,
            left: .29,
            width: .18,
            heigt: .075,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[27],
            audio: _audios[27],
            top: 0.58,
            left: .04,
            width: .24,
            heigt: .075,
          ),
          //...............
          AudioButtonWidget(
            buttonState: _buttonStates[28],
            audio: _audios[28],
            top: 0.667,
            left: .485,
            width: .25,
            heigt: .075,
          ),
           
          AudioButtonWidget(
            buttonState: _buttonStates[29],
            audio: _audios[29],
            top: 0.667,
            left: .29,
            width: .18,
            heigt: .075,
          ),
          //...............3 buttons
          AudioButtonWidget(
            buttonState: _buttonStates[30],
            audio: _audios[30],
            top: 0.767,
            left: .04,
            width: .29,
            heigt: .075,
          ),

           AudioButtonWidget(
            buttonState: _buttonStates[31],
            audio: _audios[31],
            top: 0.767,
            left: .35,
            width: .29,
            heigt: .075,
          ),AudioButtonWidget(
            buttonState: _buttonStates[32],
            audio: _audios[32],
            top: 0.767,
            left: .67,
            width: .29,
            heigt: .075,
          ),
          ///last 3 buttons
          AudioButtonWidget(
            buttonState: _buttonStates[33],
            audio: _audios[33],
            top: 0.856,
            left: .04,
            width: .29,
            heigt: .075,
          ),
           AudioButtonWidget(
            buttonState: _buttonStates[34],
            audio: _audios[34],
            top: 0.856,
            left: .35,
            width: .29,
            heigt: .075,
          ),AudioButtonWidget(
            buttonState: _buttonStates[35],
            audio: _audios[35],
            top: 0.856,
            left: .67,
            width: .29,
            heigt: .075,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (!BoolState.oneButtonRunning && !BoolState.oneStreamRunning) {
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