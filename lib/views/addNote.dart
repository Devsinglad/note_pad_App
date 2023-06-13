import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_taker/data/services/noteController.dart';
import 'package:note_taker/models/notes_model.dart';
import 'package:note_taker/res/textEditingControllers/textEditingControllers.dart';

class AddNote extends StatefulWidget {
    final Note? note;

  const AddNote({super.key,this.note});
  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final NoteController noteController = Get.find();

  @override
  void initState() {
    final AuthenticationController authenticate =Get.put(AuthenticationController());

    if (widget.note != null) {
      authenticate.titleController.text = widget.note!.title;
      authenticate.contentController.text = widget.note!.content;
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final AuthenticationController authenticate =Get.put(AuthenticationController());

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(
              10.0,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_outlined,
                        size: 24.0,
                      ),
                    ),
                    ///
                    ElevatedButton(
                      onPressed: (){
                        addNoteEdit(authenticate.titleController.text, authenticate.contentController.text);
                        authenticate.titleController.clear();
                        authenticate.contentController.clear();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.grey[700],
                        ),
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                            horizontal: 25.0,
                            vertical: 8.0,
                          ),
                        ),
                      ),
                      child:  Text(
                        widget.note == null ? 'Add' : "Edit",
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontFamily: "lato",
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                //
                const SizedBox(
                  height: 12.0,
                ),
                //
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration.collapsed(
                          hintText: "Title",
                        ),
                        style: const TextStyle(
                          fontSize: 32.0,
                          fontFamily: "lato",
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                        controller: authenticate.titleController,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.75,
                        padding: const EdgeInsets.only(top: 12.0),
                        child: TextFormField(
                          controller: authenticate.contentController,
                          decoration: const InputDecoration.collapsed(
                            hintText: "Note Description",
                          ),
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontFamily: "lato",
                            color: Colors.grey,
                          ),
                          maxLines: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  void addNoteEdit(String title,String content){
    if (widget.note == null) {
      final newNote = Note(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        content: content,
      );
      noteController.addNote(newNote);
    } else {
      final updatedNote = Note(
        id: widget.note!.id,
        title: title,
        content: content,
      );
      noteController.updateNote(updatedNote);
    }
    Get.back();
  }
}