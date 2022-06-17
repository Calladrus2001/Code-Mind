import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greencode/Views/Auth.dart';
import 'package:greencode/Views/Home/Home.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: Intro(),
    );
  }
}

class Intro extends StatelessWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 150),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SizedBox(
                    width: 320,
                    child: Image(image: AssetImage("assets/images/intro.png"))),
              ],
            ),
            const SizedBox(height: 24),
            const Text("Code:Mind",
                style: TextStyle(
                    color: Color(0xffEC7BA0), letterSpacing: 10, fontSize: 24)),
            const SizedBox(height: 36),
            const Expanded(child: SizedBox(height: 1)),
            GestureDetector(
              child: Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 1, color: Color(0xffEC7BA0)),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: const Center(
                  child: Text("Let's go!",
                      style: TextStyle(
                          color: Color(0xffEC7BA0),
                          letterSpacing: 2,
                          fontSize: 18)),
                ),
              ),
              onTap: () {
                Get.to(() => AuthScreen());
              },
            ),
            const SizedBox(height: 120)
          ],
        ),
      ),
    );
  }
}
