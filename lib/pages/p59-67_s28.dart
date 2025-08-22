import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../AudioButton.dart';
import '../boolGlobleState.dart';

class P59_S28 extends StatefulWidget {
  const P59_S28({super.key});

  @override
  State<P59_S28> createState() => _P59_S28State();
}

class _P59_S28State extends State<P59_S28> {
  late List<bool> _buttonStates;
  late final List<String> _audios;

  final audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _buttonStates = List<bool>.filled(8, false);
    _audios = List.generate(
      8,
      (index) => 'audios/p67/${index + 1}.mp3',
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
              'assets/images/img (68).jpg', 
              fit: BoxFit.fill,
            ),
          ),
          

         
             AudioButtonWidget(
              buttonState: _buttonStates[0],
              audio: _audios[0],
              top: 0.056,
              left: 0.061,
              width: 0.89,
              heigt: 0.07,
            ),
            AudioButtonWidget(
              buttonState: _buttonStates[1],
              audio: _audios[1],
              top: 0.13,
              left: 0.061,
              width: 0.89,
              heigt: 0.14,
            ),
            AudioButtonWidget(
              buttonState: _buttonStates[2],
              audio: _audios[2],
              top: 0.276,
              left: 0.061,
              width: 0.89,
              heigt: 0.07,
            ),
            AudioButtonWidget(
              buttonState: _buttonStates[3],
              audio: _audios[3],
              top: 0.35,
              left: 0.061,
              width: 0.89,
              heigt: 0.07,
            ),
            AudioButtonWidget(
              buttonState: _buttonStates[4],
              audio: _audios[4],
              top: 0.423,
              left: 0.061,
              width: 0.89,
              heigt: 0.07,
            ),
            AudioButtonWidget(
              buttonState: _buttonStates[5],
              audio: _audios[5],
              top: 0.5,
              left: 0.061,
              width: 0.89,
              heigt: 0.07,
            ),
            AudioButtonWidget(
              buttonState: _buttonStates[6],
              audio: _audios[6],
              top: 0.576,
              left: 0.061,
              width: 0.9,
              heigt: 0.28,
            ),
            AudioButtonWidget(
              buttonState: _buttonStates[7],
              audio: _audios[7],
              top: 0.865,
              left: 0.061,
              width: 0.89,
              heigt: 0.07,
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