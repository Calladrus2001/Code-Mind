import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:avatar_glow/avatar_glow.dart';

class Journal extends StatefulWidget {
  const Journal({Key? key}) : super(key: key);

  @override
  State<Journal> createState() => _JournalState();
}

class _JournalState extends State<Journal> {
  late stt.SpeechToText _speech;
  bool isStarted = false;
  bool isListening = false;
  Color clr1 = Color(0xffEC7BA0);
  String _text = "";

  void initState() {
    _speech = stt.SpeechToText();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isStarted
        ? Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: isListening
                ? AvatarGlow(
                    animate: isListening,
                    glowColor: clr1,
                    endRadius: 70.0,
                    duration: const Duration(milliseconds: 2000),
                    repeatPauseDuration: const Duration(milliseconds: 100),
                    repeat: true,
                    child: FloatingActionButton(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.mic,
                          color: Color(0xffEC7BA0),
                        ),
                        onPressed: () {
                          setState(() {
                            isListening = false;
                          });
                        }))
                : FloatingActionButton(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.mic_none,
                      color: Color(0xffEC7BA0),
                    ),
                    onPressed: () {
                      setState(() {
                        _listen();
                        isListening = true;
                      });
                    },
                  ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  SizedBox(height: 64),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: clr1,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Text(
                      "Question Text",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(height: 32),
                  Container(
                    width: double.infinity,
                    child: Text(_text),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.pinkAccent)),
                  )
                ],
              ),
            ),
          )
        : Scaffold(
            body: Stack(
              children: [
                Positioned(
                    left: 10,
                    right: 10,
                    bottom: 20,
                    child: GestureDetector(
                      child: Chip(
                        label: Text("Start", style: TextStyle(color: clr1)),
                        backgroundColor: Colors.white,
                        elevation: 4.0,
                      ),
                      onTap: () {
                        setState(() {
                          isStarted = true;
                        });
                      },
                    ))
              ],
            ),
          );
  }

  void _listen() async {
    if (!isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) {
          print('onStatus: $val');
          if (val == "done") {
            setState(() {
              // isComplete = true;
              isListening = false;
            });
          }
        },
        onError: (val) {},
      );
      if (available) {
        setState(() => isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
          }),
        );
      }
    } else {
      setState(() => isListening = false);
      _speech.stop();
    }
  }
}
