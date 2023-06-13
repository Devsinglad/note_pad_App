import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note_taker/views/HomePage.dart';
import 'package:note_taker/views/Login/Login.dart';
import 'package:note_taker/widget/Mytext.dart';
import '../../models/notes_model.dart';
import 'package:get/get.dart';
class FirebaseService {
  final CollectionReference notesCollection =
  FirebaseFirestore.instance.collection('users').firestore.collection('notes');
  final CollectionReference _collection =
  FirebaseFirestore.instance.collection('users');

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Future<void> signInWithEmailAndPassword(
      String email, String password,BuildContext context) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.to(HomePage());
    } catch (e) {
      if(e is FirebaseAuthException){
        if (e.code == 'user-not-found' || e.code == 'wrong-password') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: MyText(title: 'Incorrect email or password',color: Colors.red)));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: MyText(title: e.message,color: Colors.red)));

        }

      }
      throw Exception('Failed to sign in: $e');
    }
  }

  Future<void> signUpWithEmailAndPassword({
      required String email, required String password, String? firstname,phoneNumber,required BuildContext context}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ).then((value) {
        _collection.doc(email).set({
          'email':email,
          "Name":firstname,
          "phone Number":phoneNumber,
        });
      });
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => const Login()));
    } catch  (e) {
      if(e is FirebaseAuthException){
        if (e.code == 'email-already-in-use') {
          /// Email is already registered, handle the error here
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: MyText(title: 'Email is already registered',color: Colors.red)));
          print('Email is already in use');

        }else{
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: MyText(title: 'Failed to sign up',color: Colors.red,)));

        }
      }
      throw Exception('Failed to sign up: $e');
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await _firebaseAuth.signOut();
      Get.to(const Login());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: MyText(title: 'Sign Out Successful',color: Colors.green,)));

    } catch (e) {
      throw Exception('Failed to sign out: $e');
    }
  }

  Future<List<Note>> getNotes() async {
    final snapshot = await notesCollection
        .where('userId', isEqualTo: currentUser!.email)
        .get();
    return snapshot.docs
        .map((doc) => Note(
      id: doc.id,
      title: doc['title'],
      content: doc['content'],
    ))
        .toList();
  }

  Future<void> addNote(Note note) {
    return notesCollection.add({
      'userId': currentUser!.email,
      'title': note.title,
      'content': note.content,
    });
  }

  Future<void> updateNote(Note note) {
    return notesCollection.doc(note.id).update({
      'title': note.title,
      'content': note.content,
    });
  }

  Future<void> deleteNote(String noteId) {
    return notesCollection.doc(noteId).delete();
  }
}