import 'dart:convert';

import 'package:tic/data_layer/models/link.dart';

UserDetails userDetailsFromJson(String str) =>
    UserDetails.fromJson(json.decode(str));

String userDetailsToJson(UserDetails data) => json.encode(data.toJson());

class UserDetails {
  UserDetails({
    required this.uid,
    required this.name,
    required this.email,
    required this.photoUrl,
    required this.phoneNumber,
    required this.friends,
    required this.links,
    required this.isVerify,
    required this.status,
    required this.bio,
    required this.directOn,
    required this.isDirect
  });
  String uid;
  String name;
  String email;
  String photoUrl;
  String phoneNumber;
  bool isVerify;
  List<dynamic> friends;
  List<Link>links;
  bool status;
  String bio;
  bool isDirect;
  Map<String,dynamic>directOn;


  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        name: json["name"],
        email: json["email"],
        photoUrl: json["photoUrl"],
        phoneNumber: json["PhoneNumber"],
        friends: List<String>.from(json["friends"].map((x) => x.toString())),
        links: List<Link>.from(json["links"].map((x)=>x)),
        uid:json['uid'],
        isVerify: json['isVerify'],
        status: json['status'],
        bio:json['bio'],
        directOn: json['directOn'],
        isDirect: json['isDirect'],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "photoUrl": photoUrl,
        "PhoneNumber": phoneNumber,
        "friends": List<String>.from(friends.map((x) => x)),
        "links": List<Map<String,dynamic>>.from(links.map((x) => x.toJson())),
  };
}
