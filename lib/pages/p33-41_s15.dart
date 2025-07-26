import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../AudioButton.dart';
import '../boolGlobleState.dart';

class P33_S15 extends StatefulWidget {
  const P33_S15({super.key});

  @override
  State<P33_S15> createState() => _P33_S15State();
}

class _P33_S15State extends State<P33_S15> {
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
    double base = 0.035;
    double spacing = 0.148;
    double gap = 0.04; // extra space between col 2 and 3
    if (col <= 2) {
      return base + col * spacing;
    } else {
      return base + gap + col * spacing;
    }
  }
  double adjustedLeft1(int col) {
    double base = 0.035; // left padding
    double spacing = 0.155; // space between columns
    return base + col * spacing;
  }

  double adjustedTop(int row) {
    double base = 0.6; // top padding adjusted to fit the grid
    double spacing = 0.1; // space between rows
    return base + row * spacing;
  }

  @override
  Widget build(BuildContext context) {
     double topBase = 0.05;
    double rowSpacing = 0.1;
    double buttonWidth = 0.143;
    double buttonHeight = 0.09;


    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/img (42).jpg', 
              fit: BoxFit.fill,
            ),
          ),
      
          ///................shaad
          ///
          for (int i = 0; i < 18; i++)
            AudioButtonWidget(
              buttonState: _buttonStates[i],
              audio: _audios[i],
              top: topBase + (i ~/ 6) * rowSpacing,
              left: adjustedLeft(i % 6),
              width: buttonWidth,
              heigt: buttonHeight,
            ),
            for (int i = 0; i < 12; i++)
            AudioButtonWidget(
              buttonState: _buttonStates[i],
              audio: _audios[i],
              top: adjustedTop(i ~/ 6)+ 0.001,
              left: adjustedLeft1(i % 6),
              width: 0.148,
              heigt: 0.089,
            ),
            AudioButtonWidget(
              buttonState: _buttonStates[12],
              audio: _audios[12],
              top: adjustedTop(12 ~/ 6)+ 0.001,
              left: 0.045,
              width: 0.186,
              heigt: 0.094,
            ),
             AudioButtonWidget(
              buttonState: _buttonStates[13],
              audio: _audios[13],
              top: adjustedTop(13 ~/ 6)+ 0.001,
              left: 0.245,
              width: 0.14,
              heigt: 0.094,
            ),
            AudioButtonWidget(
              buttonState: _buttonStates[14],
              audio: _audios[14],
              top: adjustedTop(14 ~/ 6)+ 0.001,
              left: 0.3894,
              width: 0.14,
              heigt: 0.094,
            ),
            AudioButtonWidget(
              buttonState: _buttonStates[15],
              audio: _audios[15],
              top: adjustedTop(15 ~/ 6)+ 0.001,
              left: 0.535,
              width: 0.14,
              heigt: 0.094,
            ),
            AudioButtonWidget(
              buttonState: _buttonStates[16],
              audio: _audios[16],
              top: adjustedTop(16 ~/ 6)+ 0.001,
              left: 0.68,
              width: 0.14,
              heigt: 0.094,
            ),
            AudioButtonWidget(
              buttonState: _buttonStates[17],
              audio: _audios[17],
              top: adjustedTop(17 ~/ 6)+ 0.001,
              left: 0.824,
              width: 0.14,
              heigt: 0.094,
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