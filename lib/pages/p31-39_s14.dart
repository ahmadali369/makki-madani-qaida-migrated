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
    _buttonStates = List<bool>.filled(45, false);
    _audios = List.generate(
      45,
      (index) => 'audios/p11/audio_${index + 1}.mp3',
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

  double adjustedLeft(int col) {
    double base = 0.034; // left padding
    double spacing = 0.24; // space between columns
    return base + col * spacing;
  }

  double adjustedTop(int row) {
    double base = 0.054; // top padding adjusted to fit the grid
    double spacing = 0.087; // space between rows
    return base + row * spacing;
  }
  @override
  Widget build(BuildContext context) {
    double buttonWidth = 0.17;
    double buttonHeight = 0.085;


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
            buttonState: _buttonStates[0],
            audio: _audios[0],
            top: 0.23,
            left: 0.750,
            width: .22,
            heigt: .075,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[1],
            audio: _audios[1],
            top: 0.23,
            left: .480,
            width: .26,
            heigt: .075,
          ),
           
          AudioButtonWidget(
            buttonState: _buttonStates[2],
            audio: _audios[2],
            top: 0.23,
            left: .29,
            width: .18,
            heigt: .075,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[3],
            audio: _audios[3],
            top: 0.23,
            left: .04,
            width: .24,
            heigt: .075,
          ),
          //...............
           AudioButtonWidget(
            buttonState: _buttonStates[0],
            audio: _audios[0],
            top: 0.32,
            left: 0.750,
            width: .22,
            heigt: .075,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[1],
            audio: _audios[1],
            top: 0.32,
            left: .480,
            width: .26,
            heigt: .075,
          ),
           
          AudioButtonWidget(
            buttonState: _buttonStates[2],
            audio: _audios[2],
            top: 0.32,
            left: .29,
            width: .18,
            heigt: .075,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[3],
            audio: _audios[3],
            top: 0.32,
            left: .04,
            width: .24,
            heigt: .075,
          ),
          //...............
           AudioButtonWidget(
            buttonState: _buttonStates[0],
            audio: _audios[0],
            top: 0.405,
            left: 0.750,
            width: .22,
            heigt: .075,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[1],
            audio: _audios[1],
            top: 0.405,
            left: .480,
            width: .26,
            heigt: .075,
          ),
           
          AudioButtonWidget(
            buttonState: _buttonStates[2],
            audio: _audios[2],
            top: 0.405,
            left: .29,
            width: .18,
            heigt: .075,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[3],
            audio: _audios[3],
            top: 0.405,
            left: .04,
            width: .24,
            heigt: .075,
          ),
          //...............
           AudioButtonWidget(
            buttonState: _buttonStates[0],
            audio: _audios[0],
            top: 0.494,
            left: 0.750,
            width: .22,
            heigt: .075,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[1],
            audio: _audios[1],
            top: 0.494,
            left: .480,
            width: .26,
            heigt: .075,
          ),
           
          AudioButtonWidget(
            buttonState: _buttonStates[2],
            audio: _audios[2],
            top: 0.494,
            left: .29,
            width: .18,
            heigt: .075,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[3],
            audio: _audios[3],
            top: 0.494,
            left: .04,
            width: .24,
            heigt: .075,
          ),
          //...............
           AudioButtonWidget(
            buttonState: _buttonStates[0],
            audio: _audios[0],
            top: 0.58,
            left: 0.750,
            width: .22,
            heigt: .075,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[1],
            audio: _audios[1],
            top: 0.58,
            left: .480,
            width: .26,
            heigt: .075,
          ),
           
          AudioButtonWidget(
            buttonState: _buttonStates[2],
            audio: _audios[2],
            top: 0.58,
            left: .29,
            width: .18,
            heigt: .075,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[3],
            audio: _audios[3],
            top: 0.58,
            left: .04,
            width: .24,
            heigt: .075,
          ),
          //...............
          AudioButtonWidget(
            buttonState: _buttonStates[1],
            audio: _audios[1],
            top: 0.667,
            left: .485,
            width: .25,
            heigt: .075,
          ),
           
          AudioButtonWidget(
            buttonState: _buttonStates[2],
            audio: _audios[2],
            top: 0.667,
            left: .29,
            width: .18,
            heigt: .075,
          ),
          //...............3 buttons
          AudioButtonWidget(
            buttonState: _buttonStates[3],
            audio: _audios[3],
            top: 0.767,
            left: .04,
            width: .29,
            heigt: .075,
          ),

           AudioButtonWidget(
            buttonState: _buttonStates[3],
            audio: _audios[3],
            top: 0.767,
            left: .35,
            width: .29,
            heigt: .075,
          ),AudioButtonWidget(
            buttonState: _buttonStates[3],
            audio: _audios[3],
            top: 0.767,
            left: .67,
            width: .29,
            heigt: .075,
          ),
          ///last 3 buttons
          AudioButtonWidget(
            buttonState: _buttonStates[3],
            audio: _audios[3],
            top: 0.856,
            left: .04,
            width: .29,
            heigt: .075,
          ),
           AudioButtonWidget(
            buttonState: _buttonStates[3],
            audio: _audios[3],
            top: 0.856,
            left: .35,
            width: .29,
            heigt: .075,
          ),AudioButtonWidget(
            buttonState: _buttonStates[3],
            audio: _audios[3],
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