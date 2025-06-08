import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../boolGlobleState.dart';
class AudioButtonWidget extends StatefulWidget {
  AudioButtonWidget(
      {super.key,
        required this.buttonState,
        required this.audio,
        required this.left,
        required this.top,
        required this.width,
        required this.heigt});

  double left;
  double top;
  double width;
  double heigt;

  bool buttonState;
  String audio;

  @override
  State<AudioButtonWidget> createState() => _AudioButtonWidgetState();
}

class _AudioButtonWidgetState extends State<AudioButtonWidget> {
  final audioPlayer = AudioPlayer();
  bool buttonLocalState = false;

  void _triggerButton(bool state) {
    setState(() {
      state = !state;
      buttonLocalState = !buttonLocalState;
    });
  }

  void _triggerButtonManullay(bool state, String audio) async {
    setState(() {
      BoolState.toggleOneButtonRunning();
    });

    _triggerButton(state);
    await audioPlayer.play(AssetSource(audio));

    /// duartion
    Future<Duration?> nullableFutureDuration = audioPlayer.getDuration();
    Duration? nullableDuration = await nullableFutureDuration;
    if (nullableDuration == null) {
      throw Exception('Nullable duration is null');
    }
    await Future.delayed(nullableDuration);

    _triggerButton(state);

    setState(() {
      BoolState.toggleOneButtonRunning();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: MediaQuery.of(context).size.width *
          widget.left, // Adjust the left position as needed.
      top: MediaQuery.of(context).size.height *
          widget.top, // Adjust the top position as needed.

      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(5),
        ),

        width: MediaQuery.of(context).size.width * widget.width,
        height: MediaQuery.of(context).size.height * widget.heigt,
        clipBehavior: Clip.antiAlias,

        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shadowColor: Colors.transparent,


            backgroundColor: (widget.buttonState || buttonLocalState)
                ? const Color(0xbbB3E6E1)
                : Colors.transparent,



            shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(0.0), // Optional: Set border radius
            ),
          ),
          onPressed: () async {
            if (BoolState.oneButtonRunning == false &&
                BoolState.oneStreamRunning == false) {
              _triggerButtonManullay(widget.buttonState, widget.audio);
            }
          },
          child: const SizedBox(),
        ),
        // Change the color as needed.
      ),
    );
  }
}