import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookSignServices {
  CollectionReference addUser = FirebaseFirestore.instance.collection("User");
  Map? user;
  Future<User?> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance
        .login(permissions: ['public_profile',"email"]);

    if(loginResult.status==LoginStatus.success){
      final requestData=await FacebookAuth.instance.getUserData(
        fields: "email,name,picture"
      );
      user=requestData;

      int i = 0;
      await FirebaseFirestore.instance
          .collection('User')
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          if (doc['email'] == user?['email']) {
            i++;
          }
        }
      });
      if (i == 0) {
        addUser.add({
          'email': user?['email'],
          'name': user?["name"],
          'photoUrl': user?['picture']
        });
      }


    }
    //
    // final OAuthCredential facebookAuthCredential =
    //     FacebookAuthProvider.credential(loginResult.accessToken!.token);
    //
    // final authResult = await FirebaseAuth.instance
    //     .signInWithCredential(facebookAuthCredential);
    //
    // final User? user = authResult.user;
    // if (user != null) {
    //   // Checking if email and name is null
    //   assert(user.email != null);
    //   assert(user.displayName != null);
    //   assert(user.photoURL != null);
    //   // Only taking the first part of the name, i.e., First Name
    //
    //   assert(!user.isAnonymous);
    //   assert(await user.getIdToken() != null);
    //
    //   final User? currentUser = _auth.currentUser;
    //   assert(user.uid == currentUser?.uid);
    //
    //   print('signInWithGoogle succeeded: $user');

      // Once signed in, return the UserCredential
  }

  Future<void> signOutGoogle() async {
    await FacebookAuth.instance.logOut();
  }
}
