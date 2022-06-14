import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

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
    Color clr1 = Color(0xffEC7BA0);

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(Icons.play_arrow_outlined, color: clr1),
        onPressed: () async {
          if (isPlaying) {
            await audioplayer.pause();
          } else {
            await audioplayer.resume();
          }
          setState(() {
            isPlaying = !isPlaying;
          });
        },
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 64),
          Image(
            image: AssetImage("assets/images/meditate.png"),
          ),
          SizedBox(height: 8),
          Text(
            "Experience Peace",
            style: TextStyle(color: clr1, letterSpacing: 3, fontSize: 24),
          )
        ],
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
