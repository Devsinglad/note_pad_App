import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:note_taker/data/services/auth_services.dart';
import 'package:note_taker/data/services/google-auth.dart';
import 'package:note_taker/models/notes_model.dart';


class NoteController extends GetxController {
  final FirebaseService firebaseService = FirebaseService();
  final GoogleAuthService _googleAuthService = GoogleAuthService();

  RxList<Note> notes = <Note>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotes();
  }

  Future<void> fetchNotes() async {
    try {
      final List<Note> fetchedNotes = await firebaseService.getNotes();
      notes.value = fetchedNotes;
    } catch (e) {
      print('Error fetching notes: $e');
    }
  }

  Future<void> addNote(Note note) async {
    try {
      await firebaseService.addNote(note);
      await fetchNotes();
    } catch (e) {
      print('Error adding note: $e');
    }
  }

  Future<void> updateNote(Note note) async {
    try {
      await firebaseService.updateNote(note);
      await fetchNotes();
    } catch (e) {
      print('Error updating note: $e');
    }
  }

  Future<void> deleteNote(String noteId) async {
    try {
      await firebaseService.deleteNote(noteId);
      await fetchNotes();
    } catch (e) {
      print('Error deleting note: $e');
    }
  }

  Future<void> signIn(String email, String password,BuildContext context) async {
    try {
      await firebaseService.signInWithEmailAndPassword(email, password,context);
    } catch (e) {
      print('Error signing in: $e');
    }
  }

  Future<void> signUp(String email, String password,name,phone,BuildContext context) async {
    try {
      await firebaseService.signUpWithEmailAndPassword(email: email, password: password,firstname: name,phoneNumber: phone,context: context);
      log(email);
      log(password);
      log(name);
    } catch (e) {
      print('Error signing up: $e');
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await firebaseService.signOut(context);

    } catch (e) {
      print('Error signing out: $e');
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final UserCredential? userCredential =
      await _googleAuthService.signInWithGoogle(context);
      // You can handle the signed-in user here
    } catch (e) {
      print('Google sign-in failed: $e');
    }
  }

  Future<void> googleSignOut() async {
    try {
      await _googleAuthService.signOut();

      // You can handle the sign-out process here
    } catch (e) {
      print('Google sign-out failed: $e');
    }
  }

}