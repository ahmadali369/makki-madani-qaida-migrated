import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../AudioButton.dart';
import '../boolGlobleState.dart';

class P8_S4 extends StatefulWidget {
  const P8_S4({super.key});

  @override
  State<P8_S4> createState() => _P8_S4State();
}

class _P8_S4State extends State<P8_S4> {
  late List<bool> _buttonStates;
  late final List<String> _audios;

  final audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _buttonStates = List<bool>.filled(84, false);

    _audios = List.generate(
      84,
      (index) => 'audios/p16/${index + 1}.mp3',
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

        await audioPlayer.play(AssetSource(_audios[i]));
        Duration? duration = await audioPlayer.getDuration();
        if (duration != null) await Future.delayed(duration);

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
      col = 5 - col;
    double base = 0.035;
    double spacing = 0.148;
    double gap = 0.04; // extra space between col 2 and 3
    if (col <= 2) {
      return base + col * spacing;
    } else {
      return base + gap + col * spacing;
    }
  }

  @override
  Widget build(BuildContext context) {
    double topBase = 0.045;
    double rowSpacing = 0.07;
    double buttonWidth = 0.143;
    double buttonHeight = 0.067;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/img (17).jpg',
              fit: BoxFit.fill,
            ),
          ),

          // Positioned AudioButtonWidgets with spacing between column group 3
          for (int i = 0; i < 78; i++)
            AudioButtonWidget(
              buttonState: _buttonStates[i],
              audio: _audios[i],
              top: topBase + (i ~/ 6) * rowSpacing,
              left: adjustedLeft(i % 6),
              width: buttonWidth,
              heigt: buttonHeight,
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
