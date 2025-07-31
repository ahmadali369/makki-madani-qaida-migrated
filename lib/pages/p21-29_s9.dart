import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../AudioButton.dart';
import '../boolGlobleState.dart';

class P21_S9 extends StatefulWidget {
  const P21_S9({super.key});

  @override
  State<P21_S9> createState() => _P21_S9State();
}

class _P21_S9State extends State<P21_S9> {
  late List<bool> _buttonStates;
  late final List<String> _audios;

  final audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _buttonStates = List<bool>.filled(27, false);
    _audios = List.generate(
      27,
      (index) => 'audios/p29/${index + 1}.mp3',
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
    double spacing = 0.309; // space between columns
    return base + col * spacing;
  }

  double adjustedTop(int row) {
    double base = 0.125; // top padding adjusted to fit the grid
    double spacing = 0.092; // space between rows
    return base + row * spacing;
  }

  @override
  Widget build(BuildContext context) {
    double buttonWidth = 0.152;
    double buttonHeight = 0.085;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/img (30).jpg', 
              fit: BoxFit.fill,
            ),
          ),

             for (int i = 0; i < 27; i++)
             AudioButtonWidget(
    buttonState: _buttonStates[i],
    audio: _audios[i],
    top: adjustedTop(i ~/ 3),        // 9 rows
    left: adjustedLeft(i % 3),       // 3 columns
    width: buttonWidth*2,
    heigt: buttonHeight,
  )
            ,
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