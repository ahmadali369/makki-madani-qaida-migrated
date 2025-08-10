import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../AudioButton.dart';
import '../boolGlobleState.dart';

class P29_S11 extends StatefulWidget {
  const P29_S11({super.key});

  @override
  State<P29_S11> createState() => _P29_S11State();
}

class _P29_S11State extends State<P29_S11> {
  late List<bool> _buttonStates;
  late final List<String> _audios;

  final audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _buttonStates = List<bool>.filled(24, false);
    _audios = List.generate(
      24,
      (index) => 'audios/p37/${index + 1}.mp3',
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
    col = 4 - col; // Reverse the order of columns
    double base = 0.034; // left padding
    double spacing = 0.189; // space between columns
    return base + col * spacing;
  }

  double adjustedTop(int row) {
    double base = 0.056; // top padding adjusted to fit the grid
    double spacing = 0.0879; // space between rows
    return base + row * spacing;
  }
  @override
  Widget build(BuildContext context) {
    double buttonWidth = 0.174;
    double buttonHeight = 0.084;


    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/img (38).jpg', 
              fit: BoxFit.fill,
            ),
          ),

          for (int i = 0; i < 20; i++)
            AudioButtonWidget(
              buttonState: _buttonStates[i],
              audio: _audios[i],
              top: adjustedTop(i ~/ 5)+ 0.001,
              left: adjustedLeft(i % 5),
              width: buttonWidth,
              heigt: buttonHeight,
            ),
          for (int i = 20; i < 24; i++)
            AudioButtonWidget(  
              buttonState: _buttonStates[i],
              audio: _audios[i],
              top: 0.86,
              left: 0.034+(3-(i % 4))*0.23,
              width: buttonWidth*1.3,
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