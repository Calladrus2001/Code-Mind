import 'dart:async';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as rtc_local_view;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as rtc_remote_view;
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:greencode/secrets.dart';

late String? channelName;
late ClientRole? role;
final box = GetStorage();

class CallPage extends StatefulWidget {
  const CallPage({Key? key}) : super(key: key);

  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  final _users = <int>[];
  final _infoStrings = <String>[];
  bool muted = false;
  bool viewPanel = false;
  late RtcEngine _engine;

  @override
  void initState() {
    channelName = box.read("channelName");
    role = box.read("role");
    initialise();
    super.initState();
  }

  @override
  void dispose() {
    _users.clear();
    _engine.leaveChannel();
    _engine.destroy();
    super.dispose();
  }

  Future<void> initialise() async {
    if (AppID.isEmpty) {
      setState(() {
        _infoStrings.add("APP ID is missing");
      });
      _infoStrings.add("AGORA engine didnt start");
      return;
    }

    /// init engine
    _engine = await RtcEngine.create(AppID);
    await _engine.enableVideo();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(role!);

    /// add agora event handlers
    _addAgoraEventHandlers();
    VideoEncoderConfiguration config = VideoEncoderConfiguration();
    config.dimensions = VideoDimensions(width: 1920, height: 1080);
    await _engine.setVideoEncoderConfiguration(config);
    await _engine.joinChannel(token, channelName!, null, 0);
  }

  void _addAgoraEventHandlers() {
    _engine.setEventHandler(RtcEngineEventHandler(error: (code) {
      setState(() {
        final info = "error: $code";
        _infoStrings.add(info);
      });
    }, joinChannelSuccess: (channel, uid, elapsed) {
      setState(() {
        final info = "Join channel $channel, uid: $uid";
        _infoStrings.add(info);
      });
    }, leaveChannel: (stats) {
      setState(() {
        _infoStrings.add("Leave channel");
        _users.clear();
      });
    }, userJoined: (uid, elapsed) {
      final info = "User Joined $uid";
      _infoStrings.add(info);
      _users.add(uid);
    }, userOffline: (uid, elapsed) {
      setState(() {
        final info = "User offline $uid";
        _infoStrings.add(info);
        _users.remove(uid);
      });
    }, firstRemoteVideoFrame: (uid, width, height, elapsed) {
      setState(() {
        final info = "First remote vid $uid $width x $height";
        _infoStrings.add(info);
      });
    }));
  }

  Widget _viewRows() {
    final List<StatefulWidget> list = [];
    if (role == ClientRole.Broadcaster) {
      list.add(rtc_local_view.SurfaceView());
    }
    for (var uid in _users) {
      list.add(rtc_remote_view.SurfaceView(
        uid: uid,
        channelId: channelName!,
      ));
    }
    final views = list;
    return Column(
      children: List.generate(
          views.length,
          (index) => Expanded(
                child: views[index],
              )),
    );
  }

  Widget _toolbar() {
    if (role == ClientRole.Audience) return const SizedBox();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
                heroTag: "btn1",
                child: Icon(muted ? Icons.mic_off_rounded : Icons.mic,
                    color: Colors.deepOrangeAccent),
                backgroundColor: Colors.white,
                onPressed: () {
                  setState(() {
                    muted = !muted;
                  });
                  _engine.muteLocalAudioStream(muted);
                }),
            SizedBox(width: 20),
            FloatingActionButton(
                heroTag: "btn2",
                backgroundColor: Colors.red,
                child: Icon(
                  Icons.call_end_rounded,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
            SizedBox(width: 20),
            FloatingActionButton(
                heroTag: "btn3",
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.switch_camera,
                  color: Colors.deepOrangeAccent,
                ),
                onPressed: () {
                  _engine.switchCamera();
                })
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Stack(
        children: [
          _viewRows(),
          _toolbar(),
        ],
      )),
    );
  }
}
