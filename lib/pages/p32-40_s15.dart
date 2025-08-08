import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../AudioButton.dart';
import '../boolGlobleState.dart';

class P32_S15 extends StatefulWidget {
  const P32_S15({super.key});

  @override
  State<P32_S15> createState() => _P32_S15State();
}

class _P32_S15State extends State<P32_S15> {
  late List<bool> _buttonStates;
  late final List<String> _audios;

  final audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _buttonStates = List<bool>.filled(20, false);
    _audios = List.generate(
      20,
      (index) => 'audios/p40/${index + 1}.mp3',
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
    col = 5 - col; // Reverse the order of columns
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
     double topBase = 0.77;
    double rowSpacing = 0.09;
    double buttonWidth = 0.143;
    double buttonHeight = 0.079;


    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/img (41).jpg', 
              fit: BoxFit.fill,
            ),
          ),
          
          //...............
          AudioButtonWidget(
            buttonState: _buttonStates[6],
            audio: _audios[6],
            top: 0.235,
            left: .53,
            width: .287,
            heigt: .075,
          ),
           
          AudioButtonWidget(
            buttonState: _buttonStates[7],
            audio: _audios[7],
            top: 0.235,
            left: .2,
            width: .287,
            heigt: .075,
          ),
          //...............3 buttons
          AudioButtonWidget(
            buttonState: _buttonStates[2],
            audio: _audios[2],
            top: 0.057,
            left: .04,
            width: .29,
            heigt: .075,
          ),

           AudioButtonWidget(
            buttonState: _buttonStates[1],
            audio: _audios[1],
            top: 0.057,
            left: .35,
            width: .29,
            heigt: .075,
          ),AudioButtonWidget(
            buttonState: _buttonStates[0],
            audio: _audios[0],
            top: 0.057,
            left: .67,
            width: .29,
            heigt: .075,
          ),
          ///last 3 buttons
          AudioButtonWidget(
            buttonState: _buttonStates[5],
            audio: _audios[5],
            top: 0.145,
            left: .04,
            width: .29,
            heigt: .075,
          ),
           AudioButtonWidget(
            buttonState: _buttonStates[4],
            audio: _audios[4],
            top: 0.145,
            left: .35,
            width: .29,
            heigt: .075,
          ),AudioButtonWidget(
            buttonState: _buttonStates[3],
            audio: _audios[3],
            top: 0.145,
            left: .67,
            width: .29,
            heigt: .075,
          ),
          ///................shaad
          ///
          for (int i = 0; i < 12; i++)
            AudioButtonWidget(
              buttonState: _buttonStates[i+8],
              audio: _audios[i+8],
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