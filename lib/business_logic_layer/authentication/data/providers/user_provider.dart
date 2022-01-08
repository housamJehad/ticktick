import 'package:flutter/cupertino.dart';
import 'package:tic/data_layer/models/link.dart';

class UserProvider extends ChangeNotifier{

  String ?name;
  String ?email;
  String ?imageUrl;
  bool ?isVerify;
  String ?uid;
  bool ?status;
  String? number;
  String ?userName;
  String ?loginType;
  List<dynamic>?friend;
  List<Link>?links;
  String ?bio;
  bool ?isDirect;
  String ?userNameLink;
  Map<String,dynamic>?directOn;
  String ?incomeFriend;
  UserProvider({this.name, this.email, this.imageUrl, this.isVerify, this.uid,this.number,this.userName,this.loginType,this.links,this.friend,this.bio,this.isDirect,this.directOn,this.status,this.userNameLink,this.incomeFriend});
}