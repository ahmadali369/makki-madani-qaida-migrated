import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../AudioButton.dart';
import '../boolGlobleState.dart';

class P52_S28 extends StatefulWidget {
  const P52_S28({super.key});

  @override
  State<P52_S28> createState() => _P52_S28State();
}

class _P52_S28State extends State<P52_S28> {
  late List<bool> _buttonStates;
  late final List<String> _audios;

  final audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _buttonStates = List<bool>.filled(8, false);
    _audios = List.generate(
      8,
      (index) => 'audios/p60/${index + 1}.mp3',
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
              'assets/images/img (61).jpg', 
              fit: BoxFit.fill,
            ),
          ),
          

         
             AudioButtonWidget(
              buttonState: _buttonStates[0],
              audio: _audios[0],
              top: 0.08,
              left: 0.36,
              width: 0.34,
              heigt: 0.065,
            ),
            AudioButtonWidget(
              buttonState: _buttonStates[1],
              audio: _audios[1],
              top: 0.2,
              left: 0.36,
              width: 0.34,
              heigt: 0.065,
            ),
            AudioButtonWidget(
              buttonState: _buttonStates[2],
              audio: _audios[2],
              top: 0.29,
              left: 0.16,
              width: 0.67,
              heigt: 0.065,
            ),
            AudioButtonWidget(
              buttonState: _buttonStates[3],
              audio: _audios[3],
              top: 0.39,
              left: 0.33,
              width: 0.37,
              heigt: 0.065,
            ),
             AudioButtonWidget(
              buttonState: _buttonStates[4],
              audio: _audios[4],
              top: 0.48,
              left: 0.33,
              width: 0.37,
              heigt: 0.065,
            ),
             AudioButtonWidget(
              buttonState: _buttonStates[5],
              audio: _audios[5],
              top: 0.59,
              left: 0.16,
              width: 0.67,
              heigt: 0.065,
            ),
             AudioButtonWidget(
              buttonState: _buttonStates[6],
              audio: _audios[6],
              top: 0.73,
              left: 0.16,
              width: 0.72,
              heigt: 0.065,
            ),
              AudioButtonWidget(
                buttonState: _buttonStates[7],
                audio: _audios[7],
                top: 0.85,
                left: 0.36,
                width: 0.34,
                heigt: 0.065,
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