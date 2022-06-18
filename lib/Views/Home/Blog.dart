import 'package:flutter/material.dart';
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
      floatingActionButton: FloatingActionButton(
        heroTag: "btn1",
        child: Icon(Icons.chat_bubble_outlined, color: clr1),
        backgroundColor: Colors.white,
        onPressed: () {
          Get.to(() => ChatBot());
        },
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
