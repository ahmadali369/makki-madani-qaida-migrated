import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../AudioButton.dart';
import '../boolGlobleState.dart';

class P42_S21 extends StatefulWidget {
  const P42_S21({super.key});

  @override
  State<P42_S21> createState() => _P42_S21State();
}

class _P42_S21State extends State<P42_S21> {
  late List<bool> _buttonStates;
  late final List<String> _audios;

  final audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _buttonStates = List<bool>.filled(45, false);
    _audios = List.generate(
      45,
      (index) => 'audios/p50/${index + 1}.mp3',
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
    col=5-col;
    double base = 0.035; // left padding
    double spacing = 0.155; // space between columns
    return base + col * spacing;
  }

  double adjustedTop(int row) {
    double base = 0.237; // top padding adjusted to fit the grid
    double spacing = 0.084; // space between rows
    return base + row * spacing;
  }

 
  @override
  Widget build(BuildContext context) {
    double buttonWidth = 0.148;
    double buttonHeight = 0.083;



    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/img (51).jpg', 
              fit: BoxFit.fill,
            ),
          ),
//5 buttons
 for (int i = 0; i < 5; i++)
            AudioButtonWidget(
              buttonState: _buttonStates[i],
              audio: _audios[i],
              top: adjustedTop(i ~/ 5)- 0.185,
              left: (0.024+(4-(i % 5))*0.19)+0.014,
              width: buttonWidth*1.2,
              heigt: buttonHeight*0.869,
            ),
            
           
           
          //3 buttons
          AudioButtonWidget(
            buttonState: _buttonStates[5],
            audio: _audios[5],
            top: 0.13,
            left: 0.66,
            width: 0.307,
            heigt: 0.084,
          ),
           //first row
             AudioButtonWidget(
            buttonState: _buttonStates[8],
            audio: _audios[8],
            top: 0.24,
            left: .0368,
            width: .307,
            heigt: .084,
          ),

           AudioButtonWidget(
            buttonState: _buttonStates[7],
            audio: _audios[7],
            top: 0.24,
            left: .35,
            width: .307,
            heigt: .084,
          ),
          //rightmost
          AudioButtonWidget(
            buttonState: _buttonStates[6],
            audio: _audios[6],
            top: 0.24,
            left: .66,
            width: .307,
            heigt: .084,
          ),
         //second row
          AudioButtonWidget(
            buttonState: _buttonStates[11],
            audio: _audios[11],
            top: 0.437,
            left: .0368,
            width: .307,
            heigt: .08,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[10],
            audio: _audios[10],
            top: 0.437,
            left: .35,
            width: .307,
            heigt: .08,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[9],
            audio: _audios[9],
            top: 0.437,
            left: .66,
            width: .307,
            heigt: .08,
          ),
          //third row
          AudioButtonWidget(
            buttonState: _buttonStates[14],
            audio: _audios[14],
            top: 0.526,
            left: .0368,
            width: .307,
            heigt: .08,
          ),  
          AudioButtonWidget(
            buttonState: _buttonStates[13],
            audio: _audios[13],
            top: 0.526,
            left: .35,
            width: .307,
            heigt: .08,
          ),
          AudioButtonWidget(
            buttonState: _buttonStates[12],
            audio: _audios[12],
            top: 0.526,
            left: .66,
            width: .307,
            heigt: .08,
          ),
           for (int i = 18; i < 30; i++)
            AudioButtonWidget(
              buttonState: _buttonStates[i-3],
              audio: _audios[i-3],
              top: adjustedTop(i ~/ 6)+0.3,
              left: adjustedLeft(i % 6),
              width: buttonWidth,
              heigt: buttonHeight*0.97,
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