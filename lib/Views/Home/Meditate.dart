import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:greencode/constants.dart';

class Meditate extends StatefulWidget {
  const Meditate({Key? key}) : super(key: key);

  @override
  State<Meditate> createState() => _MeditateState();
}

class _MeditateState extends State<Meditate> {
  late AudioPlayer audioplayer;
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  bool isTimeSelected = false;
  var _value;

  @override
  void initState() {
    audioplayer = AudioPlayer();
    setAudio();
    super.initState();

    audioplayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.PLAYING;
      });
    });
    audioplayer.onDurationChanged.listen((newD) {
      setState(() {
        duration = newD;
      });
    });
    audioplayer.onAudioPositionChanged.listen((newpos) {
      setState(() {
        position = newpos;
      });
    });
  }

  @override
  void dispose() {
    audioplayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: isPlaying
            ? Icon(Icons.pause, color: clr1)
            : Icon(
                Icons.play_arrow_outlined,
                color: clr1,
                size: 28,
              ),
        onPressed: () async {
          if (isTimeSelected) {
            if (isPlaying) {
              await audioplayer.pause();
            } else {
              await audioplayer.resume();
            }
            setState(() {
              isPlaying = !isPlaying;
            });
          } else {
            print("select time");
          }
        },
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            SizedBox(height: 64),
            Image(
              image: AssetImage("assets/images/meditate.png"),
            ),
            SizedBox(height: 8),
            Text(
              "Experience Peace",
              style: TextStyle(color: clr1, letterSpacing: 3, fontSize: 24),
            ),
            SizedBox(height: 48),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(
                4,
                (int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: ChoiceChip(
                      selectedColor: clr1,
                      disabledColor: Colors.grey,
                      label: Text('${15 * (index + 1)} min',
                          style: TextStyle(color: Colors.white)),
                      selected: _value == index,
                      onSelected: (bool selected) {
                        setState(() {
                          _value = selected ? index : null;
                          if (_value == null) {
                            isTimeSelected = false;
                          } else {
                            isTimeSelected = true;
                          }
                        });
                      },
                    ),
                  );
                },
              ).toList(),
            )
          ],
        ),
      ),
    );
  }

  Future setAudio() async {
    audioplayer.setReleaseMode(ReleaseMode.LOOP);
    final player = AudioCache(prefix: "assets/audio/");
    final url = await player.load("Arnor.mp3");
    audioplayer.setUrl(url.path, isLocal: true);
  }
}
