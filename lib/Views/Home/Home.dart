import 'package:flutter/material.dart';
import 'package:greencode/Views/Home/Journal.dart';
import 'package:greencode/Views/Home/Meditate.dart';
import 'package:greencode/Views/Home/Profile.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Widget> bodyPages = [Profile(), Meditate(), Journal()];
  int _index = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: _index,
          selectedItemColor: Color(0xffEC7BA0),
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_rounded), label: "Personalise"),
            BottomNavigationBarItem(
                icon: Icon(Icons.hourglass_bottom_outlined), label: "Meditate"),
            BottomNavigationBarItem(
                icon: Icon(Icons.book_outlined), label: "Your Journal"),
          ],
          onTap: (int index) {
            setState(() {
              _index = index;
            });
          },
        ),
        body: Stack(
          children: [
            IndexedStack(
              index: _index,
              children: bodyPages,
            ),
          ],
        ));
  }
}
