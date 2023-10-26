
import 'package:flutter/material.dart';
import 'package:note_app/home.dart';
import 'package:note_app/sqldb.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
   SqlDb sqlDb = SqlDb();
  GlobalKey<FormState> formState =GlobalKey();
  TextEditingController note= TextEditingController (); 
  TextEditingController title = TextEditingController ();  
  TextEditingController color = TextEditingController ();   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('add note'),
      ),
      body: Container(
        child: ListView(
          children: [
            Form(
              key: formState,
              child: 
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SizedBox(height: 10,),
              TextFormField(
                controller: note,
              decoration: InputDecoration(
                hintText: 'note'
              ),
              ),
               SizedBox(height: 10,),
                TextFormField(
                controller: title,
              decoration: InputDecoration(
                hintText: 'title'
              ),
              ),
              SizedBox(height: 10,),
               TextFormField(
                controller: color,
                decoration: InputDecoration(
                  hintText: 'color'
                ),
              ),
               SizedBox(height: 10,),
               ElevatedButton(onPressed:()async {
                int response =  await sqlDb .insertDate('''
INSERT INTO notes (`note`,`title`, `color`)VALUES("${note.text}","${title.text}","${color.text}")
''');
if(response >0)Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> Home()),(route) => false);
                print('$response');
               }, child: Text('Add Note',
              //  style: TextStyle(
              //   color: Colors.white
              //  ),
               ))
              
                          ],),
              ))
          ],
        ),
      ),
    );
  }
}

        // await sqlDb .insertDate("INSERT INTO 'notes' ('note')VALUES('note 1')"),),
