import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic/business_logic_layer/authentication/data/providers/user_provider.dart';
import 'package:tic/constant/my_colors.dart';
import 'package:tic/data_layer/models/freind_data.dart';
import 'package:tic/presentation_layer/screens/friend_screen/friend_detail_screen1.dart';
import 'package:tic/presentation_layer/widgets/friend_widgets/content_box.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({Key? key}) : super(key: key);

  @override
  _FriendsScreenState createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  CollectionReference users = FirebaseFirestore.instance.collection('User');
  List<FriendData> friendData = [];
  List<Widget> friendList = [];

  @override
  void dispose() {
    friendData.clear();
    friendList.clear();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: MyColors.myWhite,
        body: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('User')
              .doc("${Provider.of<UserProvider>(context, listen: false).uid}")
              .get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(MyColors.myOrange)),
              );
            } else {
              Map<String, dynamic> data =
                  snapshot.data?.data() as Map<String, dynamic>;
              if (data['friends'].length > 0) {
                friendIds.clear();
                return ListView.builder(
                  itemCount: data['friends'].length,
                  itemBuilder: (context, index) {
                    return FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance
                          .collection('User')
                          .doc("${data['friends'][index]}")
                          .get(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    MyColors.myOrange)),
                          );
                        } else {
                          Map<String, dynamic> data2 =
                              snapshot.data?.data() as Map<String, dynamic>;
                          return _friendSection(width, height * 0.1, data2,
                              context, height, data);
                        }
                      },
                    );
                  },
                );
              } else {
                return const Center(child: Text("There is no friend to show"));
              }
            }
          },
        ));
  }

  List<String> friendIds = [];
  Widget _friendSection(
      double width, double height, data, context, double fullHeight,Map<String,dynamic> mainData) {
    FriendData newFriend = FriendData(
        name: data['name'],
        photoUrl: data['photoUrl'],
        links: data['links'],
        status: data['status'],
        index: 0,
        bio: data['bio'],
        uid: data['uid'],
        directOn: data['directOn'],
        isDirect: data['isDirect'],
        email: data['email']);
    friendIds.add(data['uid']);
    return FittedBox(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        width: width,
        height: height,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: MyColors.myWhite,
            shadowColor: MyColors.myBlack,
            elevation: 4,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FriendDetailScreen1(
                          friendData: newFriend,
                          type: 0,
                          isFriend: true,
                          data: mainData,
                        )));
          },
          child: FittedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: CircleAvatar(
                    radius: height * 0.35,
                    backgroundImage: NetworkImage(newFriend.photoUrl as String),
                  ),
                ),
                Container(
                  width: width * 0.5,
                  margin: const EdgeInsets.only(right: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        newFriend.name as String,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: height * 0.19,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold,
                            color: MyColors.myBlack),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        newFriend.name as String,
                        style: TextStyle(
                            fontSize: height * 0.18,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w400,
                            color: MyColors.myGray),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return showRemoveDialog(width, fullHeight, context,
                                newFriend, mainData);
                          });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: MyColors.myBlack,
                    ),
                    child: const Text("Remove"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  showRemoveDialog(
      double width, double height, context, FriendData newFriend, data) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: ContentBox(data: data,newFriend: newFriend,),
    );
  }
}

// Widget _searchBox(double width,double height){
//   return Container(
//     margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
//     width: width,
//     height: height*0.068,
//     child: Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(5)
//       ),
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 5),
//         child: TextFormField(
//           cursorColor: MyColors.myOrange,
//           style: TextStyle(
//             fontSize: height*0.028,
//           ),
//           maxLines: 1,
//           decoration: InputDecoration(
//               border: InputBorder.none,
//               prefixIcon:const Icon(Icons.search,color: MyColors.myBlack,),
//               hintText: "Search",
//               hintStyle: TextStyle(
//                   fontSize: height*0.028
//               )
//           ),
//         ),
//       ),
//     ),
//   );
// }
