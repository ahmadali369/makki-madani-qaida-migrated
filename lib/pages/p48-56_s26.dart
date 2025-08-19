import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../AudioButton.dart';
import '../boolGlobleState.dart';

class P48_S27 extends StatefulWidget {
  const P48_S27({super.key});

  @override
  State<P48_S27> createState() => _P48_S27State();
}

class _P48_S27State extends State<P48_S27> {
  late List<bool> _buttonStates;
  late final List<String> _audios;

  final audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _buttonStates = List<bool>.filled(8, false);
    _audios = List.generate(
      8,
      (index) => 'audios/p56/${index + 1}.mp3',
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
              'assets/images/img (57).jpg', 
              fit: BoxFit.fill,
            ),
          ),
          
            ////
             AudioButtonWidget(
              buttonState: _buttonStates[3],
              audio: _audios[3],
              top: 0.098,
              left: 0.17,
              width: 0.14,
              heigt: 0.09,
            ),
             AudioButtonWidget(
              buttonState: _buttonStates[2],
              audio: _audios[2],
              top: 0.098,
              left: 0.348,
              width: 0.14,
              heigt: 0.09,
            ),
             AudioButtonWidget(
              buttonState: _buttonStates[1],
              audio: _audios[1],
              top: 0.098,
              left: 0.499,
              width: 0.14,
              heigt: 0.09,
            ),
             AudioButtonWidget(
              buttonState: _buttonStates[0],
              audio: _audios[0],
              top: 0.098,
              left: 0.7,
              width: 0.14,
              heigt: 0.09,
            ),
             AudioButtonWidget(
              buttonState: _buttonStates[5],
              audio: _audios[5],
              top: 0.28,
              left: 0.13,
              width: 0.34,
              heigt: 0.05,
            ),
             AudioButtonWidget(
              buttonState: _buttonStates[4],
              audio: _audios[4],
              top: 0.28,
              left: 0.55,
              width: 0.34,
              heigt: 0.05,
            ),
            AudioButtonWidget(
              buttonState: _buttonStates[7],
              audio: _audios[7],
              top: 0.34,
              left: 0.13,
              width: 0.34,
              heigt: 0.05,
            ),
             AudioButtonWidget(
              buttonState: _buttonStates[6],
              audio: _audios[6],
              top: 0.34,
              left: 0.52,
              width: 0.4,
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