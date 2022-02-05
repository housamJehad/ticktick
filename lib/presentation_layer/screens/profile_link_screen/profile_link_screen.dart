import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic/business_logic_layer/authentication/data/providers/income_friend_provider.dart';
import 'package:tic/business_logic_layer/authentication/data/providers/user_provider.dart';
import 'package:tic/constant/my_colors.dart';
import 'package:tic/data_layer/models/freind_data.dart';
import 'package:tic/presentation_layer/screens/friend_screen/friend_detail_screen1.dart';
import 'package:tic/presentation_layer/screens/home_screen/home_screen.dart';

class ProfileLinkScreen extends StatefulWidget {
  const ProfileLinkScreen({Key? key, required this.name}) : super(key: key);
  final String name;

  @override
  _ProfileLinkScreenState createState() => _ProfileLinkScreenState();
}

class _ProfileLinkScreenState extends State<ProfileLinkScreen> {
 String finalUri="";
  FriendData linkUser = FriendData(
      name: "",
      isDirect: false,
      directOn: {},
      photoUrl: "",
      links: {},
      status: false,
      index: 0,
      uid: "",
      bio: "",
      email: "");
  bool isFriend=false,isTheSameAccount=false;
  String finalName="";
  String friendUid="";

  @override
  void initState() {

    setState(() {
      if(widget.name.isNotEmpty){
        finalUri= widget.name.substring(6, widget.name.trim().length);
      }else{
        setState(() {
          finalUri="";
        });
      }
      Provider.of<IncomeFriend>(context,listen: false).friendUserName="";
    });
    getLinkDetails(finalUri);
    super.initState();
  }


  getLinkDetails(String name) async {
    await FirebaseFirestore.instance
        .collection('User')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        if (doc['email'] == name) {
          setState(() {
            friendUid=doc['uid'];
            linkUser.email = doc['email'];
            linkUser.bio = doc['bio'];
            linkUser.links = doc['links'];
            linkUser.status = doc['status'];
            linkUser.photoUrl = doc['photoUrl'];
            linkUser.name = doc['name'];
            linkUser.uid=doc['uid'];
            linkUser.index = 0;
          });
         }
      }
    });
    List<dynamic>?friendIds=Provider.of<UserProvider>(context,listen: false).friend;
    if(friendIds!.isEmpty){
      setState(() {
        isFriend=false;
      });
    }else{
      for (String element in friendIds) {
        if(element==friendUid){
          setState(() {
            isFriend=true;
          });
          break;
        }
      }
    }
    String loginId=Provider.of<UserProvider>(context,listen: false).uid as String;
    if(linkUser.uid==loginId){
      setState(() {
        isTheSameAccount=true;
      });
    }else{
      setState(() {
        isTheSameAccount=false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String,dynamic>data={};
    return Scaffold(
      body: linkUser.name!.isEmpty?const Center(
        child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(MyColors.myOrange)),
      ):isTheSameAccount?const HomeScreen(whichScreen: 0):FriendDetailScreen1(friendData: linkUser,type: 1,data:data,isFriend: isFriend,),
    );
  }
}
