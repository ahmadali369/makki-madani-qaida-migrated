import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../AudioButton.dart';
import '../boolGlobleState.dart';

class P37_S17 extends StatefulWidget {
  const P37_S17({super.key});

  @override
  State<P37_S17> createState() => _P37_S17State();
}

class _P37_S17State extends State<P37_S17> {
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

 
  @override
  Widget build(BuildContext context) {



    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/img (46).jpg', 
              fit: BoxFit.fill,
            ),
          ),

          AudioButtonWidget(
            buttonState: _buttonStates[0],
            audio: _audios[0],
            top: 0.067,
             left: 0.74,
            width: .22,
           heigt: .084,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[1],
            audio: _audios[1],
            top: 0.067,
             left: 0.511,
            width: .22,
           heigt: .084,
          ),
           
          AudioButtonWidget(
            buttonState: _buttonStates[2],
            audio: _audios[2],
            top: 0.067,
            left: .27,
            width: .22,
           heigt: .084,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[3],
            audio: _audios[3],
            top: 0.067,
            left: .04,
            width: .22,
           heigt: .084,
          ),
          //...............
           AudioButtonWidget(
            buttonState: _buttonStates[4],
            audio: _audios[4],
            top: 0.164,
              left: 0.74,
            width: .22,
           heigt: .084,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[5],
            audio: _audios[5],
            top: 0.164,
             left: 0.51,
            width: .22,
           heigt: .084,
          ),
           
          AudioButtonWidget(
            buttonState: _buttonStates[6],
            audio: _audios[6],
            top: 0.164,
           left: .27,
            width: .22,
           heigt: .084,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[7],
            audio: _audios[7],
            top: 0.164,
            left: .04,
            width: .22,
            heigt: .084,
          ),
          //...............
           AudioButtonWidget(
            buttonState: _buttonStates[0],
            audio: _audios[0],
            top: 0.27,
             left: 0.74,
            width: .22,
            heigt: .068,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[1],
            audio: _audios[1],
            top: 0.27,
             left: 0.510,
            width: .22,
            heigt: .068,
          ),
           
          AudioButtonWidget(
            buttonState: _buttonStates[2],
            audio: _audios[2],
            top: 0.27,
           left: .27,
            width: .22,
            heigt: .068,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[3],
            audio: _audios[3],
            top: 0.27,
            left: .04,
            width: .22,
            heigt: .068,
          ),
          //...............
           AudioButtonWidget(
            buttonState: _buttonStates[0],
            audio: _audios[0],
            top: 0.35,
              left: 0.74,
            width: .22,
            heigt: .068,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[1],
            audio: _audios[1],
            top:0.35,
             left: 0.510,
            width: .22,
            heigt: .068,
          ),
           
          AudioButtonWidget(
            buttonState: _buttonStates[2],
            audio: _audios[2],
            top:0.35,
           left: .27,
            width: .22,
            heigt: .068,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[3],
            audio: _audios[3],
            top: 0.35,
            left: .04,
            width: .22,
            heigt: .068,
          ),
          //...............
           AudioButtonWidget(
            buttonState: _buttonStates[0],
            audio: _audios[0],
            top: 0.427,
              left: 0.74,
            width: .22,
            heigt: .084,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[1],
            audio: _audios[1],
            top:0.427,
             left: 0.510,
            width: .22,
            heigt: .084,
          ),
           
          AudioButtonWidget(
            buttonState: _buttonStates[2],
            audio: _audios[2],
            top:0.427,
           left: .27,
            width: .22,
            heigt: .084,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[3],
            audio: _audios[3],
            top:0.427,
            left: .04,
            width: .22,
            heigt: .084,
          ),
          //...............
           AudioButtonWidget(
            buttonState: _buttonStates[0],
            audio: _audios[0],
            top: 0.53,
              left: 0.74,
            width: .22,
            heigt: .084,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[1],
            audio: _audios[1],
            top:0.53,
             left: 0.510,
            width: .22,
            heigt: .084,
          ),
           
          AudioButtonWidget(
            buttonState: _buttonStates[2],
            audio: _audios[2],
            top:0.53,
           left: .27,
            width: .22,
            heigt: .084,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[3],
            audio: _audios[3],
            top:0.53,
            left: .04,
            width: .22,
            heigt: .084,
          ),
          //...............
           
          //3 buttons
           
             AudioButtonWidget(
            buttonState: _buttonStates[3],
            audio: _audios[3],
            top: 0.63,
            left: .04,
            width: .29,
            heigt: .084,
          ),

           AudioButtonWidget(
            buttonState: _buttonStates[3],
            audio: _audios[3],
            top: 0.63,
            left: .35,
            width: .29,
            heigt: .084,
          ),
          //rightmost
          AudioButtonWidget(
            buttonState: _buttonStates[3],
            audio: _audios[3],
            top: 0.63,
            left: .66,
            width: .29,
            heigt: .084,
          ),
          ///last 3 buttons
          AudioButtonWidget(
            buttonState: _buttonStates[3],
            audio: _audios[3],
            top: 0.73,
            left: .04,
            width: .29,
            heigt: .084,
          ),
           AudioButtonWidget(
            buttonState: _buttonStates[3],
            audio: _audios[3],
            top: 0.73,
            left: .35,
            width: .29,
            heigt: .084,
          ),AudioButtonWidget(
            buttonState: _buttonStates[3],
            audio: _audios[3],
            top: 0.73,
            left: .67,
            width: .29,
            heigt: .084,
          ),
           AudioButtonWidget(
            buttonState: _buttonStates[1],
            audio: _audios[1],
            top: 0.83,
             left: 0.51,
            width: .29,
            heigt: .084,
          ),
           
          AudioButtonWidget(
            buttonState: _buttonStates[2],
            audio: _audios[2],
            top: 0.83,
           left: .2,
            width: .29,
            heigt: .084,
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