import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/dynamic_extensions.dart';
import 'package:intl/intl.dart';
import 'package:note_app/db/sqldb.dart';
import 'package:note_app/model/note.dart';

import 'package:share/share.dart';
import 'package:string_stats/string_stats.dart';

class NoteController extends GetxController {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
   SqlDb sqlDb = SqlDb(); 
  var notes = <Note>[];
  int contentWordCount = 0;
  int contentCharCount = 0;

  @override
  void onInit() {
    getAllNotes();
    super.onInit();
  }

  bool isEmpty() {
    if (notes.length == 0)
      return true;
    else
      return false;
  }

  void addNoteToDatabase() async {
    String title = titleController.text;
    String content = contentController.text;
    if (title.isBlank!) {
      title = "بدون عنوان";
    }
 Note note = Note(
  title: title,
      content: content,
      dateTimeEdited:
      DateFormat("MMM dd, yyyy  HH:mm:ss").format(DateTime.now()),
      dateTimeCreated:
      DateFormat("MMM dd, yyyy HH:mm:ss").format(DateTime.now())as DateTime,
    );


    await sqlDb.insertData(note);
    contentWordCount = wordCount(content);
    contentCharCount = charCount(content);
    titleController.text = "";
    contentController.text = "";
    getAllNotes();
    Get.back();
  }

  void deleteNote(int id) async {
    Note note = Note(
      id: id,
    );
    await sqlDb.deleteData(id);
    getAllNotes();
  }

  void deleteAllNotes() async {
    await sqlDb.mydeleteDatebase();
    getAllNotes();
  }

  void updateNote(int id, String dTCreated) async {
    final title = titleController.text;
    final content = contentController.text;
    Note note = Note(
      id: id,
      title: title,
      content: content,
      dateTimeEdited:
      DateFormat("MMM dd, yyyy HH:mm:ss").format(DateTime.now()),
      dateTimeCreated: dTCreated as DateTime,
    );
    await sqlDb.updateData(note);
    contentWordCount = wordCount(content);
    contentCharCount = charCount(content);
    titleController.text = "";
    contentController.text = "";
    getAllNotes();
    Get.back();
  }

  void getAllNotes() async {
    notes = await sqlDb.readAllNotes();
    // notes = await sqlDb.getNoteList();
    update();
  }

  void shareNote(String title, String content) {
    Share.share("$title \n$content");
  }

  // Future refreshNote() async {
  //   setState(() => isLoading = true);

  //   note = await sqlDb.readData(widget.noteId);

  //   setState(() => isLoading = false);
  // }
}
