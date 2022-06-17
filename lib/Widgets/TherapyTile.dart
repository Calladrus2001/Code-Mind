import 'package:flutter/material.dart';
import 'package:greencode/Models/SearchResult.dart';
import 'package:greencode/constants.dart';

class TherapyTile {
  Widget buildTile(SearchResult res, int index) {
    return Card(
      elevation: 2.0,
      child: ListTile(
        title: Text(res.results![index].name.toString(),
            style: TextStyle(color: clr1)),
        subtitle: Text(res.results![index].formattedAddress.toString()),
        isThreeLine: true,
      ),
    );
  }
}
