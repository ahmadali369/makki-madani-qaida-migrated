import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../AudioButton.dart';
import '../boolGlobleState.dart';

class P58_S28 extends StatefulWidget {
  const P58_S28({super.key});

  @override
  State<P58_S28> createState() => _P58_S28State();
}

class _P58_S28State extends State<P58_S28> {
  late List<bool> _buttonStates;
  late final List<String> _audios;

  final audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _buttonStates = List<bool>.filled(7, false);
    _audios = List.generate(
      7,
      (index) => 'audios/p66/${index + 1}.mp3',
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

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/img (67).jpg', 
              fit: BoxFit.fill,
            ),
          ),
          

         
             AudioButtonWidget(
              buttonState: _buttonStates[0],
              audio: _audios[0],
              top: 0.113,
              left: 0.063,
              width: 0.9,
              heigt: 0.13,
            ),
            AudioButtonWidget(
              buttonState: _buttonStates[1],
              audio: _audios[1],
              top: 0.3,
              left: 0.063,
              width: 0.9,
              heigt: 0.05,
            ),
             AudioButtonWidget(
              buttonState: _buttonStates[2],
              audio: _audios[2],
              top: 0.36,
              left: 0.063,
              width: 0.9,
              heigt: 0.06,
            ),
             AudioButtonWidget(
              buttonState: _buttonStates[3],
              audio: _audios[3],
              top: 0.423,
              left: 0.063,
              width: 0.9,
              heigt: 0.14,
            ),
             AudioButtonWidget(
              buttonState: _buttonStates[4],
              audio: _audios[4],
              top: 0.57,
              left: 0.063,
              width: 0.9,
              heigt: 0.07,
            ),
             AudioButtonWidget(
              buttonState: _buttonStates[5],
              audio: _audios[5],
              top: 0.64,
              left: 0.063,
              width: 0.9,
              heigt: 0.07,
            ),
             AudioButtonWidget(
              buttonState: _buttonStates[6],
              audio: _audios[6],
              top: 0.72,
              left: 0.063,
              width: 0.9,
              heigt: 0.21,
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