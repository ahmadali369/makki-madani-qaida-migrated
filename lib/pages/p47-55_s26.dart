import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../AudioButton.dart';
import '../boolGlobleState.dart';

class P47_S26 extends StatefulWidget {
  const P47_S26({super.key});

  @override
  State<P47_S26> createState() => _P47_S26State();
}

class _P47_S26State extends State<P47_S26> {
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
    double base = 0.04; // left padding
    double spacing = 0.31; // space between columns
    return base + col * spacing;
  }

  double adjustedTop(int row) {
    double base = 0.067; // top padding adjusted to fit the grid
    double spacing = 0.095; // space between rows
    return base + row * spacing;
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
              'assets/images/img (56).jpg', 
              fit: BoxFit.fill,
            ),
          ),
          

          for (int i = 0; i < 3; i++)
            AudioButtonWidget(
              buttonState: _buttonStates[i],
              audio: _audios[i],
              top: adjustedTop(i ~/ 3)+ 0.001,
              left: adjustedLeft(i % 3),
              width: buttonWidth*1.3,
              heigt: buttonHeight,
            ),
             AudioButtonWidget(
              buttonState: _buttonStates[3],
              audio: _audios[3],
              top: 0.17,
              left: 0.36,
              width: buttonWidth*1.3,
              heigt: buttonHeight,
            ),
            ////
             AudioButtonWidget(
              buttonState: _buttonStates[3],
              audio: _audios[3],
              top: 0.32,
              left: 0.03,
              width: 0.18,
              heigt: 0.07,
            ),
             AudioButtonWidget(
              buttonState: _buttonStates[3],
              audio: _audios[3],
              top: 0.32,
              left: 0.22,
              width: 0.18,
              heigt: 0.07,
            ),
             AudioButtonWidget(
              buttonState: _buttonStates[3],
              audio: _audios[3],
              top: 0.32,
              left: 0.415,
              width: 0.358,
              heigt: 0.07,
            ),
             AudioButtonWidget(
              buttonState: _buttonStates[3],
              audio: _audios[3],
              top: 0.32,
              left: 0.776,
              width: 0.18,
              heigt: 0.07,
            ),
             AudioButtonWidget(
              buttonState: _buttonStates[3],
              audio: _audios[3],
              top: 0.4,
              left: 0.415,
              width: 0.18,
              heigt: 0.07,
            ),
             AudioButtonWidget(
              buttonState: _buttonStates[3],
              audio: _audios[3],
              top: 0.84,
              left: 0.17,
              width: 0.37,
              heigt: 0.05,
            ),
             AudioButtonWidget(
              buttonState: _buttonStates[3],
              audio: _audios[3],
              top: 0.84,
              left: 0.55,
              width: 0.37,
              heigt: 0.05,
            ),
            AudioButtonWidget(
              buttonState: _buttonStates[3],
              audio: _audios[3],
              top: 0.89,
              left: 0.17,
              width: 0.37,
              heigt: 0.05,
            ),
             AudioButtonWidget(
              buttonState: _buttonStates[3],
              audio: _audios[3],
              top: 0.89,
              left: 0.55,
              width: 0.37,
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