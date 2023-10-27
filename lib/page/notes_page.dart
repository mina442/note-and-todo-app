import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:note_app/db/sqldb.dart';
import 'package:note_app/widget/notecardwidget.dart';
// import '../db/notes_database.dart';
import '../model/note.dart';
import '../page/edit_note_page.dart';
import '../page/note_detail_page.dart';
// import '../widget/note_card_widget.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  SqlDb sqlDb = SqlDb();

  late List<Note> notes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNotes();
  }

  @override
  void dispose() {
    sqlDb.close();

    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    notes = await sqlDb.readAllNotes();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Notes',
            style: TextStyle(fontSize: 24),
          ),
          actions: const [Icon(Icons.search), SizedBox(width: 12)],
        ),

        /////////
        body: isLoading
            ? Center(child: const CircularProgressIndicator())
            : notes.isEmpty
                ? const Text(
                    'No Notes',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  )
                : buildNotes(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: const Icon(Icons.add),
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddEditNotePage()),
            );

            refreshNotes();
          },
        ),
      );
  Widget buildNotes() => StaggeredGrid.count(
      // itemCount: notes.length,
      // staggeredTileBuilder: (index) => StaggeredTile.fit(2),
      crossAxisCount: 2,
      mainAxisSpacing: 2,
      crossAxisSpacing: 2,
      children: List.generate(
        notes.length,
        (index) {
          final note = notes[index];
          return StaggeredGridTile.fit(
            crossAxisCellCount: 1,
            child: GestureDetector(
              onTap: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => NoteDetailPage(noteId: note.id!),
                ));

                refreshNotes();
              },
              child: NoteCardWidget(note: note, index: index),
            ),
          );
        },
      ));

  // Widget buildNotes() => StaggeredGridView.countBuilder(
  //       padding: const EdgeInsets.all(8),
  //       itemCount: notes.length,
  //       staggeredTileBuilder: (index) => StaggeredTile.fit(2),
  //       crossAxisCount: 4,
  //       mainAxisSpacing: 4,
  //       crossAxisSpacing: 4,
  //       itemBuilder: (context, index) {
  //         final note = notes[index];

  //         return GestureDetector(
  //           onTap: () async {
  //             await Navigator.of(context).push(MaterialPageRoute(
  //               builder: (context) => NoteDetailPage(noteId: note.id!),
  //             ));

  //             refreshNotes();
  //           },
  //           child: NoteCardWidget(note: note, index: index),
  //         );
  //       },
  //     );
}
// import 'package:flutter/material.dart';
// import 'package:note_app/db/sqldb.dart';
// // import 'package:note_app/editnotes.dart';
// import 'package:note_app/model/note.dart';
// // import 'package:note_app/sqldb.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:note_app/widget/notecardwidget.dart';

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   SqlDb sqlDb = SqlDb();
//   bool isLoading = true;
//   List notess = [];
//     late List<Note> notes;
//   Future readData()async{
//    response = await sqlDb .readData("notes ");
//     // List<Map> response = await sqlDb .read("SELECT * FROM 'notes'");

//     notess.addAll(response);
//     isLoading = false;
//     if(mounted){
//       setState(() {
        
//       });
//     }
//     //  return response;
//   }
//   @override
//   void initState() {
//     readData();
//     super.initState();
//   }
//   // @override
//   // void dispose() {
//   //   SqlDb.instance.close();

//   //   super.dispose();
//   // }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           title: const Text(
//             'Notes',
//             style: TextStyle(fontSize: 24),
//           ),
//           actions: const [Icon(Icons.search), SizedBox(width: 12)],
//         ),
//       floatingActionButton: FloatingActionButton(
//         child: const Icon(Icons.add),
//         onPressed:()async => 
//         Navigator.of(context).pushNamed('addNotes')),
    
    
    
    
    
    
//       body: Center(
//         child: isLoading == true?
//          const CircularProgressIndicator():
//          notess.isEmpty
//                   ? const Text(
//                       'No Notes',
//                       style: TextStyle(color: Colors.white, fontSize: 24),
//                     )
//                   :buildNotes()
//       //   Column(
//       // children: [
//       //   Container(
//       //     child: Expanded(
//       //       child:
            
