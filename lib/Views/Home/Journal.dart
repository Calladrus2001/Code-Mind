import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:greencode/constants.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Journal extends StatefulWidget {
  const Journal({Key? key}) : super(key: key);

  @override
  State<Journal> createState() => _JournalState();
}

class _JournalState extends State<Journal> {
  late stt.SpeechToText _speech;
  bool isStarted = false;
  bool isListening = false;
  bool isComplete = false;
  String _entry = "";
  String _text = "";
  int _index = 0;
  late FirebaseFirestore firestore;
  final Stream<QuerySnapshot> journalStream = FirebaseFirestore.instance
      .collection('users')
      .doc("${FirebaseAuth.instance.currentUser!.email}")
      .collection("JournalEntries")
      .snapshots();

  void initState() {
    _speech = stt.SpeechToText();
    firestore = FirebaseFirestore.instance;
    super.initState();
  }

  CollectionReference entries = FirebaseFirestore.instance
      .collection('users')
      .doc("${FirebaseAuth.instance.currentUser!.email}")
      .collection("JournalEntries");

  @override
  Widget build(BuildContext context) {
    return isStarted
        ? Scaffold(
            backgroundColor: Colors.white,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: isComplete
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FloatingActionButton(
                          heroTag: "btn1",
                          backgroundColor: Colors.white,
                          child: const Icon(Icons.refresh_rounded,
                              color: Color(0xffEC7BA0)),
                          onPressed: () {
                            setState(() {
                              _text = " ";
                              isComplete = false;
                            });
                          }),
                      const SizedBox(width: 12),
                      const Text("or", style: TextStyle(color: Colors.grey)),
                      const SizedBox(width: 12),
                      FloatingActionButton(
                          heroTag: "btn2",
                          backgroundColor: Colors.white,
                          child: const Icon(Icons.arrow_forward_ios_rounded,
                              color: Color(0xffEC7BA0)),
                          onPressed: () async {
                            if (_index < Questions.length - 1) {
                              setState(() {
                                _entry = _entry + "\n" + _text;
                                _text = " ";
                                _index += 1;
                                isComplete = false;
                              });
                            } else {
                              /// write to db
                              addEntry();
                              _index = 0;
                              sleep(Duration(milliseconds: 1500));
                              setState(() {
                                isStarted = false;
                              });
                            }
                          }),
                    ],
                  )
                : AvatarGlow(
                    animate: isListening,
                    glowColor: clr1,
                    endRadius: 70.0,
                    duration: const Duration(milliseconds: 2000),
                    repeatPauseDuration: const Duration(milliseconds: 100),
                    repeat: true,
                    child: isListening
                        ? FloatingActionButton(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.mic,
                              color: Color(0xffEC7BA0),
                            ),
                            onPressed: () {
                              setState(() {
                                isListening = false;
                              });
                            })
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
                          )),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  SizedBox(height: 64),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: clr1,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Text(
                      Questions[_index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 32),
                  Container(
                    width: double.infinity,
                    child: Text(_text,
                        style: TextStyle(color: Colors.grey, fontSize: 18)),
                  )
                ],
              ),
            ),
          )
        : Scaffold(
            backgroundColor: Colors.white,
            floatingActionButton: FloatingActionButton(
              elevation: 4.0,
              child: Icon(Icons.add, color: clr1),
              backgroundColor: Colors.white,
              onPressed: () {
                setState(() {
                  isStarted = true;
                });
              },
            ),
            body: StreamBuilder(
              stream: journalStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }
                if (snapshot.hasError) {
                  return Center(child: CircularProgressIndicator(color: clr1));
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      return Card(
                        elevation: 4.0,
                        child: ListTile(
                          title: Text(data['dateAdded'],
                              style: TextStyle(color: clr1)),
                          subtitle: Text(data['Entry']),
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          );
  }

  Future<void> addEntry() {
    // Call the user's CollectionReference to add a new user
    return entries
        .add({
          "Entry": _entry,
          "dateAdded":
              "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}"
        })
        .then((value) => print("Entry Added"))
        .catchError((error) => print("Failed to add entry: $error"));
  }

  void _listen() async {
    if (!isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) {
          print('onStatus: $val');
          if (val == "done") {
            setState(() {
              isComplete = true;
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
