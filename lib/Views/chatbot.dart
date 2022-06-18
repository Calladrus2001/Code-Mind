import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:greencode/constants.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({Key? key}) : super(key: key);

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  late DialogFlowtter instance;
  final messageController = new TextEditingController();
  Future<void> getInstance() async {
    instance = await DialogFlowtter.fromFile(
        path: "assets/pizza100-9a7f7d011fa1.json",
        sessionId: "fneuy28gfeuw3rfg");
  }

  @override
  void initState() {
    getInstance();
    super.initState();
  }

  @override
  void dispose() {
    instance.dispose();
    super.dispose();
  }

  List<Map> messsages = [];

  Future<void> getResponse() async {
    DetectIntentResponse response = await instance.detectIntent(
      queryInput: QueryInput(text: TextInput(text: messageController.text)),
    );
    String? textResponse = response.text;
    print(textResponse);
    setState(() {
      messsages.insert(0, {"data": 0, "message": textResponse});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
        child: Column(
          children: [
            SizedBox(height: 40),
            Center(
                child: Text("Chatting with Rei-sama",
                    style: TextStyle(color: Colors.grey))),
            SizedBox(height: 20),
            Flexible(
                child: ListView.builder(
                    reverse: true,
                    itemCount: messsages.length,
                    itemBuilder: (context, index) => chat(
                        messsages[index]["message"].toString(),
                        messsages[index]["data"]))),
            Container(
              child: ListTile(
                title: Container(
                  padding: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      color: Color(0xffF2F4F6),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: TextFormField(
                    controller: messageController,
                    decoration: InputDecoration(
                        hintText: "Send Message",
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none),
                    cursorColor: clr1,
                  ),
                ),
                trailing: GestureDetector(
                  child: Icon(Icons.send_outlined, color: clr1),
                  onTap: () {
                    getResponse();
                    setState(() {
                      messsages.insert(
                          0, {"data": 1, "message": messageController.text});
                    });
                    messageController.clear();
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget chat(String message, int data) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment:
            data == 1 ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          data == 0
              ? Container(
                  height: 60,
                  width: 60,
                  child: CircleAvatar(
                    backgroundColor: clr1,
                    child: Text("Rei", style: TextStyle(color: Colors.white)),
                  ),
                )
              : Container(),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Bubble(
                borderWidth: data == 0 ? 1 : 0,
                borderColor: clr1,
                radius: Radius.circular(15.0),
                color: data == 0 ? Colors.white : clr1,
                elevation: 0.0,
                child: Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        width: 10.0,
                      ),
                      Flexible(
                          child: Container(
                        constraints: BoxConstraints(maxWidth: 200),
                        child: Text(
                          message,
                          style: data == 0
                              ? TextStyle(
                                  color: clr1, fontWeight: FontWeight.bold)
                              : TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                        ),
                      ))
                    ],
                  ),
                )),
          ),
          data == 1
              ? Container(
                  child: CircleAvatar(
                    minRadius: 30,
                    child: CircleAvatar(
                      minRadius: 29,
                      backgroundColor: Colors.white,
                      child: Text("You", style: TextStyle(color: clr1)),
                    ),
                    backgroundColor: clr1,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
