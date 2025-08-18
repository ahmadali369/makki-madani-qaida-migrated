import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../AudioButton.dart';
import '../boolGlobleState.dart';

class P39_S20 extends StatefulWidget {
  const P39_S20({super.key});

  @override
  State<P39_S20> createState() => _P39_S20State();
}

class _P39_S20State extends State<P39_S20> {
  late List<bool> _buttonStates;
  late final List<String> _audios;

  final audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _buttonStates = List<bool>.filled(17, false);
    _audios = List.generate(
      17,
      (index) => 'audios/p47/${index + 1}.mp3',
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
    //col = 5 - col; // Reverse the order of columns
    double base = 0.09; // left padding
    double spacing = 0.159; // space between columns
    return base + col * spacing;
  }

  double adjustedTop(int row) {
    double base = 0.45; // top padding adjusted to fit the grid
    double spacing = 0.085; // space between rows
    return base + row * spacing;
  }
  @override
  Widget build(BuildContext context) {
    double buttonWidth = 0.168;
    double buttonHeight = 0.07;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/img (48).jpg', 
              fit: BoxFit.fill,
            ),
          ),

          
            AudioButtonWidget(
              buttonState: _buttonStates[0],
              audio: _audios[0],
              top: 0.45,
              left: 0.56,
              width: buttonWidth,
              heigt: buttonHeight,
            ),
            AudioButtonWidget(
              buttonState: _buttonStates[1],
              audio: _audios[1],
              top: 0.45,
              left: 0.5,
              width: buttonWidth,
              heigt: buttonHeight,
            ),
            AudioButtonWidget(
              buttonState: _buttonStates[2],
              audio: _audios[2],
              top: 0.45,
              left: 0.44,
              width: buttonWidth,
              heigt: buttonHeight,
            ),
            AudioButtonWidget(
              buttonState: _buttonStates[3],
              audio: _audios[3],
              top: 0.45,
              left: 0.3,
              width: buttonWidth,
              heigt: buttonHeight,
            ),
            AudioButtonWidget(
              buttonState: _buttonStates[4],
              audio: _audios[4],
              top: 0.45,
              left: 0.16,
              width: buttonWidth,
              heigt: buttonHeight,
            ),

             AudioButtonWidget(
            buttonState: _buttonStates[5],
            audio: _audios[5],
            top: adjustedTop(8),
            left: 0.034,
            width: .3,
            heigt: .08,
          ),

            AudioButtonWidget(
            buttonState: _buttonStates[6],
            audio: _audios[4],
            top: adjustedTop(8),
            left: 0.35,
            width: .3,
            heigt: .08,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[4],
            audio: _audios[4],
            top: adjustedTop(8),
            left: 0.654,
            width: .3,
            heigt: .08,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[4],
            audio: _audios[4],
            top: adjustedTop(9),
            left: 0.185,
            width: .3,
            heigt: .08,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[4],
            audio: _audios[4],
            top: adjustedTop(9),
            left: 0.495,
            width: .3,
            heigt: .08,
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