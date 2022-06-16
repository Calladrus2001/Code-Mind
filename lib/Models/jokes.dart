// To parse this JSON data, do
//
//     final jokes = jokesFromJson(jsonString);

import 'dart:convert';

Jokes jokesFromJson(String str) => Jokes.fromJson(json.decode(str));

String jokesToJson(Jokes data) => json.encode(data.toJson());

class Jokes {
  Jokes({
    this.error,
    this.category,
    this.type,
    this.joke,
    this.flags,
    this.safe,
    this.id,
    this.lang,
  });

  bool? error;
  String? category;
  String? type;
  String? joke;
  Flags? flags;
  bool? safe;
  int? id;
  String? lang;

  factory Jokes.fromJson(Map<String, dynamic> json) => Jokes(
        error: json["error"],
        category: json["category"],
        type: json["type"],
        joke: json["joke"],
        flags: Flags.fromJson(json["flags"]),
        safe: json["safe"],
        id: json["id"],
        lang: json["lang"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "category": category,
        "type": type,
        "joke": joke,
        "flags": flags!.toJson(),
        "safe": safe,
        "id": id,
        "lang": lang,
      };
}

class Flags {
  Flags({
    this.nsfw,
    this.religious,
    this.political,
    this.racist,
    this.sexist,
    this.explicit,
  });

  bool? nsfw;
  bool? religious;
  bool? political;
  bool? racist;
  bool? sexist;
  bool? explicit;

  factory Flags.fromJson(Map<String, dynamic> json) => Flags(
        nsfw: json["nsfw"],
        religious: json["religious"],
        political: json["political"],
        racist: json["racist"],
        sexist: json["sexist"],
        explicit: json["explicit"],
      );

  Map<String, dynamic> toJson() => {
        "nsfw": nsfw,
        "religious": religious,
        "political": political,
        "racist": racist,
        "sexist": sexist,
        "explicit": explicit,
      };
}
