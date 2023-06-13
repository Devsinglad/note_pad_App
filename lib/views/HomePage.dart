import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_taker/data/services/noteController.dart';
import 'package:note_taker/models/notes_model.dart';
import 'package:note_taker/res/spacing/horizontal_spacing.dart';
import 'package:note_taker/views/addNote.dart';
import 'package:note_taker/widget/Mytext.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CollectionReference ref = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection('notes');

  List myColors = [
    Colors.yellow[200],
    Colors.red[200],
    Colors.grey[200],
    Colors.deepPurple[200],
    Colors.purple[200],
    Colors.pink[200],
  ];
@override
  void initState() {
  final NoteController noteController = Get.put(NoteController());
noteController.fetchNotes();
  // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final NoteController noteController = Get.put(NoteController());

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(const AddNote());
          },
          backgroundColor: Colors.grey[700],
          child: const Icon(
            Icons.add,
            color: Colors.white70,
          ),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            InkWell(
              onTap: () {
                /// user sign out
                noteController.signOut(context);
                noteController.googleSignOut();

                },
              child: Row(
                children: [
                  MyText(title: 'Sign Out',color: Colors.white70),
                   AppHorizontalSpacing.horizontalSpacingD,
                   const Icon(Icons.logout),
                ],
              ),
            ),
          ],
          title: const Text(
            "Notes",
            style: TextStyle(
              fontSize: 32.0,
              fontFamily: "lato",
              fontWeight: FontWeight.bold,
              color: Colors.white70,
            ),
          ),
          elevation: 0.0,
          backgroundColor: const Color(0xff070706),
        ),
        //
        body:Obx(() {
          if(noteController.notes.isEmpty){
            return  const Center(
              child: Text(
                "You have no saved Notes !",
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
            );
          }
          return ListView.builder(
            itemCount: noteController.notes.length,
            itemBuilder: (context, index) {
              final Note note = noteController.notes[index];
              Random random = Random();
              Color bg = myColors[random.nextInt(4)];
              return ListTile(
                tileColor: bg,
                title: MyText(title: note.title,color: Colors.black,fontSize: 20,weight: FontWeight.bold),
                subtitle: MyText(title:note.content,color: Colors.brown,fontSize: 17),
                trailing: IconButton(
                  icon: const Icon(Icons.delete,color: Colors.red),
                  onPressed: () => noteController.deleteNote(note.id.toString()),
                ),
                onTap: () => Get.to(AddNote(note: note,)),
              );
            },
          );
        })
      ),
    );
  }
}