import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../AudioButton.dart';
import '../boolGlobleState.dart';

class P38_S19 extends StatefulWidget {
  const P38_S19({super.key});

  @override
  State<P38_S19> createState() => _P38_S19State();
}

class _P38_S19State extends State<P38_S19> {
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
              'assets/images/img (47).jpg', 
              fit: BoxFit.fill,
            ),
          ),

         
           
          //3 buttons
           //first row
             AudioButtonWidget(
            buttonState: _buttonStates[3],
            audio: _audios[3],
            top: 0.27,
            left: .0368,
            width: .307,
            heigt: .084,
          ),

           AudioButtonWidget(
            buttonState: _buttonStates[3],
            audio: _audios[3],
            top: 0.27,
            left: .35,
            width: .307,
            heigt: .084,
          ),
          //rightmost
          AudioButtonWidget(
            buttonState: _buttonStates[3],
            audio: _audios[3],
            top: 0.27,
            left: .66,
            width: .307,
            heigt: .084,
          ),
         //second row
          AudioButtonWidget(
            buttonState: _buttonStates[4],
            audio: _audios[4],
            top: 0.36,
            left: .0368,
            width: .307,
            heigt: .084,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[4],
            audio: _audios[4],
            top: 0.36,
            left: .35,
            width: .307,
            heigt: .084,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[4],
            audio: _audios[4],
            top: 0.36,
            left: .66,
            width: .307,
            heigt: .084,
          ),
          //third row
          AudioButtonWidget(
            buttonState: _buttonStates[5],
            audio: _audios[5],
            top: 0.447,
            left: .0368,
            width: .307,
            heigt: .084,
          ),  
          AudioButtonWidget(
            buttonState: _buttonStates[5],
            audio: _audios[5],
            top: 0.447,
            left: .35,
            width: .307,
            heigt: .084,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[5],
            audio: _audios[5],
            top: 0.447,
            left: .66,
            width: .307,
            heigt: .084,
          ),
          //fourth row
          AudioButtonWidget(  
            buttonState: _buttonStates[6],
            audio: _audios[6],
            top: 0.529,
            left: .0368,
            width: .307,
            heigt: .084,
          ),      
          AudioButtonWidget(
            buttonState: _buttonStates[6],
            audio: _audios[6],
            top: 0.529,
            left: .35,
            width: .307,
            heigt: .084,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[6],
            audio: _audios[6],
            top: 0.529,
            left: .66,
            width: .307,
            heigt: .084,
          ),
          //fifth row
          AudioButtonWidget(
            buttonState: _buttonStates[7],
            audio: _audios[7],
            top: 0.615,
            left: .0368,
            width: .307,
            heigt: .084,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[7],
            audio: _audios[7],
            top: 0.615,
            left: .35,
            width: .307,
            heigt: .084,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[7],
            audio: _audios[7],
            top: 0.615,
            left: .66,
            width: .307,
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