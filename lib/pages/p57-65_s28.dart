import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../AudioButton.dart';
import '../boolGlobleState.dart';

class P57_S28 extends StatefulWidget {
  const P57_S28({super.key});

  @override
  State<P57_S28> createState() => _P57_S28State();
}

class _P57_S28State extends State<P57_S28> {
  late List<bool> _buttonStates;
  late final List<String> _audios;

  final audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _buttonStates = List<bool>.filled(19, false);
    _audios = List.generate(
      19,
      (index) => 'audios/p65/${index + 1}.mp3',
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
    double buttonWidth = 0.235;
    double buttonHeight = 0.091;


    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/img (66).jpg', 
              fit: BoxFit.fill,
            ),
          ),
          

         
             AudioButtonWidget(
              buttonState: _buttonStates[0],
              audio: _audios[0],
              top: 0.22,
              left: 0.76,
              width:0.16,
              heigt: 0.05,
            ),
             AudioButtonWidget(
              buttonState: _buttonStates[1],
              audio: _audios[1],
              top: 0.22,
              left: 0.6,
              width:0.16,
              heigt: 0.05,
            ),
             AudioButtonWidget(
              buttonState: _buttonStates[2],
              audio: _audios[2],
              top: 0.3,
              left: 0.76,
              width:0.16,
              heigt: 0.05,
            ),
             AudioButtonWidget(
              buttonState: _buttonStates[3],
              audio: _audios[3],
              top: 0.3,
              left: 0.6,
              width:0.16,
              heigt: 0.05,
            ),
             AudioButtonWidget(
              buttonState: _buttonStates[4],
              audio: _audios[4],
              top: 0.37,
              left: 0.65,
              width:0.27,
              heigt: 0.05,
            ),
             AudioButtonWidget(
              buttonState: _buttonStates[5],
              audio: _audios[5],
              top: 0.44,
              left: 0.65,
              width:0.27,
              heigt: 0.05,
            ),
             AudioButtonWidget(
              buttonState: _buttonStates[6],
              audio: _audios[6],
              top: 0.52,
              left: 0.61,
              width:0.31,
              heigt: 0.05,
            ),
             AudioButtonWidget(
              buttonState: _buttonStates[7],
              audio: _audios[7],
              top: 0.59,
              left: 0.61,
              width:0.31,
              heigt: 0.05,
            ),
             AudioButtonWidget(
              buttonState: _buttonStates[8],
              audio: _audios[8],
              top: 0.66,
              left: 0.71,
              width:0.21,
              heigt: 0.05,
            ),
            AudioButtonWidget(
              buttonState: _buttonStates[9],
              audio: _audios[9],
              top: 0.74,
              left: 0.71,
              width:0.21,
              heigt: 0.05,
            ),
            AudioButtonWidget(
              buttonState: _buttonStates[10],
              audio: _audios[10],
              top: 0.23,
              left: 0.29,
              width:0.18,
              heigt: 0.05,
            ),
            AudioButtonWidget(
              buttonState: _buttonStates[11],
              audio: _audios[11],
              top: 0.23,
              left: 0.09,
              width:0.18,
              heigt: 0.05,
            ),
             AudioButtonWidget(
              buttonState: _buttonStates[12],
              audio: _audios[12],
              top: 0.37,
              left: 0.2,
              width:0.27,
              heigt: 0.05,
            ),
             AudioButtonWidget(
              buttonState: _buttonStates[13],
              audio: _audios[13],
              top: 0.44,
              left: 0.2,
              width:0.27,
              heigt: 0.05,
            ),
             AudioButtonWidget(
              buttonState: _buttonStates[14],
              audio: _audios[14],
              top: 0.59,
              left: 0.2,
              width:0.27,
              heigt: 0.05,
            ),
             AudioButtonWidget(
              buttonState: _buttonStates[15],
              audio: _audios[15],
              top: 0.66,
              left: 0.2,
              width:0.27,
              heigt: 0.05,
            ),
            AudioButtonWidget(
              buttonState: _buttonStates[16],
              audio: _audios[16],
              top: 0.74,
              left: 0.3,
              width:0.15,
              heigt: 0.05,
            ),
             AudioButtonWidget(
              buttonState: _buttonStates[17],
              audio: _audios[17],
              top: 0.74,
              left: 0.14,
              width:0.15,
              heigt: 0.05,
            ),
             AudioButtonWidget(
              buttonState: _buttonStates[18],
              audio: _audios[18],
              top: 0.8,
              left: 0.23,
              width:0.25,
              heigt: 0.05,
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