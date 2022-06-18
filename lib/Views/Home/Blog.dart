import 'package:flutter/material.dart';
import 'package:greencode/Views/Call/index.dart';
import 'package:greencode/Views/chatbot.dart';
import 'package:greencode/Widgets/MentalPage.dart';
import 'package:greencode/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

class Blog extends StatefulWidget {
  const Blog({Key? key}) : super(key: key);

  @override
  State<Blog> createState() => _BlogState();
}

class _BlogState extends State<Blog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            heroTag: "btn1",
            child: Icon(Icons.chat_bubble_outlined, color: clr1),
            backgroundColor: Colors.white,
            onPressed: () {
              Get.to(() => ChatBot());
            },
          ),
          SizedBox(width: 8),
          Text("or", style: TextStyle(color: Colors.grey)),
          SizedBox(width: 8),
          FloatingActionButton(
            heroTag: "btn2",
            child: Icon(Icons.videocam_outlined, color: clr1),
            backgroundColor: Colors.white,
            onPressed: () {
              Get.to(() => IndexPage());
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: PageView(
        children: [
          MentalPage().buildPage(0),
          MentalPage().buildPage(1),
          MentalPage().buildPage(2),
          MentalPage().buildPage(3),
        ],
      ),
    );
  }
}
