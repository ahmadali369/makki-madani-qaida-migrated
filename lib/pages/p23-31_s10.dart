import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../AudioButton.dart';
import '../boolGlobleState.dart';

class P23_S10 extends StatefulWidget {
  const P23_S10({super.key});

  @override
  State<P23_S10> createState() => _P23_S10State();
}

class _P23_S10State extends State<P23_S10> {
  late List<bool> _buttonStates;
  late final List<String> _audios;

  final audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _buttonStates = List<bool>.filled(35, false);
    _audios = List.generate(
      35,
      (index) => 'audios/p31/${index + 1}.mp3',
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
    col = 6 - col; // Reverse the order of columns
    double base = 0.038; // left padding
    double spacing = 0.157; // space between columns
    return base + col * spacing;
  }

  double adjustedTop(int row) {
    double base = 0.0614; // top padding adjusted to fit the grid
    double spacing = 0.106; // space between rows
    return base + row * spacing;
  }
  @override
  Widget build(BuildContext context) {
    double buttonWidth = 0.152;
    double buttonHeight = 0.0964;


    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/img (32).jpg', 
              fit: BoxFit.fill,
            ),
          ),

          // Render 24 buttons in 4 rows, 6 columns
          for (int i = 0; i < 18; i++)
            AudioButtonWidget(
              buttonState: _buttonStates[i],
              audio: _audios[i],
              top: adjustedTop(i ~/ 6)+ 0.001,
              left: adjustedLeft(i % 6),
              width: buttonWidth,
              heigt: buttonHeight,
            ),
             for (int i = 18; i < 23; i++)
            AudioButtonWidget(
              buttonState: _buttonStates[i],
              audio: _audios[i],
              top: adjustedTop(i ~/ 6),
              left: adjustedLeft(i % 6)+0.081,
              width: buttonWidth,
              heigt: buttonHeight,
            ),
          for (int i = 24; i < 36; i++)
           AudioButtonWidget(
              buttonState: _buttonStates[i-2],
              audio: _audios[i-2],
              top: adjustedTop(i ~/ 6)+0.25,
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