import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:greencode/Models/jokes.dart';

class JokesService {
  Future<Jokes> getJokes() async {
    final String url =
        "https://v2.jokeapi.dev/joke/Miscellaneous,Dark,Pun,Spooky,Christmas?blacklistFlags=nsfw,religious,political,racist,sexist,explicit&type=single";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final String responseString = response.body;
      return jokesFromJson(responseString);
    } else {
      return jsonDecode(response.body);
    }
  }
}
