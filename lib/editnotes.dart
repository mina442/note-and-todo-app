
import 'package:flutter/material.dart';
import 'package:note_app/home.dart';
import 'package:note_app/sqldb.dart';

class EditNotes extends StatefulWidget {
  final note;
  final title;
  final color;
  final id;


  const EditNotes({super.key, this.note, this.title, this.color, this.id});

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
   SqlDb sqlDb = SqlDb();
  GlobalKey<FormState> formState =GlobalKey();
  TextEditingController note= TextEditingController (); 
  TextEditingController title = TextEditingController ();  
  TextEditingController color = TextEditingController ();   
  @override
  void initState() {
note.text = widget.note;
title.text = widget.title;
color.text = widget.color;

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('edit note'),
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
            int response = await sqlDb .updateDate("UPDATE 'notes' SET note = '${note.text}',title = '${title.text}',color = '${color.text}' WHERE id = ${widget.id}");
if(response >0)Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> Home()),(route) => false);
                print('$response');
               }, child: Text('edit Note',
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
    // int response = await sqlDb .updateDate("UPDATE 'notes' SET 'note' = 'note 6'  WHERE id = 5");