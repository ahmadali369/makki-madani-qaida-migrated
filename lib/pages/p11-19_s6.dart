import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../AudioButton.dart';
import '../boolGlobleState.dart';

class P11_S6 extends StatefulWidget {
  const P11_S6({super.key});

  @override
  State<P11_S6> createState() => _P11_S6State();
}

class _P11_S6State extends State<P11_S6> {
  late List<bool> _buttonStates;
  late final List<String> _audios;

  final audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _buttonStates = List<bool>.filled(30, false);
    _audios = List.generate(
      18,
      (index) => 'audios/p19-1/${index + 1}.mp3',
    );
    _audios.addAll(
      List.generate(
        12,
        (index) => 'audios/p19-2/${index + 1}.mp3',
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
    col=5-col; // Adjusting column index to match the layout
    double base = 0.03; // left padding
    double spacing = 0.157; // space between columns
    return base + col * spacing;
  }

  double adjustedTop(int row) {
    double base = 0.299; // top padding
    double spacing = 0.089; // space between rows
    return base + row * spacing;
  }

  @override
  Widget build(BuildContext context) {
    double buttonWidth = 0.146;
    double buttonHeight = 0.085;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/img (20).jpg',
              fit: BoxFit.fill,
            ),
          ),

          // Render 18 buttons in 6 rows, 3 columns
          for (int i = 0; i < 18; i++)
            AudioButtonWidget(
              buttonState: _buttonStates[i],
              audio: _audios[i],
              top: adjustedTop(i ~/ 6),
              left: adjustedLeft(i % 6),
              width: buttonWidth,
              heigt: buttonHeight,
            ),
            for (int i = 18; i < 30; i++)
            AudioButtonWidget(
              buttonState: _buttonStates[i],
              audio: _audios[i],
             top: adjustedTop(3+(i-18)~/ 3)+0.036, 
            left: adjustedLeft( (i - 18) % 3*2),
              width: buttonWidth*2,
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
