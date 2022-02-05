import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tic/business_logic_layer/authentication/data/providers/user_provider.dart';
import 'package:tic/constant/my_colors.dart';
import 'package:tic/data_layer/web_services/email_sign_services.dart';
import 'package:tic/data_layer/web_services/facebook_sign_services.dart';
import 'package:tic/data_layer/web_services/google_services.dart';


class PopUp extends StatefulWidget {
  final String errorText;
  final String type;
  final String anotherArguments;
  const PopUp({Key? key, required this.errorText, required this.type, required this.anotherArguments}) : super(key: key);
  @override
  _PopUpState createState() => _PopUpState();
}

class _PopUpState extends State<PopUp> {

  bool isLoggingOut=false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(width, height, context, widget.errorText),
    );
  }

  Widget contentBox(double width, double height, context, String errorText) {
    return WillPopScope(
      onWillPop: ()async{
        return false;
      },
      child: SizedBox(
        height: height,
        width: width,
        child: Center(
          child: Container(
              width: width * 0.8,
              height: height * 0.2,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: MyColors.myWhite,
                borderRadius: BorderRadius.circular(20),
              ),
              child: isLoggingOut?Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: MyColors.myBlack,
                      strokeWidth: width * 0.009,
                    ),
                    SizedBox(
                      height: height * 0.025,
                    ),
                    Text(
                      "Logging out",
                      maxLines: 2,
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: height * 0.025,
                          color: MyColors.myBlack,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ):Column(
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
                    errorText,
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
                  Center(
                    child: ElevatedButton(
                      onPressed:widget.type=="error"? () {
                        Navigator.of(context).pop();
                      }:widget.type=="logout"?()async{
                        setState(() {
                          isLoggingOut=true;
                        });
                        await logOut();
                      }:(){
                        if (Platform.isAndroid) {
                          SystemNavigator.pop();
                        } else if (Platform.isIOS) {
                          exit(0);
                        }
                      },
                      child: Text(
                        "Ok",
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
                  )
                ],
              )),
        ),
      ),
    );
  }
logOut()async{
  Future.delayed(const Duration(seconds: 2), () async{
    await popUpLogout(widget.anotherArguments, context).then((value) => Navigator.of(context).pushNamed('/logOption'));
  });
}

Future<void> popUpLogout(String loginType,context)async{

    widget.anotherArguments == "Google"
        ? () async {

      await GoogleService()
          .signOutGoogle(context)
          .then((value) async {
        removeProviderData(context);
        final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
        await sharedPreferences.remove('docId');
      });
    }
        : widget.anotherArguments == "email"
        ? () async {
      await EmailSignServices()
          .userLogOut(context)
          .then((value) async {
        removeProviderData(context);
        final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
        await sharedPreferences.remove('docId');
      });
    }
        : () async {
      await FacebookSignServices()
          .signOutGoogle()
          .then((value) async {
        final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
        await sharedPreferences.remove('docId');
        Navigator.of(context).pushReplacementNamed("/");
      });
    };
  }

  removeProviderData(context) {
    Provider.of<UserProvider>(context, listen: false).email = "";
    Provider.of<UserProvider>(context, listen: false).imageUrl = "";
    Provider.of<UserProvider>(context, listen: false).isVerify = false;
    Provider.of<UserProvider>(context, listen: false).uid = "";
    Provider.of<UserProvider>(context, listen: false).name = "";

    Provider.of<UserProvider>(context, listen: false).userName = "";
    Provider.of<UserProvider>(context, listen: false).bio = "";
    Provider.of<UserProvider>(context, listen: false).links = [];
    Provider.of<UserProvider>(context, listen: false).directOn = {};
    Provider.of<UserProvider>(context, listen: false).friend = [];

    Provider.of<UserProvider>(context, listen: false).status = false;
    Provider.of<UserProvider>(context, listen: false).number = "";
    Provider.of<UserProvider>(context, listen: false).loginType = "";

    Provider.of<UserProvider>(context, listen: false).userNameLink = "";
  }
}


