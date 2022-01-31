import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tic/business_logic_layer/authentication/data/providers/income_friend_provider.dart';
import 'package:tic/business_logic_layer/authentication/data/providers/user_provider.dart';
import 'package:tic/data_layer/models/deep_link_name.dart';
import 'package:tic/data_layer/models/link.dart';
import 'package:tic/presentation_layer/screens/home_screen/home_screen.dart';
import 'package:tic/presentation_layer/screens/login_creat_screens/log_option_screen.dart';
import 'package:tic/presentation_layer/screens/no_internet_screen/no_internet.dart';
import 'package:tic/presentation_layer/widgets/indicator/circle)ind.dart';


class SplashScreen extends StatefulWidget {
  final String outUri;
  const SplashScreen({Key? key, required this.outUri}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String finalDocId = "";
  Widget bufferWidget = const CircleInd();
  bool isHasIncomeLink=false;
  String finalUserName="";
  Future getExistData(context) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? docId = sharedPreferences.getString("docId");
    if (docId == null) {
      finalDocId = "";
    } else {
      finalDocId = docId;
    }
  }

  @override
  void initState() {
    super.initState();
    getExistData(context);
    if(widget.outUri.isEmpty){
      setState(() {
        Provider.of<IncomeFriend>(context,listen: false).friendUserName="";
      });
    }else{
      setState(() {
        Provider.of<IncomeFriend>(context,listen: false).friendUserName=widget.outUri;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: Connectivity().onConnectivityChanged,
        builder:
            (BuildContext context, AsyncSnapshot<ConnectivityResult> snapshot) {
          if (snapshot.hasData && snapshot.data != ConnectivityResult.none) {
            getExistData(context).whenComplete(() async {
              Timer(const Duration(seconds: 2), () {
                if (finalDocId.isEmpty) {
                  setState(() {
                    bufferWidget = const LogOptionScreen();
                  });
                } else {
                  getExistData(context).whenComplete(() async {
                    await FirebaseFirestore.instance
                        .collection('User')
                        .where(FieldPath.documentId, isEqualTo: finalDocId)
                        .get()
                        .then((event) {
                      if (event.docs.isNotEmpty) {
                        Map<String, dynamic> doc = event.docs.single.data();
                        setDataToProvider(context, doc);
                        if (widget.outUri.isEmpty) {
                          setState(() {
                            bufferWidget = const HomeScreen(whichScreen: 0);
                          });
                        } else {
                          setState(() {
                            isHasIncomeLink=true;
                            DeepLinkName.deepLinkName=Provider.of<IncomeFriend>(context, listen: false).friendUserName as String;
                            // bufferWidget =
                            //     ProfileLinkScreen(name: widget.outUri);
                          });
                        }
                      }
                    }).catchError((e) => print("error fetching data: $e"));
                  });
                }
              });
            });
              return bufferWidget;
          } else {
            return const NoInternetWidget();
          }
        },
      ),
    );
  }

  void setDataToProvider(context, Map<String, dynamic> doc) {
    List<Link> links = [];
    setState(() {
      Provider.of<UserProvider>(context, listen: false).email = doc['email'];
      Provider.of<UserProvider>(context, listen: false).name = doc['name'];
      Provider.of<UserProvider>(context, listen: false).uid = doc['uid'];
      Provider.of<UserProvider>(context, listen: false).isVerify = true;
      Provider.of<UserProvider>(context, listen: false).imageUrl =
          doc['photoUrl'];
      Provider.of<UserProvider>(context, listen: false).loginType = "email";
      doc['links'].forEach((key, value) {
        links.add(Link(type: key, link: value));
      });
      Provider.of<UserProvider>(context, listen: false).links = links;
      Provider.of<UserProvider>(context, listen: false).friend = doc['friends'];
      Provider.of<UserProvider>(context, listen: false).bio = doc['bio'];
      Provider.of<UserProvider>(context, listen: false).isDirect =
          doc['isDirect'];
      Provider.of<UserProvider>(context, listen: false).directOn =
          doc['directOn'];
      Provider.of<UserProvider>(context, listen: false).status = doc['status'];
      Provider.of<UserProvider>(context, listen: false).userName =
          doc['userName'];
    });
  }
}

