import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:note_app/SideMenuBar.dart';
import 'package:note_app/colors.dart';
import 'package:note_app/create_note.dart';
import 'package:note_app/noteView.dart';
import 'package:note_app/searchpage.dart';
import 'package:note_app/services/db.dart';

import 'model/my_note_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  String note =
      "this is note description this is note description this is note description this is note description this is note description this is note description this is note description";
  String note1 =
      "this is note description this is note description this is note description";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future createEntry(Note note) async {
    await NotesDatabase.instance.insertEntry(note);
  }

  Future<String?> getAllNotes() async {
    await NotesDatabase.instance.readAllNotes();
  }

  Future getOneNotes(int id) async {
    await NotesDatabase.instance.readOneNote(id);
  }

  Future updateOneNote(Note note) async {
    await NotesDatabase.instance.updateNote(note);
  }

  Future deleteOneNote(Note note) async {
    await NotesDatabase.instance.deleteNote(note);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreateNote()));
        },
        backgroundColor: cardColor,
        child: Icon(
          Icons.add,
          size: 40,
        ),
      ),
      backgroundColor: bgColor,
      key: _drawerKey,
      endDrawerEnableOpenDragGesture: true,
      drawer: SideMenu(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  width: MediaQuery.of(context).size.width,
                  height: 55,
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: black.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 3,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              // open drawer menu
                              _drawerKey.currentState!.openDrawer();
                            },
                            icon: Icon(
                              Icons.menu,
                              color: white,
                            ),
                          ),
                          SizedBox(width: 16),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SearchView()));
                            },
                            child: Container(
                              height: 55,
                              width: 200,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Search your notes",
                                    style: TextStyle(
                                      color: white.withOpacity(0.5),
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            TextButton(
                              style: ButtonStyle(
                                overlayColor: MaterialStateColor.resolveWith(
                                  (states) => white.withOpacity(0.1),
                                ),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                              ),
                              onPressed: () {},
                              child: Icon(
                                Icons.grid_view,
                                color: white,
                              ),
                            ),
                            SizedBox(width: 9),
                            CircleAvatar(
                              radius: 16,
                              backgroundColor: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                noteScetionAll(),
                noteListSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget noteScetionAll() {
    return Container(
      margin: EdgeInsets.all(15),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "All",
                  style: TextStyle(
                    color: white.withOpacity(0.5),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            // height: MediaQuery.of(context).size.height,
            child: StaggeredGridView.countBuilder(
              physics: NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              shrinkWrap: true,
              itemCount: 10,
              crossAxisCount: 4,
              staggeredTileBuilder: (index) => StaggeredTile.fit(2),
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => NoteView()));
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: white.withOpacity(0.4),
                    ),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "heading",
                        style: TextStyle(
                          color: white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        index.isEven
                            ? note.length > 250
                                ? "${note.substring(0, 250)}..."
                                : note
                            : note1,
                        style: TextStyle(color: white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          //   Container(
          //     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          //     height: MediaQuery.of(context).size.height,
          //     child: StaggeredGridView.countBuilder(
          //       physics: NeverScrollableScrollPhysics(),
          //       mainAxisSpacing: 12,
          //       crossAxisSpacing: 12,
          //       shrinkWrap: true,
          //       itemCount: 10,
          //       crossAxisCount: 4,
          //       staggeredTileBuilder: (index) => StaggeredTile.fit(2),
          //       itemBuilder: (context, index) => Container(
          //         padding: EdgeInsets.all(10),
          //         decoration: BoxDecoration(
          //           color:
          //               index.isEven ? Colors.green[900] : Colors.blue[900],
          //           border: Border.all(
          //             color: index.isEven
          //                 ? Colors.green.withOpacity(0.4)
          //                 : Colors.blue.withOpacity(0.4),
          //           ),
          //           borderRadius: BorderRadius.circular(7),
          //         ),
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Text(
          //               "heading",
          //               style: TextStyle(
          //                 color: white,
          //                 fontSize: 20,
          //                 fontWeight: FontWeight.bold,
          //               ),
          //             ),
          //             SizedBox(
          //               height: 10,
          //             ),
          //             Text(
          //               index.isEven
          //                   ? note.length > 250
          //                       ? "${note.substring(0, 250)}..."
          //                       : note
          //                   : note1,
          //               style: TextStyle(color: white),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
        ],
      ),
    );
  }

  Widget noteListSection() {
    return Container(
      margin: EdgeInsets.all(15),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "List View",
                  style: TextStyle(
                    color: white.withOpacity(0.5),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            // height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) => Container(
                margin: EdgeInsets.only(bottom: 10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: white.withOpacity(0.4),
                  ),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "heading",
                      style: TextStyle(
                        color: white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      index.isEven
                          ? note.length > 250
                              ? "${note.substring(0, 250)}..."
                              : note
                          : note1,
                      style: TextStyle(color: white),
                    ),
                    // SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
