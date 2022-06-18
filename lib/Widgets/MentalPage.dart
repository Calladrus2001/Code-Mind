import 'package:flutter/material.dart';
import 'package:greencode/constants.dart';

class MentalPage {
  List<AssetImage> images = [
    AssetImage("assets/images/autism.png"),
    AssetImage("assets/images/anxiety.png"),
    AssetImage("assets/images/depression.png"),
    AssetImage("assets/images/schizophrenia.png"),
  ];
  List<String> name = ["Autism", "Anxiety", "Depression", "Schizophrenia"];
  List<String> info = [
    "Autism is a complex developmental disorder that can cause problems with thinking, feeling, language and the ability to relate to others. Many individuals with autism also live with mental illness like anxiety or depression.",
    "All anxiety disorders have one thing in common: persistent, excessive fear or worry in situations that are not threatening.",
    "Depressive disorder, frequently referred to simply as depression, is more than just feeling sad or going through a rough patch. It’s a serious mental health condition that requires understanding and medical care.",
    "Schizophrenia is a serious mental illness that interferes with a person’s ability to think clearly, manage emotions, make decisions and relate to others. It is a complex, long-term medical illness."
  ];
  Widget buildPage(int _index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Container(height: 400, child: Image(image: images[_index])),
          Text(name[_index], style: TextStyle(color: clr1, fontSize: 24)),
          SizedBox(height: 32),
          Text(info[_index],
              style: TextStyle(color: Colors.grey, fontSize: 16),
              textAlign: TextAlign.center)
        ],
      ),
    );
  }
}
