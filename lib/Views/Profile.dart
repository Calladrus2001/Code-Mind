import 'package:flutter/material.dart';
import 'package:greencode/constants.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 60),
            Text("Personalise your App",
                style: TextStyle(
                    color: clr1, fontSize: 24, fontWeight: FontWeight.w800)),
            Divider(
              endIndent: 100,
            ),
            SizedBox(height: 16),
            Chip(
              elevation: 2.0,
              backgroundColor: Colors.white,
              label: Text(
                "Enable before-sleep questionnaire?",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            Chip(
              elevation: 2.0,
              backgroundColor: Colors.white,
              label: Text("Enable morning messages?",
                  style: TextStyle(color: Colors.grey, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
