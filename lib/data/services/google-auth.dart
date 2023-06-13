import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:note_taker/views/HomePage.dart';



class GoogleAuthService {
  GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth  = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');


  Future<UserCredential?> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
      await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);
      final UserCredential userCredential =
      await _firebaseAuth.signInWithCredential(credential);
      final User? user = userCredential.user;

      var userData = {
        'name': googleSignInAccount.displayName,
        'provider': 'google',
        'photoUrl': googleSignInAccount.photoUrl,
        'email': googleSignInAccount.email,
      };

      users.doc(user?.email).get().then((doc) {
        if (doc.exists) {
          // old user
          doc.reference.update(userData);
        Get.to(HomePage());
        } else {
          /// new user
          users.doc(user?.email).set(userData);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );        }
      });
      return userCredential;
    } catch (e,s ) {
      print(e);
      print(s);
      print("Sign in not successful !");
    return null;
      // better show an alert here
    }
  }
  Future<void> signOut() async {
    await googleSignIn.signOut();
  }
}