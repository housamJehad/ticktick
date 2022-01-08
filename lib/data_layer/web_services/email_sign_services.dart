import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tic/business_logic_layer/authentication/data/providers/income_friend_provider.dart';
import 'package:tic/business_logic_layer/authentication/data/providers/user_provider.dart';
import 'package:tic/data_layer/models/deep_link_name.dart';
import 'package:tic/data_layer/models/link.dart';
import 'package:tic/presentation_layer/screens/login_creat_screens/create_account_side/user_name_screen.dart';
import 'package:tic/presentation_layer/widgets/popup/popup.dart';

class EmailSignServices {
  User? user = FirebaseAuth.instance.currentUser;
  CollectionReference addUser = FirebaseFirestore.instance.collection("User");
  //
  // void sendOTP({String? email}) async {
  //   var emailAuth = EmailAuth(sessionName: 'Test Session');
  //   var res = emailAuth.sendOtp(recipientMail: email as String);
  //   if (res as bool) {
  //     print("otp sent");
  //   } else {
  //     print("Not Sent");
  //   }
  // }

  verifyEmail(
      {var context,
      String? email,
      String? password,
      String? name,
      String? phone}) async {
    if (!user!.emailVerified) {
      await user!.sendEmailVerification().then((value) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return const PopUp(errorText: "Verification email sent");
            });
      });
    }
    addUser.add({
      'email': email,
      'name': name,
      'phone': phone,
      'links': {"add_@123": "add", 'E-mail': email},
      'friends': [],
      'uid': "",
      'photoUrl':
          "https://firebasestorage.googleapis.com/v0/b/tick-1c025.appspot.com/o/folderName%2Fdata%2Fuser%2F0%2Fcom.example.tic%2Fcache%2Fimage_picker7669952405688223312.png?alt=media&token=03cec44c-91ae-4378-837f-164e56fcb249",
      'status': false,
      'bio': "",
      'isDirect': false,
      'directOn': {},
      'gender': "",
      "birthDay": "",
      "userName": "",
    }).then((value) => value.get().then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {
            addUser
                .doc(documentSnapshot.id)
                .update({'uid': documentSnapshot.id});
          }
        }));

    Navigator.pushNamedAndRemoveUntil(context, '/login2', (route) => false);
  }

  registration(
      {var context,
      String? password,
      String? phone,
      String? email,
      String? name}) async {
    if (password!.isNotEmpty) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email as String, password: password);
        verifyEmail(
          email: email,
          name: name,
          password: password,
          phone: phone,
          context: context,
        );
      } on FirebaseAuthException catch (error) {
        if (error.code == 'weak-password') {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return const PopUp(errorText: "Weak password");
              });
        } else if (error.code == 'email-already-in-use') {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return const PopUp(errorText: "Email already in use");
              });
        }
      }
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const PopUp(errorText: "Fill the require");
          });
    }
  }

  userLogOut(context) async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const PopUp(errorText: "Log out fail");
          });
    }
  }

  userLogin({var context, String? email, String? password}) async {
    bool isHasUserName = false;
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email as String, password: password as String);
      if (user!.emailVerified) {
        List<Link> links = [];
        await FirebaseFirestore.instance
            .collection('User')
            .get()
            .then((QuerySnapshot querySnapshot) {
          for (var doc in querySnapshot.docs) {
            if (doc['email'] == email) {
              Provider.of<UserProvider>(context, listen: false).email =
                  doc['email'];
              Provider.of<UserProvider>(context, listen: false).name =
                  doc['name'];
              Provider.of<UserProvider>(context, listen: false).uid =
                  doc['uid'];
              Provider.of<UserProvider>(context, listen: false).isVerify = true;
              Provider.of<UserProvider>(context, listen: false).imageUrl =
                  doc['photoUrl'];
              Provider.of<UserProvider>(context, listen: false).loginType =
                  "email";
              doc['links'].forEach((key, value) {
                links.add(Link(type: key, link: value));
              });
              Provider.of<UserProvider>(context, listen: false).links = links;
              Provider.of<UserProvider>(context, listen: false).friend =
                  doc['friends'];
              Provider.of<UserProvider>(context, listen: false).bio =
                  doc['bio'];
              Provider.of<UserProvider>(context, listen: false).isDirect =
                  doc['isDirect'];
              Provider.of<UserProvider>(context, listen: false).directOn =
                  doc['directOn'];
              Provider.of<UserProvider>(context, listen: false).status =
                  doc['status'];
              if (doc['userName'].isEmpty) {
                isHasUserName = false;
              } else {
                isHasUserName = true;
              }
              if (isHasUserName) {
                Provider.of<UserProvider>(context, listen: false).userName =
                    doc['userName'];
              }
              break;
            }
          }
        });

        if (isHasUserName) {
          final SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.setString("docId",
              Provider.of<UserProvider>(context, listen: false).uid as String);
          if (Provider.of<IncomeFriend>(context, listen: false).friendUserName!.isNotEmpty) {
            DeepLinkName.deepLinkName=Provider.of<IncomeFriend>(context, listen: false).friendUserName as String;
          }else{
            Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
          }
        } else {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => const UserNameScreen()));
        }
        return true;
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return const PopUp(errorText: "Verification email was sent");
            });
        return false;
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found') {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return const PopUp(errorText: "No user found for this email");
            });
      } else if (error.code == 'wrong-password') {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return const PopUp(errorText: "Wrong Password");
            });
      }
      return false;
    }
  }

  verifyEmailWhenSign({var context, String? email}) async {
    if (user != null && !user!.emailVerified) {
      await user!.sendEmailVerification();
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const PopUp(errorText: "Verification email sent");
          });
    }
  }
}
