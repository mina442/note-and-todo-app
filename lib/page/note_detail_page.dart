import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:note_app/controller/note_controller.dart';
import 'package:note_app/db/sqldb.dart';
import 'package:note_app/page/notes_page.dart';
import 'package:note_app/widget/alarm_dialog.dart';

// import '../db/notes_database.dart';
import '../model/note.dart';
import '../page/edit_note_page.dart';


//  SqlDb sqlDb = SqlDb(); 
//   late Note note;
//   bool isLoading = false;

  // @override
  // void initState() {
  //   super.initState();

  //   refreshNote();
  // }


       class NoteDetail extends StatelessWidget {
  final NoteController controller = Get.find();

        final int noteId;
         NoteDetail({super.key, required this.noteId});
           SqlDb sqlDb = SqlDb(); 
          late Note note;
          bool isLoading = false;
      
        @override
        Widget build(BuildContext context) {
          return Scaffold(
        appBar: AppBar(
              //  brightness: Brightness.light,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
          actions: [IconButton(
      icon: const Icon(Icons.edit_outlined),
      onPressed: () async {
        if (isLoading) return;

        Get.to(AddEditNotePage(note: note));
        

        // refreshNote();
      }),
       IconButton(
            icon: Icon(
              Icons.more_vert,
            ),
            onPressed: () {
              Get.bottomSheet(
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: TextButton(

                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialogWidget(
                                  contentText:
                                      "Are you sure you want to delete the note?",
                                  confirmFunction: () {
                                    // IconButton(
      //   icon: const Icon(Icons.delete),
      //   onPressed: () async {
      //     await sqlDb.deleteData(widget.noteId);

      //     Navigator.of(context).pop();
      //   },)
                                    controller.deleteNote(noteId);
                                    Get.offAll(NotesPage());
                                  },
                                  declineFunction: () {
                                    Get.back();
                                  },
                                );
                              },
                            );
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Icon(
                                Icons.delete,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "Delete",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(vertical: 20),
                      //   child: TextButton(

                      //     // onPressed: () {
                      //     //   controller.shareNote(
                      //     //     controller.notes[i].title,
                      //     //     controller.notes[i].content,
                      //     //   );
                      //     // },
                      //     child: Row(
                      //       children: [
                      //         SizedBox(
                      //           width: 20,
                      //         ),
                      //         Icon(
                      //           Icons.share,
                      //         ),
                      //         SizedBox(
                      //           width: 20,
                      //         ),
                      //         Text(
                      //           "Share",
                      //           style: TextStyle(
                      //             fontSize: 20,
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          top: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Created :  " +
                                   DateFormat.yMMMd().format(note.dateTimeCreated!),
                      style: const TextStyle(color: Colors.white38),
                              // style: TextStyle(
                              //   fontSize: 20,
                              //   fontWeight: FontWeight.bold,
                              // ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Content Word Count :  " +
                                  controller.contentWordCount.toString(),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Content Character Count :  " +
                                  controller.contentCharCount.toString(),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 150,
                            ),
                            Text(
                              "Created by AHMED SHERIF",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                backgroundColor: Colors.white,
              );
            },
          ),
      
        
        ],
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(12),
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  children: [
                    Text(
                      controller.notes.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      DateFormat.yMMMd().format(note.createdTime),
                      style: const TextStyle(color: Colors.white38),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      note.description,
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 18),
                    )
                  ],
                ),
              ),
      );}
  
 
       } 

