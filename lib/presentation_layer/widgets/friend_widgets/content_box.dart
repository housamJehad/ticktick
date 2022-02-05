import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic/business_logic_layer/authentication/data/providers/user_provider.dart';
import 'package:tic/constant/my_colors.dart';
import 'package:tic/data_layer/models/freind_data.dart';
import 'package:tic/presentation_layer/screens/home_screen/home_screen.dart';


class ContentBox extends StatefulWidget {
  final FriendData newFriend;
  final Map<String,dynamic>data;

  const ContentBox({Key? key,required this.newFriend,required this.data}) : super(key: key);
  @override
  _ContentBoxState createState() => _ContentBoxState();
}

class _ContentBoxState extends State<ContentBox> {
  CollectionReference users = FirebaseFirestore.instance.collection('User');
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: height,
      color: Colors.transparent,
      child: Center(
        child: Container(
          width: width * 0.8,
          height: height * 0.2,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: MyColors.myWhite,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: height * 0.05,
                width: width * 0.8,
                // color: Colors.red,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: CircleAvatar(
                      backgroundColor: MyColors.myBlack,
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        splashRadius: 10,
                        icon: const Icon(
                          Icons.exit_to_app_outlined,
                          color: MyColors.myWhite,
                        ),
                      )),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Are you sure to remove friend",
                maxLines: 2,
                style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: height * 0.025,
                    color: MyColors.myBlack,
                    fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      List<String> newFriendsIds = [];
                      for (int i = 0; i < widget.data['friends'].length; i++) {
                        if (widget.data['friends'][i] == widget.newFriend.uid) {
                          continue;
                        } else {
                          newFriendsIds.add(widget.data['friends'][i]);
                        }
                      }
                      users
                          .doc(
                          "${Provider.of<UserProvider>(context, listen: false).uid}")
                          .update({'friends': newFriendsIds}).then((value) {
                       Navigator.of(context).pushNamed('/home');
                      });
                      setState(() {
                        Provider.of<UserProvider>(context, listen: false).friend =newFriendsIds;
                      });
                    },
                    child: Text(
                      "Yes",
                      maxLines: 2,
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: height * 0.025,
                          fontWeight: FontWeight.normal),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: MyColors.myBlack,
                      onPrimary: MyColors.myWhite,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Cancel",
                      maxLines: 2,
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: height * 0.025,
                          fontWeight: FontWeight.normal),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: MyColors.myBlack,
                      onPrimary: MyColors.myWhite,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
