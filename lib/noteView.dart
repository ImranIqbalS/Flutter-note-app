import 'package:flutter/material.dart';
import 'package:note_app/colors.dart';
import 'package:note_app/edit_note_view.dart';
import 'package:note_app/model/my_note_model.dart';

class NoteView extends StatefulWidget {
  Note note;
  NoteView({required this.note});

  @override
  _NoteViewState createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0.0,
        actions: [
          IconButton(
            splashRadius: 17,
            onPressed: () {},
            icon: Icon(
              Icons.push_pin_outlined,
            ),
          ),
          IconButton(
            splashRadius: 17,
            onPressed: () {},
            icon: Icon(
              Icons.archive_outlined,
            ),
          ),
          IconButton(
            splashRadius: 17,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EditNoteView()));
            },
            icon: Icon(
              Icons.edit_outlined,
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.note.title,
              style: TextStyle(
                color: white,
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              widget.note.content,
              style: TextStyle(color: white),
            ),
          ],
        ),
      ),
    );
  }
}
