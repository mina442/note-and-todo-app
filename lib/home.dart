import 'package:flutter/material.dart';
import 'package:note_app/editnotes.dart';
import 'package:note_app/sqldb.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SqlDb sqlDb = SqlDb();
  bool isLoading = true;
  List notes = [];
  Future readData()async{
    List<Map> response = await sqlDb .read("notes ");
    // List<Map> response = await sqlDb .read("SELECT * FROM 'notes'");

    notes.addAll(response);
    isLoading = false;
    if(this.mounted){
      setState(() {
        
      });
    }
    //  return response;
  }
  @override
  void initState() {
    readData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SQL APP')),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed:()async => 
        Navigator.of(context).pushNamed('addNotes')),
      body: isLoading == true?Column(
        children: [
          Center(child: CircularProgressIndicator(),),
          Center(child: Text('loading....'),)
        ],
      ):
      Column(
children: [
      Container(
        child: Expanded(
          child: ListView(
            children: [
              // FutureBuilder(future: readData(),
              //  builder:(context, snapshot) {
                //  if(snapshot.hasData){
        // return
         ListView.builder(
          itemCount: notes.length,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder:(context, index) {
         return Card(
            child:ListTile(
              title:Text(notes[index]['note']),
              subtitle: Text(notes[index]['note']),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(onPressed: ()async{
    int response = await sqlDb .delete('notes', "id = ${notes[index]['id']}");
   
    // int response = await sqlDb .deleteDate("DELETE FROM 'notes' WHERE id = ${notes[index]['id']}");
    // if(response >0)Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> Home()));
       notes.removeWhere((element) => element['id'] == notes[index]['id']);
       setState(() {
         
       });
                  }, icon: Icon(Icons.delete)),
                  IconButton(onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> EditNotes(
          color:notes[index]['color'] ,
          note: notes[index]['note'] ,
          title: notes[index]['title'] ,
          id: notes[index]['id'] ,
        )));
                  }, icon: Icon(Icons.edit))

                ],
              )
              ,) ,
          );
        },)
                //  }
                //  return Center(child: CircularProgressIndicator(),);
              //  }, )
            ],
          ),
        )
      ),
  // Center(child: ElevatedButton(onPressed: ()async{
  //   // int response2 = await sqlDb .insertDate("INSERT INTO 'hihi' ('note1')VALUES('note 11')");

  //   print('$response');
  //   // print('$response2');


  // }, child: Text('insert'))),
  // Center(child: ElevatedButton(onPressed: ()async{
  //   List<Map> response = await sqlDb .readDate("SELECT * FROM 'notes'");
  //   // List<Map> response2 = await sqlDb .readDate("SELECT * FROM 'hihi'");

  //   print('$response');
  //   // print('$response2');

  // }, child: Text('read'))),
//  Center(child: ElevatedButton(onPressed: ()async{
//     // int response = await sqlDb .deleteDate("DELETE FROM 'notes' WHERE id = 7");
//     // print('$response');
//   }, child: Text('DELETE'))),
  // Center(child: ElevatedButton(onPressed: ()async{
  //   int response = await sqlDb .updateDate("UPDATE 'notes' SET 'note' = 'note 6'  WHERE id = 5");
  //   print('$response');
  // }, child: Text('updateDate'))),
   Center(child: ElevatedButton(onPressed: ()async{
   await sqlDb .mydeleteDatebase();
    // print('$response');
  }, child: Text('delete'))),
],

      ));
  }
}