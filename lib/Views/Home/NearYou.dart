import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:greencode/Models/SearchResult.dart';
import 'package:greencode/Services/Geolocation_service.dart';
import 'package:greencode/Services/NearYouAPI.dart';
import 'package:greencode/Widgets/TherapyTile.dart';
import 'package:greencode/constants.dart';

class NearYou extends StatefulWidget {
  const NearYou({Key? key}) : super(key: key);

  @override
  State<NearYou> createState() => _NearYouState();
}

class _NearYouState extends State<NearYou> {
  late Position _currLocation;
  late SearchResult? result;
  bool haveResult = false;

  Future getResults() async {
    Position currLocation = await YourLocation().determinePosition();
    setState(() {
      _currLocation = currLocation;
    });
    result = await NearYouAPI().getResult(_currLocation);
    if (result != null) {
      setState(() {
        haveResult = true;
      });
    }
  }

  @override
  void initState() {
    getResults();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: haveResult
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.builder(
                itemBuilder: (context, int index) {
                  return TherapyTile().buildTile(result!, index);
                },
                itemCount: result!.results!.length,
                shrinkWrap: true,
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: CircularProgressIndicator(color: clr1),
                ),
                SizedBox(height: 32),
                Text("Fetching Mental Health Experts near you!",
                    style: TextStyle(color: Colors.grey))
              ],
            ),
    );
  }
}
