import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tic/business_logic_layer/authentication/data/providers/user_provider.dart';
import 'package:tic/data_layer/models/link.dart';
import 'package:tic/data_layer/models/user_details.dart';
import 'package:tic/presentation_layer/widgets/popup/popup.dart';

class GoogleService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  CollectionReference addUser = FirebaseFirestore.instance.collection("User");

  Future<UserDetails?> signInWithGoogle(context) async {
    int isUserExist = 0;
    bool status =false;
    String bio = "";
    String uid = "";
    String photoUrl = "";
    String name = "";
    List<dynamic> friends = [];
    Map<String, dynamic> linksBuffer = {};
    List<Link> links = [];
    bool isDirect = false;
    Map<String, dynamic> directOn = {};

      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult =
          await _auth.signInWithCredential(credential);

      final User? user = authResult.user;
      if (user != null) {
        assert(user.email != null);
        assert(user.displayName != null);
        assert(user.photoURL != null);
        assert(!user.isAnonymous);
        assert(await user.getIdToken() != null);


        String? phone = user.phoneNumber ?? "00";
        final User? currentUser = _auth.currentUser;
        assert(user.uid == currentUser?.uid);
        await FirebaseFirestore.instance
            .collection('User')
            .get()
            .then((QuerySnapshot querySnapshot) {
          for (var doc in querySnapshot.docs) {
            if (doc['email'] == user.email) {
              friends = doc['friends'];
              linksBuffer = doc['links'];
              status = doc['status'];
              bio = doc['bio'];
              uid = doc['uid'];
              name = doc['name'];
              photoUrl = doc['photoUrl'];
              isUserExist++;
            }
          }
        });
        if (isUserExist == 0) {
          await addUser.add({
            'email': user.email,
            'name': user.displayName,
            'photoUrl': user.photoURL,
            'phoneNumber': phone,
            'friends': [],
            'links': {"add_@123": "add", 'E-mail': '${user.email}'},
            'status': false,
            'uid': "",
            'bio': "",
            'isDirect': false,
            'directOn': {},
            'userName':"",
            "birthDay":"",
            "gender":"",
          }).then(
              (value) => value.get().then((DocumentSnapshot documentSnapshot) {
                    if (documentSnapshot.exists) {
                      addUser
                          .doc(documentSnapshot.id)
                          .update({'uid': documentSnapshot.id});
                      Provider.of<UserProvider>(context, listen: false).uid =
                          documentSnapshot.id;
                    }
                  }));
          Future.delayed(const Duration(milliseconds: 20));
        }
        linksBuffer.forEach((key, value) {
          links.add(Link(type: key, link: value));
        });

        UserDetails newUser = UserDetails(
          name: name,
          email: user.email as String,
          photoUrl: photoUrl,
          phoneNumber: phone,
          uid: uid,
          isVerify: true,
          links: links,
          friends: friends,
          status: status,
          bio: bio,
          directOn: directOn,
          isDirect: isDirect
        );
        return newUser;
      }
    return null;
  }


  Future<void> signOutGoogle(context) async {
    await googleSignIn.signOut();
    try{
      await _auth.signOut().then((value) async{
        final SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
        sharedPreferences.remove("docId");
      });
    }on FirebaseAuthException catch (error){
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const PopUp(errorText: "Log out fail");
          });
    }
  }
}
