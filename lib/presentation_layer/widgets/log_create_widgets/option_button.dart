import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic/business_logic_layer/authentication/data/providers/user_provider.dart';
import 'package:tic/constant/my_colors.dart';
import 'package:tic/data_layer/web_services/facebook_sign_services.dart';
import 'package:tic/data_layer/web_services/google_services.dart';
import 'package:tic/presentation_layer/screens/home_screen/home_screen.dart';
import 'package:tic/presentation_layer/screens/login_creat_screens/create_account_side/user_name_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OptionButton extends StatefulWidget {
  final String optionText;
  final IconData optionIcon;
  final int optionType;
  const OptionButton(
      {Key? key,
      required this.optionText,
      required this.optionIcon,
      required this.optionType})
      : super(key: key);

  @override
  _OptionButtonState createState() => _OptionButtonState();
}

class _OptionButtonState extends State<OptionButton> {
  bool isLoading = false;

  @override
  void dispose() {
    setState(() {
      isLoading = false;
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height * 0.07,
      width: width * 0.7,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: MyColors.myBlack,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 10),
        onPressed: widget.optionType == 0
            ? isLoading
                ? () {}
                : () {
                    FacebookSignServices().signInWithFacebook();
                  }
            : isLoading
                ? () {}
                : () async {
                    setState(() {
                      isLoading = true;
                    });
                    bool haveUserName = false;
                    var user = await GoogleService().signInWithGoogle(context);
                    setState(() {
                      Provider.of<UserProvider>(context, listen: false).email =
                          user?.email;
                      Provider.of<UserProvider>(context, listen: false).name =
                          user?.name;
                      Provider.of<UserProvider>(context, listen: false).uid =
                          user?.uid;
                      Provider.of<UserProvider>(context, listen: false)
                          .isVerify = user?.isVerify;
                      Provider.of<UserProvider>(context, listen: false)
                          .imageUrl = user?.photoUrl;
                      Provider.of<UserProvider>(context, listen: false)
                          .loginType = "Google";
                      Provider.of<UserProvider>(context, listen: false).links =
                          user?.links;
                      Provider.of<UserProvider>(context, listen: false).friend =
                          user?.friends;
                      Provider.of<UserProvider>(context, listen: false).bio =
                          user?.bio;
                      Provider.of<UserProvider>(context, listen: false)
                          .directOn = user?.directOn;
                      Provider.of<UserProvider>(context, listen: false)
                          .isDirect = user?.isDirect;
                      Provider.of<UserProvider>(context, listen: false).status =
                          user?.status;
                    });
                    late QueryDocumentSnapshot userDoc;
                    await FirebaseFirestore.instance
                        .collection('User')
                        .get()
                        .then((QuerySnapshot querySnapshot) {
                      for (var doc in querySnapshot.docs) {
                        if (doc['email'] ==
                            Provider.of<UserProvider>(context, listen: false)
                                .email) {
                          setState(() {
                            userDoc = doc;
                          });
                        }
                      }
                    });
                    if (userDoc['userName'].isEmpty) {
                      setState(() {
                        haveUserName = false;
                        Provider.of<UserProvider>(context, listen: false).uid =
                            userDoc['uid'];
                      });
                    } else {
                      setState(() {
                        Provider.of<UserProvider>(context, listen: false)
                            .userName = userDoc['userName'];
                        haveUserName = true;
                        Provider.of<UserProvider>(context, listen: false).uid =
                            userDoc['uid'];
                      });
                    }

                    if (user?.email != null) {
                      if (haveUserName) {
                        final SharedPreferences sharedPreferences =
                            await SharedPreferences.getInstance();
                        sharedPreferences.setString(
                            "docId",
                            Provider.of<UserProvider>(context, listen: false)
                                .uid as String);

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => const HomeScreen(
                                  whichScreen: 0,
                                )));
                      } else {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const UserNameScreen()));
                      }
                    }
                    setState(() {
                      isLoading = false;
                    });
                  },
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: MyColors.myWhite,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(widget.optionIcon),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.optionText,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: height * 0.025),
                  ),
                ],
              ),
      ),
    );
  }
}

//
// class OptionButton extends StatelessWidget {
//   final String optionText;
//   final IconData optionIcon;
//   final int optionType;
//   const OptionButton(
//       {Key? key,
//         required this.optionText,
//         required this.optionIcon,
//         required this.optionType})
//       : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     return SizedBox(
//       height: height * 0.07,
//       width: width * 0.7,
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//             primary: Colors.black,
//             shape:
//             RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//             elevation: 10),
//         onPressed: optionType==0?(){Navigator.pushNamed(context, '/login2');}:()async{
//           var user = await GoogleService().signInWithGoogle(context);
//           setState(() {
//             Provider.of<UserProvider>(context, listen: false).email =
//                 user?.email;
//             Provider.of<UserProvider>(context, listen: false).name =
//                 user?.name;
//             Provider.of<UserProvider>(context, listen: false).uid =
//                 user?.uid;
//             Provider.of<UserProvider>(context, listen: false).isVerify =
//                 user?.isVerify;
//             Provider.of<UserProvider>(context, listen: false).imageUrl =
//                 user?.photoUrl;
//             Provider.of<UserProvider>(context, listen: false).loginType =
//             "Google";
//             Provider.of<UserProvider>(context, listen: false).links =
//                 user?.links;
//             Provider.of<UserProvider>(context, listen: false).friend =
//                 user?.friends;
//             Provider.of<UserProvider>(context, listen: false).bio =
//                 user?.bio;
//           });
//           },
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(optionIcon),
//             const SizedBox(
//               width: 10,
//             ),
//             Text(
//               optionText,
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//               style: TextStyle(fontSize: height * 0.025),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
