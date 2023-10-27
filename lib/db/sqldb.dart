
// import 'package:note_app/h/model/note.dart';
import 'package:note_app/model/note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
// static final NotesDatabase instance = NotesDatabase._init();
//+NotesDatabase._init(); == mydb

  static Database? _database ; 
  
  Future<Database?> get database async {
      if (_database == null){
        _database  = await intialDb('notes.db') ;
        return _database ;  
      }else {
        return _database ; 
      }
  }


  Future<Database>intialDb(String filePath) async {
  final databasepath = await getDatabasesPath() ; 
  final path = join(databasepath, filePath);  
  Database mydb = await openDatabase(path , onCreate: _onCreate , version: 3  , onUpgrade:_onUpgrade ) ;  
  return mydb ; 
}

_onUpgrade(Database db , int oldversion , int newversion ) {


 print("onUpgrade =====================================") ; 
  
}

_onCreate(Database db , int version) async {
   const idType = 'INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $tableNotes ( 
  ${NoteFields.id} $idType, 
  ${NoteFields.isImportant} $boolType,
  ${NoteFields.number} $integerType,
  ${NoteFields.title} $textType,
  ${NoteFields.description} $textType,
  ${NoteFields.time} $textType
  )
''');
//   await db.execute('''
//   CREATE TABLE "notes" (
//     "id" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT, 
//     "note" TEXT NOT NULL
//   )
//  ''') ;
 print(" onCreate =====================================") ; 

}
//  Future<Note> create(Note note) async {
//    Database? mydb = await database ; 
//    final id = await mydb!.insert(tableNotes, note.toJson());
//   }

 Future<Note> readData(int id) async {
  Database? mydb = await database ; 
final response = await  mydb!.query(tableNotes,
      columns: NoteFields.values,
      where: '${NoteFields.id} = ?',
      whereArgs: [id],);
       if (response.isNotEmpty) {
      return Note.fromJson(response.first);
    } else {
      throw Exception('ID $id not found');
    }
  // return response ; 
}
Future<List<Note>> readAllNotes() async {
  Database? mydb = await database ; 


    final orderBy = '${NoteFields.time} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await mydb!.query(tableNotes, orderBy: orderBy);

    return result.map((json) => Note.fromJson(json)).toList();
  }
 Future<Note>insertData(Note note) async {
  Database? mydb = await database ; 
  final  response = await  mydb!.insert(tableNotes, note.toJson());
    return note.copy(id: response);
  // return response ; 
}
 Future<int> updateData(Note note) async {
  Database? mydb = await database ; 
    final response = await  mydb!.update(
    tableNotes,
      note.toJson(),
      where: '${NoteFields.id} = ?',
      whereArgs: [note.id],);
  return response ; 
}
Future<int> deleteData(int id) async {
  Database? mydb = await database ; 
  final  response = await  mydb!.delete(
      tableNotes,
      where: '${NoteFields.id} = ?',
      whereArgs: [id],
    );
  return response ; 
}
  Future close() async {
     Database? mydb = await database ; 


    mydb!.close();
  }
   mydeleteDatebase(String filePath)async{
      final databasepath = await getDatabasesPath() ; 
  final path = join(databasepath, filePath);  
     await deleteDatabase(path);
  }
 

// SELECT 
// DELETE 
// UPDATE 
// INSERT 
 

}
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// class SqlDb {

//   static Database? _db ; 
  
//   Future<Database?> get db async {
//       if (_db == null){
//         _db  = await intialDb() ;
//         return _db ;  
//       }else {
//         return _db ; 
//       }
//   }


// intialDb() async {
//   String databasepath = await getDatabasesPath() ; 
//   String path = join(databasepath , 'wael.db') ;   
//   Database mydb = await openDatabase(path , onCreate: _onCreate , version: 3  , onUpgrade:_onUpgrade ) ;  
//   return mydb ; 
// }

// _onUpgrade(Database db , int oldversion , int newversion ) {


//  print("onUpgrade =====================================") ; 
  
// }

// _onCreate(Database db , int version) async {
//   await db.execute('''
//   CREATE TABLE "notes" (
//     "id" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT, 
//     "note" TEXT NOT NULL
//   )
//  ''') ;
// print('Create______________________________'); 
//   }
//   _onUpgrade(Database db,int oldVersion,int newVersion) async{
 
//        print('Upgrade______________________'); 
//      }
//   read(String table)async{
//   // readDate(String sql)async{

//     Database? mydb = await db;
//     List<Map<String, Object?>> response = await mydb!.query(table);
//     return response;
//   }
//    insert(String table, Map<String, Object?> values,)async{
//   //  insertDate(String sql)async{

//     Database? mydb = await db;
//     int response = await mydb!.insert (table, values,);
//     return response;
//   }
//     //  updateDate(String sql)async{
//      update(String table, Map<String, Object?> values,String? mywhere)async{

//     Database? mydb = await db;
//     int response = await mydb!.update(table, values,where: mywhere);
//     return response;
//   }
//      delete( String table, String? mywhere)async{
//     //  deleteDate(String sql)async{

//     Database? mydb = await db;
//     int response = await mydb!.delete(table ,where: mywhere);
//     return response;
//   }
//   //    insertDate(String sql)async{
//   //   Database? mydb = await db;
//   //   int response = await mydb!.raw(sql);
//   //   return response;
//   // }
//   mydeleteDatebase()async{
//         String databasepath = await getDatabasesPath();
//      String path = join(databasepath,'wael.db');
//      await deleteDatabase(path);
//   }
// }
 

// // SELECT 
// // DELETE 
// // UPDATE 
// // INSERT 
 

// }