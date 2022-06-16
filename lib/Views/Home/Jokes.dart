import 'package:flutter/material.dart';
import 'package:greencode/Models/jokes.dart';
import 'package:greencode/Services/jokesAPI.dart';
import 'package:greencode/constants.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

late Jokes _joke;

class _ProfileState extends State<Profile> {
  /// REST API call
  getJokes() async {
    Jokes joke = await JokesService().getJokes();
    setState(() {
      _joke = joke;
    });
  }

  @override
  void initState() {
    getJokes();
    super.initState();
  }

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
            Text("Endless Jokes",
                style: TextStyle(
                    color: clr1, fontSize: 24, fontWeight: FontWeight.w800)),
            Divider(
              endIndent: 100,
            ),
            SizedBox(height: 16),
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                border: Border.all(width: 1, color: clr1),
              ),
              child: Center(
                  child: _joke == null
                      ? CircularProgressIndicator()
                      : Text(
                          _joke.joke.toString(),
                          style: TextStyle(color: Colors.grey, fontSize: 20),
                          textAlign: TextAlign.center,
                        )),
            ),
            SizedBox(height: 8),
            GestureDetector(
              child: Center(
                child: Chip(
                  label: Text("Get a new Joke",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700)),
                  backgroundColor: clr1,
                  elevation: 4.0,
                ),
              ),
              onTap: () {
                setState(() {
                  getJokes();
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
