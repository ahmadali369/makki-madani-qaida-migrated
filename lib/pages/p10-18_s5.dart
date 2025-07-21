import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../AudioButton.dart';
import '../boolGlobleState.dart';

class P10_S5 extends StatefulWidget {
  const P10_S5({super.key});

  @override
  State<P10_S5> createState() => _P10_S5State();
}

class _P10_S5State extends State<P10_S5> {
  late List<bool> _buttonStates;
  late final List<String> _audios;

  final audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _buttonStates = List<bool>.filled(72, false);
    _audios = List.generate(
      72,
      (index) => 'audios/p9/audio_${index + 1}.mp3',
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

  double adjustedTop(int row) {
    double base = 0.038;
    double spacing = 0.072;
    if (row > 4) base += 0.010;
    if (row >= 5) base += 0.024;
      double additionalGap = (row >= 5) ? (row - 4) * 0.033 : 0;
    return base + row * spacing+additionalGap;
  }

  @override
  Widget build(BuildContext context) {
    double buttonWidth = 0.143;
    double buttonHeight = 0.068;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/img (19).jpg',
              fit: BoxFit.fill,
            ),
          ),

          for (int i = 0; i < 30; i++)
            AudioButtonWidget(
              buttonState: _buttonStates[i],
              audio: _audios[i],
              top: adjustedTop(i ~/ 6)+0.02,
              left: adjustedLeft(i % 6),
              width: buttonWidth,
              heigt: buttonHeight,
            ),
            for (int i = 30; i < 48; i++)
            AudioButtonWidget(
              buttonState: _buttonStates[i],
              audio: _audios[i],
              top: adjustedTop(i ~/ 6)+0.072,
              left: adjustedLeft(i % 6),
              width: buttonWidth,
              heigt: buttonHeight+ 0.024, 
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
