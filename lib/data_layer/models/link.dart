// To parse this JSON data, do
//
//     final link = linkFromJson(jsonString);

import 'dart:convert';

Link linkFromJson(String str) => Link.fromJson(json.decode(str));

String linkToJson(Link data) => json.encode(data.toJson());

class Link {
  Link({
    required this.type,
    required this.link,
  });

  final String type;
  final String link;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    type: json["type"],
    link: json["link"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "link": link,
  };
}
