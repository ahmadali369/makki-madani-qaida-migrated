import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../AudioButton.dart';
import '../boolGlobleState.dart';

class P43_S23 extends StatefulWidget {
  const P43_S23({super.key});

  @override
  State<P43_S23> createState() => _P43_S23State();
}

class _P43_S23State extends State<P43_S23> {
  late List<bool> _buttonStates;
  late final List<String> _audios;

  final audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _buttonStates = List<bool>.filled(45, false);
    _audios = List.generate(
      45,
      (index) => 'audios/p11/audio_${index + 1}.mp3',
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
    double base = 0.035; // left padding
    double spacing = 0.155; // space between columns
    return base + col * spacing;
  }

  double adjustedTop(int row) {
    double base = 0.385; // top padding adjusted to fit the grid
    double spacing = 0.084; // space between rows
    return base + row * spacing;
  }

 
  @override
  Widget build(BuildContext context) {
    double buttonWidth = 0.148;
    double buttonHeight = 0.08;



    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/img (52).jpg', 
              fit: BoxFit.fill,
            ),
          ),

           for (int i = 0; i < 12; i++)
            AudioButtonWidget(
              buttonState: _buttonStates[i],
              audio: _audios[i],
              top: adjustedTop(i ~/ 6)+0.3,
              left: adjustedLeft(i % 6),
              width: buttonWidth,
              heigt: buttonHeight*0.97,
            ),
          AudioButtonWidget(
            buttonState: _buttonStates[5],
            audio: _audios[5],
            top: 0.86,
            left: .064,
            width: .25,
            heigt: .076,
          ),  
          AudioButtonWidget(
            buttonState: _buttonStates[5],
            audio: _audios[5],
            top: 0.86,
            left: .335,
            width: .159,
            heigt: .076,
          ),
            AudioButtonWidget(
            buttonState: _buttonStates[5],
            audio: _audios[5],
            top: 0.86,
            left: .5,
            width: .159,
            heigt: .076,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[5],
            audio: _audios[5],
            top: 0.86,
            left: .68,
            width: .159,
            heigt: .076,
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