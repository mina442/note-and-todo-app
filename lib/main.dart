import 'package:flutter/material.dart';
import 'package:note_app/addNote.dart';
// import 'package:note_app/Screens/TaskScreen.dart';
import 'package:note_app/home.dart';
import 'package:note_app/sqldb.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home:Home(),
      routes: {
        'addNotes':(context) => AddNotes()
      },
    );
  }
}