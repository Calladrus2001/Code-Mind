import 'dart:async';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:greencode/constants.dart';
import 'package:permission_handler/permission_handler.dart';
import 'call.dart';
import 'package:flutter/material.dart';

var isBroadcaster = false;
var isAudience = false;
final box = GetStorage();

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final _channelController = TextEditingController();
  bool _validateError = false;
  ClientRole? _role = ClientRole.Broadcaster;

  @override
  void dispose() {
    _channelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white,
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const SizedBox(height: 80),
                  const Image(image: AssetImage("assets/images/intro.png")),
                  const SizedBox(height: 80),
                  TextField(
                    controller: _channelController,
                    decoration: InputDecoration(
                        hintText: "Channel Name",
                        errorText:
                            _validateError ? 'Channel name is mandatory' : null,
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(width: 1, color: clr1)),
                        border: const UnderlineInputBorder(
                          borderSide: BorderSide(width: 1),
                        )),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          child: Chip(
                            elevation: isBroadcaster ? 0 : 5.0,
                            labelPadding: const EdgeInsets.symmetric(
                                vertical: 2, horizontal: 15),
                            label: Text(
                              "Broadcaster",
                              style: TextStyle(
                                  color: isBroadcaster ? Colors.white : clr1),
                            ),
                            backgroundColor:
                                isBroadcaster ? clr1 : Colors.grey.shade100,
                          ),
                          onTap: () {
                            setState(() {
                              isBroadcaster = !isBroadcaster;
                              isAudience = false;
                              _role = ClientRole.Broadcaster;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 32),
                      Expanded(
                        child: GestureDetector(
                          child: Chip(
                            elevation: isAudience ? 0 : 5.0,
                            labelPadding: const EdgeInsets.symmetric(
                                vertical: 2, horizontal: 15),
                            label: Text(
                              "Audience",
                              style: TextStyle(
                                  color: isAudience ? Colors.white : clr1),
                            ),
                            backgroundColor:
                                isAudience ? clr1 : Colors.grey.shade100,
                          ),
                          onTap: () {
                            setState(() {
                              isBroadcaster = false;
                              isAudience = !isAudience;
                              _role = ClientRole.Audience;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 48),
                  GestureDetector(
                    child: Container(
                        height: 45,
                        width: double.infinity,
                        child: const Center(
                          child: Text(
                            "Join",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: clr1)),
                    onTap: () {
                      if (_role == ClientRole.Broadcaster) {
                        String body =
                            "\n~~Pizza100 ALERT~~\nSomeone that has listed you as an emergency contact is trying to contact you!\n\n Channel name: ${_channelController.text}\n\nJoin as Audience!";
                        // TwilioSMS().sendSMS(body);
                      }
                      onJoin();
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> onJoin() async {
    setState(() {
      _channelController.text.isEmpty
          ? _validateError = true
          : _validateError = false;
    });
    if (_channelController.text.isNotEmpty) {
      await _handleCameraAndMic(Permission.camera);
      await _handleCameraAndMic(Permission.microphone);
      box.write("channelName", _channelController.text);
      box.write("role", _role);
      Get.to(() => const CallPage());
    }
  }

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
  }
}
