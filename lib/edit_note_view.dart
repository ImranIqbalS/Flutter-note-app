import 'package:flutter/material.dart';
import 'package:note_app/colors.dart';
import 'package:note_app/noteView.dart';
import 'package:note_app/services/db.dart';

import 'model/my_note_model.dart';

class EditNoteView extends StatefulWidget {
  Note note;
  EditNoteView({required this.note});
  @override
  _EditNoteViewState createState() => _EditNoteViewState();
}

class _EditNoteViewState extends State<EditNoteView> {
  String newTitle = "";
  String newNoteDet = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.newTitle = widget.note.title.toString();
    this.newNoteDet = widget.note.content.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: () async {
              Note newNote = Note(
                  content: newNoteDet,
                  title: newTitle,
                  createdTime: widget.note.createdTime,
                  // createdTime: DateTime.now(),

                  pin: widget.note.pin,
                  isArchieve: widget.note.isArchieve,
                  id: widget.note.id);
              await NotesDatabase.instance.updateNote(newNote);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NoteView(note: newNote)));
            },
            splashRadius: 17,
            icon: Icon(
              Icons.save_outlined,
            ),
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            Form(
              child: TextFormField(
                initialValue: newTitle,
                onChanged: (value) {
                  newTitle = value;
                },
                cursorColor: white,
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: "Title",
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.withOpacity(0.8),
                  ),
                ),
              ),
            ),
            Container(
              height: 300,
              child: Form(
                child: TextFormField(
                  initialValue: newNoteDet,
                  onChanged: (value) {
                    newNoteDet = value;
                  },
                  keyboardType: TextInputType.multiline,
                  minLines: 50,
                  maxLines: null,
                  cursorColor: white,
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: "Note",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.withOpacity(0.8),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