//                 // FutureBuilder(future: readData(),
//                 //  builder:(context, snapshot) {
//                   //  if(snapshot.hasData){
//           // return
           
//             // physics: const NeverScrollableScrollPhysics(),
//             // shrinkWrap: true,
//             // itemBuilder:(context, index)
  
//         //    Card(
//         //       child:ListTile(
//         //         title:Text(notes[index]['note']),
//         //         subtitle: Text(notes[index]['note']),
//         //         trailing: Row(
//         //           mainAxisSize: MainAxisSize.min,
//         //           children: [
//         //             IconButton(onPressed: ()async{
//         //   int response = await sqlDb .delete('notes', "id = ${notes[index]['id']}");
         
//         //   // int response = await sqlDb .deleteDate("DELETE FROM 'notes' WHERE id = ${notes[index]['id']}");
//         //   // if(response >0)Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> Home()));
//         //  notes.removeWhere((element) => element['id'] == notes[index]['id']);
//         //  setState(() {
           
//         //  });
//         //             }, icon: const Icon(Icons.delete)),
//         //             IconButton(onPressed: (){
//         //               Navigator.of(context).push(MaterialPageRoute(builder: (context)=> EditNotes(
//         //     color:notes[index]['color'] ,
//         //     note: notes[index]['note'] ,
//         //     title: notes[index]['title'] ,
//         //     id: notes[index]['id'] ,
//         //   )));
//         //             }, icon: const Icon(Icons.edit))
      
//         //           ],
//         //         )
//         //         ,) ,
//         //     );
//           ));
//                   //  }
//                   //  return Center(child: CircularProgressIndicator(),);
//                 //  }, )
              
            
//         // );
//         // Center(child: ElevatedButton(onPressed: ()async{
//         //   // int response2 = await sqlDb .insertDate("INSERT INTO 'hihi' ('note1')VALUES('note 11')");
      
//         //   print('$response');
//         //   // print('$response2');
      
      
//         // }, child: Text('insert'))),
//         // Center(child: ElevatedButton(onPressed: ()async{
//         //   List<Map> response = await sqlDb .readDate("SELECT * FROM 'notes'");
//         //   // List<Map> response2 = await sqlDb .readDate("SELECT * FROM 'hihi'");
      
//         //   print('$response');
//         //   // print('$response2');
      
//         // }, child: Text('read'))),
//       //  Center(child: ElevatedButton(onPressed: ()async{
//       //     // int response = await sqlDb .deleteDate("DELETE FROM 'notes' WHERE id = 7");
//       //     // print('$response');
//       //   }, child: Text('DELETE'))),
//         // Center(child: ElevatedButton(onPressed: ()async{
//         //   int response = await sqlDb .updateDate("UPDATE 'notes' SET 'note' = 'note 6'  WHERE id = 5");
//         //   print('$response');
//         // }, child: Text('updateDate'))),
//         //  Center(child: ElevatedButton(onPressed: ()async{
//         //  await sqlDb .mydeleteDatebase();
//         //   // print('$response');
//         // }, child: const Text('delete')))
//       // ],
      
        
//       // )
//       // );
//   }

// Widget buildNotes() => StaggeredGrid.count(
//       // itemCount: notes.length,
//       // staggeredTileBuilder: (index) => StaggeredTile.fit(2),
//       crossAxisCount: 2,
//       mainAxisSpacing: 2,
//       crossAxisSpacing: 2,
//       children: List.generate(
//         notes.length,
//         (index) {
//           final note = notes[index];
//           return StaggeredGridTile.fit(
//             crossAxisCellCount: 1,
//             child: GestureDetector(
//               onTap: () async {
//                 await Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => NoteDetailPage(noteId: note.id!),
//                 ));

//                 // refreshNotes();
//               },
//               child: NoteCardWidget(note: note, index: index),
//             ),
//           );
//         },
//       ));
// }
