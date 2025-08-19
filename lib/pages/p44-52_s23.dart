import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../AudioButton.dart';
import '../boolGlobleState.dart';

class P44_S23 extends StatefulWidget {
  const P44_S23({super.key});

  @override
  State<P44_S23> createState() => _P44_S23State();
}

class _P44_S23State extends State<P44_S23> {
  late List<bool> _buttonStates;
  late final List<String> _audios;

  final audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _buttonStates = List<bool>.filled(37, false);
    _audios = List.generate(
      37,
      (index) => 'audios/p52/${index + 1}.mp3',
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
    col=4-col;
    double base = 0.05; // left padding
    double spacing = 0.185; // space between columns
    return base + col * spacing;
  }

  double adjustedTop(int row) {
    double base = 0.059; // top padding adjusted to fit the grid
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
              'assets/images/img (53).jpg', 
              fit: BoxFit.fill,
            ),
          ),

           for (int i = 0; i < 14; i++)
            AudioButtonWidget(
              buttonState: _buttonStates[i],
              audio: _audios[i],
              top: adjustedTop(i ~/ 5),
              left: adjustedLeft(i % 5),
              width: buttonWidth,
              heigt: buttonHeight*0.97,
            ),
          AudioButtonWidget(
            buttonState: _buttonStates[14],
            audio: _audios[14],
            top: 0.33,
            left: .815,
            width: .15,
            heigt: .072,
          ),  
          AudioButtonWidget(
            buttonState: _buttonStates[15],
            audio: _audios[15],
            top: 0.33,
            left: .656,
            width: .15,
            heigt: .072,
          ), 
            AudioButtonWidget(
            buttonState: _buttonStates[16],
            audio: _audios[16],
            top: 0.33,
            left: .5,
            width: .15,
            heigt: .072,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[17],
            audio: _audios[17],
            top: 0.33,
            left: .345,
            width: .15,
            heigt: .072,
          ), 
          AudioButtonWidget(
            buttonState: _buttonStates[18],
            audio: _audios[18],
            top: 0.33,
            left: .19,
            width: .15,
            heigt: .072,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[19],
            audio: _audios[19],
            top: 0.33,
            left: .035,
            width: .15,
            heigt: .072,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[20],
            audio: _audios[20],
            top: 0.413,
            left: .815,
            width: .15,
            heigt: .072,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[21],
            audio: _audios[21],
            top: 0.413,
            left: .656,
            width: .15,
            heigt: .072,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[22],
            audio: _audios[22],
            top: 0.413,
            left: .5,
            width: .15,
            heigt: .072,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[23],
            audio: _audios[23],
            top: 0.413,
            left: .345,
            width: .15,
            heigt: .072,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[24],
            audio: _audios[24],
            top: 0.413,
            left: .19,
            width: .15,
            heigt: .072,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[25],
            audio: _audios[25],
            top: 0.413,
            left: .035,
            width: .15,
            heigt: .072,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[26],
            audio: _audios[26],
            top: 0.496,
            left: .815,
            width: .15,
            heigt: .072,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[27],
            audio: _audios[27],
            top: 0.496,
            left: .56,
            width: .25,
            heigt: .072,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[28],
            audio: _audios[28],
            top: 0.496,
            left: .3,
            width: .25,
            heigt: .072,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[29],
            audio: _audios[29],
            top: 0.496,
            left: .045,
            width: .25,
            heigt: .072,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[30],
            audio: _audios[30],
            top: 0.579,
            left: .415,
            width: .25,
            heigt: .072,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[31],
            audio: _audios[31],
            top: 0.72,
            left: 0.72,
            width: .236,
            heigt: .06,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[32],
            audio: _audios[32],
            top: 0.72,
            left: 0.46,
            width: .236,
            heigt: .06,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[33],
            audio: _audios[33],
            top: 0.72,
            left: 0.1,
            width: .26,
            heigt: .06,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[34],
            audio: _audios[34],
            top: 0.82,
            left: 0.7,
            width: .22,
            heigt: .06,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[35],
            audio: _audios[35],
            top: 0.82,
            left: 0.44,
            width: .22,
            heigt: .06,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[36],
            audio: _audios[36],
            top: 0.82,
            left: 0.12,
            width: .24,
            heigt: .06,
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