//
// class PopUp extends StatelessWidget {
//   final String errorText;
//   final String type;
//   final String anotherArguments;
//   const PopUp({Key? key, required this.errorText, required this.type, required this.anotherArguments}) : super(key: key);
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     return Dialog(
//       elevation: 0,
//       backgroundColor: Colors.transparent,
//       child: contentBox(width, height, context, errorText),
//     );
//   }
//
//   Widget contentBox(double width, double height, context, String errorText) {
//     return WillPopScope(
//       onWillPop: ()async{
//         return false;
//       },
//       child: SizedBox(
//         height: height,
//         width: width,
//         child: Center(
//           child: Container(
//               width: width * 0.8,
//               height: height * 0.2,
//               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//               decoration: BoxDecoration(
//                 color: MyColors.myWhite,
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   type=="logout"?const SizedBox():SizedBox(
//                     height: height * 0.05,
//                     width: width * 0.8,
//                     // color: Colors.red,
//                     child: Align(
//                       alignment: Alignment.topLeft,
//                       child: CircleAvatar(
//                           backgroundColor: MyColors.myBlack,
//                           child: IconButton(
//                             onPressed: () {
//                               Navigator.of(context).pop();
//                             },
//                             splashRadius: 10,
//                             icon: const Icon(
//                               Icons.exit_to_app_outlined,
//                               color: MyColors.myWhite,
//                             ),
//                           )),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Text(
//                     errorText,
//                     maxLines: 2,
//                     style: TextStyle(
//                         overflow: TextOverflow.ellipsis,
//                         fontSize: height * 0.025,
//                         color: MyColors.myBlack,
//                         fontWeight: FontWeight.normal),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Center(
//                     child: ElevatedButton(
//                       onPressed:type=="error"? () {
//                         Navigator.of(context).pop();
//                       }:(){
//                         if (Platform.isAndroid) {
//                           SystemNavigator.pop();
//                         } else if (Platform.isIOS) {
//                           exit(0);
//                         }
//                     },
//                       child: Text(
//                         "Ok",
//                         maxLines: 2,
//                         style: TextStyle(
//                             overflow: TextOverflow.ellipsis,
//                             fontSize: height * 0.025,
//                             fontWeight: FontWeight.normal),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         primary: MyColors.myBlack,
//                         onPrimary: MyColors.myWhite,
//                       ),
//                     ),
//                   )
//                 ],
//               )),
//         ),
//       ),
//     );
//   }
//   Future<void> popUpLogout(String loginType,context)async{
//
//     anotherArguments == "Google"
//         ? () async {
//
//       await GoogleService()
//           .signOutGoogle(context)
//           .then((value) async {
//         removeProviderData(context);
//         final SharedPreferences sharedPreferences =
//         await SharedPreferences.getInstance();
//         await sharedPreferences.remove('docId');
//       });
//     }
//         : anotherArguments == "email"
//         ? () async {
//       await EmailSignServices()
//           .userLogOut(context)
//           .then((value) async {
//         removeProviderData(context);
//         final SharedPreferences sharedPreferences =
//         await SharedPreferences.getInstance();
//         await sharedPreferences.remove('docId');
//       });
//     }
//         : () async {
//       await FacebookSignServices()
//           .signOutGoogle()
//           .then((value) async {
//         final SharedPreferences sharedPreferences =
//         await SharedPreferences.getInstance();
//         await sharedPreferences.remove('docId');
//         Navigator.of(context).pushReplacementNamed("/");
//       });
//     };
//   }
//
//   removeProviderData(context) {
//       Provider.of<UserProvider>(context, listen: false).email = "";
//       Provider.of<UserProvider>(context, listen: false).imageUrl = "";
//       Provider.of<UserProvider>(context, listen: false).isVerify = false;
//       Provider.of<UserProvider>(context, listen: false).uid = "";
//       Provider.of<UserProvider>(context, listen: false).name = "";
//
//       Provider.of<UserProvider>(context, listen: false).userName = "";
//       Provider.of<UserProvider>(context, listen: false).bio = "";
//       Provider.of<UserProvider>(context, listen: false).links = [];
//       Provider.of<UserProvider>(context, listen: false).directOn = {};
//       Provider.of<UserProvider>(context, listen: false).friend = [];
//
//       Provider.of<UserProvider>(context, listen: false).status = false;
//       Provider.of<UserProvider>(context, listen: false).number = "";
//       Provider.of<UserProvider>(context, listen: false).loginType = "";
//
//       Provider.of<UserProvider>(context, listen: false).userNameLink = "";
//   }
// }
