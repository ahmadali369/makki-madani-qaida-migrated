import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../AudioButton.dart';
import '../boolGlobleState.dart';

class P14_S7 extends StatefulWidget {
  const P14_S7({super.key});

  @override
  State<P14_S7> createState() => _P14_S7State();
}

class _P14_S7State extends State<P14_S7> {
  late List<bool> _buttonStates;
  late final List<String> _audios;

  final audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _buttonStates = List<bool>.filled(42, false);
    _audios = List.generate(
      29,
      (index) => 'audios/p22-1/${index + 1}.mp3',
    );
    _audios.addAll(
      List.generate(
        13,
        (index) => 'audios/p22-2/${index + 1}.mp3',
      ),
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
    col = 5 - col; // Adjusting column index to match the layout
    double base = 0.038; // left padding
    double spacing = 0.157; // space between columns
    return base + col * spacing;
  }

  double adjustedTop(int row) {
    double base = 0.18; // top padding adjusted to fit the grid
    double spacing = 0.0919; // space between rows
    return base + row * spacing;
  }
 double adjustedLeft1(int col) {
    col = 3 - col; // Reverse the order of columns for the second grid
    double base = 0.028; 
    double spacing = 0.240; 
    return base + col * spacing;
  }

  double adjustedTop1(int row) {
    double base = 0.3 + (5 * 0.077); 
    double spacing = 0.088; 
    return base + row * spacing;
  
  }
  @override
  Widget build(BuildContext context) {
    double buttonWidth = 0.148;
    double buttonHeight = 0.084;


    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/img (23).jpg', 
              fit: BoxFit.fill,
            ),
          ),

          // Render 24 buttons in 4 rows, 6 columns
          for (int i = 0; i < 24; i++)
            AudioButtonWidget(
              buttonState: _buttonStates[i],
              audio: _audios[i],
              top: adjustedTop(i ~/ 6)+ 0.001,
              left: adjustedLeft(i % 6),
              width: buttonWidth,
              heigt: buttonHeight,
            ),
             for (int i = 24; i < 29; i++)
            AudioButtonWidget(
              buttonState: _buttonStates[i],
              audio: _audios[i],
              top: adjustedTop(i ~/ 6),
              left: adjustedLeft(i % 6)+0.081,
              width: buttonWidth,
              heigt: buttonHeight,
            ),
          for (int i = 29; i < 41; i++)
            AudioButtonWidget(
              buttonState: _buttonStates[i],
              audio: _audios[i],
              top: adjustedTop1((i - 29) ~/ 4), // 4 columns per row
              left: adjustedLeft1((i - 29) % 4) ,// 4 columns
              width: buttonWidth*1.5,
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