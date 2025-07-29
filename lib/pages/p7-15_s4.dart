
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../AudioButton.dart';
import '../boolGlobleState.dart';

class P7_S4 extends StatefulWidget {
  const P7_S4({super.key});

  @override
  State<P7_S4> createState() => _P7_S4State();
}

class _P7_S4State extends State<P7_S4> {
  late List<bool> _buttonStates;
  late final List<String> _audios;

  final audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _buttonStates = List<bool>.filled(58, false);

    _audios = List.generate(
      29,
      (index) => 'audios/p15-1/${index + 1}.mp3',
    );
    _audios.addAll(
      List.generate(
        29,
        (index) => 'audios/p15-2/${index + 1}.mp3',
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

        await audioPlayer.play(AssetSource(_audios[i]));
        Duration? duration = await audioPlayer.getDuration();
        if (duration != null) await Future.delayed(duration);

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
              'assets/images/img (16).jpg',
              fit: BoxFit.fill,
            ),
          ),

          AudioButtonWidget(
            buttonState: _buttonStates[0],
            audio: _audios[0],
            top: 0.114,
            left: 0.04,
            width: 0.141,
           heigt: 0.069,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[1],
            audio: _audios[1],
            top: 0.114,
            left: 0.195,
            width: 0.145,
           heigt: 0.069,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[2],
            audio: _audios[2],
            top: 0.114,
            left: 0.35,
            width: 0.145,
           heigt: 0.069,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[3],
            audio: _audios[3],
            top: 0.114,
            left: 0.505,
            width: 0.145,
           heigt: 0.069,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[4],
            audio: _audios[4],
            top: 0.114,
            left: 0.66,
            width: 0.145,
           heigt: 0.069,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[5],
            audio: _audios[5],
            top: 0.114,
            left: 0.815,
            width: 0.145,
           heigt: 0.069,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[6],
            audio: _audios[6],
            top: 0.189,
            left: 0.04,
            width: 0.145,
           heigt: 0.069,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[7],
            audio: _audios[7],
            top: 0.189,
            left: 0.195,
            width: 0.145,
           heigt: 0.069,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[8],
            audio: _audios[8],
            top: 0.189,
            left: 0.35,
            width: 0.145,
           heigt: 0.069,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[9],
            audio: _audios[9],
            top: 0.189,
            left: 0.505,
            width: 0.145,
           heigt: 0.069,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[10],
            audio: _audios[10],
            top: 0.189,
            left: 0.66,
            width: 0.145,
           heigt: 0.069,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[11],
            audio: _audios[11],
            top: 0.189,
            left: 0.815,
            width: 0.145,
           heigt: 0.069,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[12],
            audio: _audios[12],
            top: 0.2655,
            left: 0.04,
            width: 0.145,
            heigt: 0.069,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[13],
            audio: _audios[13],
            top: 0.2655,
            left: 0.195,
            width: 0.145,
           heigt: 0.069,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[14],
            audio: _audios[14],
            top: 0.2655,
            left: 0.35,
            width: 0.145,
           heigt: 0.069,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[15],
            audio: _audios[15],
            top: 0.2655,
            left: 0.505,
            width: 0.145,
           heigt: 0.069,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[16],
            audio: _audios[16],
            top: 0.2655,
            left: 0.66,
            width: 0.145,
           heigt: 0.069,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[17],
            audio: _audios[17],
            top: 0.2655,
            left: 0.815,
            width: 0.145,
           heigt: 0.069,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[18],
            audio: _audios[18],
            top: 0.341,
            left: 0.04,
            width: 0.145,
           heigt: 0.069,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[19],
            audio: _audios[19],
            top: 0.341,
            left: 0.195,
            width: 0.145,
           heigt: 0.069,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[20],
            audio: _audios[20],
            top: 0.341,
            left: 0.35,
            width: 0.145,
           heigt: 0.069,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[21],
            audio: _audios[21],
            top: 0.341,
            left: 0.505,
            width: 0.145,
           heigt: 0.069,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[22],
            audio: _audios[22],
            top: 0.341,
            left: 0.66,
            width: 0.145,
           heigt: 0.069,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[23],
            audio: _audios[23],
            top: 0.341,
            left: 0.815,
            width: 0.145,
           heigt: 0.069,
          ),
          //last
          AudioButtonWidget(
            buttonState: _buttonStates[24],
            audio: _audios[24],
            top: 0.417,
            left: 0.120,
            width: 0.145,
           heigt: 0.069,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[25],
            audio: _audios[25],
            top: 0.417,
            left: 0.280,
            width: 0.145,
           heigt: 0.069,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[26],
            audio: _audios[26],
            top: 0.417,
            left: 0.435,
            width: 0.145,
           heigt: 0.069,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[27],
            audio: _audios[27],
            top: 0.417,
            left: 0.585,
            width: 0.145,
           heigt: 0.069,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[28],
            audio: _audios[28],
            top: 0.417,
            left: 0.735,
            width: 0.145,
           heigt: 0.069,
          ),

//peesh
          AudioButtonWidget(
            buttonState: _buttonStates[29],
            audio: _audios[29],
            top: 0.57,
            left: 0.04,
            width: 0.145,
           heigt: 0.069,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[30],
            audio: _audios[30],
            top: 0.57,
            left: 0.195,
            width: 0.145,
           heigt: 0.069,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[31],
            audio: _audios[31],
            top: 0.57,
            left: 0.35,
            width: 0.145,
           heigt: 0.069,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[32],
            audio: _audios[32],
            top: 0.57,
            left: 0.505,
            width: 0.145,
           heigt: 0.069,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[33],
            audio: _audios[33],
            top: 0.57,
            left: 0.66,
            width: 0.145,
           heigt: 0.069,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[34],
            audio: _audios[34],
            top: 0.57,
            left: 0.815,
            width: 0.145,
           heigt: 0.069,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[35],
            audio: _audios[35],
            top: 0.646,
            left: 0.04,
            width: 0.145,
           heigt: 0.069,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[36],
            audio: _audios[36],
            top: 0.646,
            left: 0.195,
            width: 0.145,
           heigt: 0.069,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[37],
            audio: _audios[37],
            top: 0.646,
            left: 0.35,
            width: 0.145,
           heigt: 0.069,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[38],
            audio: _audios[38],
            top: 0.646,
            left: 0.505,
            width: 0.145,
           heigt: 0.069,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[39],
            audio: _audios[39],
            top: 0.646,
            left: 0.66,
            width: 0.145,
           heigt: 0.069,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[40],
            audio: _audios[40],
            top: 0.646,
            left: 0.815,
            width: 0.145,
           heigt: 0.069,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[41],
            audio: _audios[41],
            top: 0.722,
            left: 0.04,
            width: 0.145,
           heigt: 0.069,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[42],
            audio: _audios[42],
            top: 0.722,
            left: 0.195,
            width: 0.145,
           heigt: 0.069,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[43],
            audio: _audios[43],
            top: 0.722,
            left: 0.35,
            width: 0.145,
           heigt: 0.069,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[44],
            audio: _audios[44],
            top: 0.722,
            left: 0.505,
            width: 0.145,
           heigt: 0.069,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[45],
            audio: _audios[45],
            top: 0.722,
            left: 0.66,
            width: 0.145,
           heigt: 0.069,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[46],
            audio: _audios[46],
            top: 0.722,
            left: 0.815,
            width: 0.145,
           heigt: 0.069,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[47],
            audio: _audios[47],
            top: 0.798,
            left: 0.04,
            width: 0.145,
           heigt: 0.069,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[48],
            audio: _audios[48],
            top: 0.798,
            left: 0.195,
            width: 0.145,
           heigt: 0.069,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[49],
            audio: _audios[49],
            top: 0.798,
            left: 0.35,
            width: 0.145,
           heigt: 0.069,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[50],
            audio: _audios[50],
            top: 0.798,
            left: 0.505,
            width: 0.145,
           heigt: 0.069,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[51],
            audio: _audios[51],
            top: 0.798,
            left: 0.66,
            width: 0.145,
           heigt: 0.069,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[52],
            audio: _audios[52],
            top: 0.798,
            left: 0.815,
            width: 0.145,
           heigt: 0.069,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[53],
            audio: _audios[53],
            top: 0.874,
            left: 0.120,
            width: 0.145,
           heigt: 0.069,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[54],
            audio: _audios[54],
            top: 0.874,
            left: 0.280,
            width: 0.145,
           heigt: 0.069,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[55],
            audio: _audios[55],
            top: 0.874,
            left: 0.435,
            width: 0.145,
           heigt: 0.069,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[56],
            audio: _audios[56],
            top: 0.874,
            left: 0.585,
            width: 0.145,
           heigt: 0.069,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[57],
            audio: _audios[57],
            top: 0.874,
            left: 0.735,
            width: 0.145,
           heigt: 0.069,
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
