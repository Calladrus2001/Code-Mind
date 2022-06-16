import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Therapist extends StatefulWidget {
  const Therapist({Key? key}) : super(key: key);

  @override
  State<Therapist> createState() => _TherapistState();
}

class _TherapistState extends State<Therapist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        GoogleMap(
          mapType: MapType.normal,
          myLocationButtonEnabled: true,
          initialCameraPosition:
              CameraPosition(target: LatLng(41.8781, 87.6298)),
        ),
        Positioned(
          height: 60,
          top: 40,
          left: 10,
          right: 10,
          child: Container(
            height: 50,
            width: double.infinity,
            child: const TextField(
              decoration:
                  InputDecoration(fillColor: Colors.white, filled: true),
            ),
          ),
        )
      ],
    ));
  }
}
