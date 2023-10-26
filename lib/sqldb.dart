
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
//   Database mydb = await openDatabase(path , onCreate: _onCreate , version: 9 , onUpgrade:_onUpgrade ) ;  
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
// //    await db.execute('''
// //   CREATE TABLE "notes" (
// //     "id" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT, 
// //     "note" TEXT NOT NULL
// //   )
// //  ''') ;
// //   await db.execute('''
// //   CREATE TABLE "hihi" (
// //     "id1" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT, 
// //     "note1" TEXT NOT NULL
// //   )
// //  ''') ;
// //   await db.execute('''
// //   CREATE TABLE "m" (
// //     "id" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT, 
// //     "note2" TEXT NOT NULL
// //   )
// //  ''') ;
// //     '''
// // CREATE TABLE "notes"(
// //     "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
// //     "note" TEXT NOT NULL,)
// //     '''
// // );
//  print(" onCreate =====================================") ; 

// }

// readData(String sql) async {
//   Database? mydb = await db ; 
//   List<Map> response = await  mydb!.rawQuery(sql);
//   return response ; 
// }
// insertData(String sql) async {
//   Database? mydb = await db ; 
//   int  response = await  mydb!.rawInsert(sql);
//   return response ; 
// }
// updateData(String sql) async {
//   Database? mydb = await db ; 
//   int  response = await  mydb!.rawUpdate(sql);
//   return response ; 
// }
// deleteData(String sql) async {
//   Database? mydb = await db ; 
//   int  response = await  mydb!.rawDelete(sql);
//   return response ; 
// }
 

// // SELECT 
// // DELETE 
// // UPDATE 
// // INSERT 
 

// }
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class SqlDb{
  static Database? _db;
  Future<Database?> get db async{
   if(_db == null){
    _db = await intialDb();
    return _db;
   }
   else return _db;
  }


  intialDb()async{
    String databasepath = await getDatabasesPath();
     String path = join(databasepath,'wael.db');
     Database mydb = await openDatabase(path,onCreate: _onCreate,version: 2,onUpgrade: _onUpgrade);
     return mydb;
  
    }

  
  _onCreate(Database db , int version)async{
Batch batch = db.batch();
  batch.execute('''
  CREATE TABLE "notes" (
    "id" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT, 
    "note" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "color" TEXT NOT NULL
  )
 ''') ;
 await batch.commit();
//   await db.execute('''
//   CREATE TABLE "notes" (
//     "id" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT, 
//     "note" TEXT NOT NULL,
//     "title" TEXT NOT NULL,
//     "color" TEXT NOT NULL
//   )
//  ''') ;
  //      await db.execute('''
  // CREATE TABLE "hihi" (
  //      "id1" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT, 
  //    "note1" TEXT NOT NULL
  //  )
  // ''') ;

print('Create______________________________'); 
  }
  _onUpgrade(Database db,int oldVersion,int newVersion) async{
 
       print('Upgrade______________________'); 
     }
  read(String table)async{
  // readDate(String sql)async{

    Database? mydb = await db;
    List<Map<String, Object?>> response = await mydb!.query(table);
    return response;
  }
   insert(String table, Map<String, Object?> values,)async{
  //  insertDate(String sql)async{

    Database? mydb = await db;
    int response = await mydb!.insert (table, values,);
    return response;
  }
    //  updateDate(String sql)async{
     update(String table, Map<String, Object?> values,String? mywhere)async{

    Database? mydb = await db;
    int response = await mydb!.update(table, values,where: mywhere);
    return response;
  }
     delete( String table, String? mywhere)async{
    //  deleteDate(String sql)async{

    Database? mydb = await db;
    int response = await mydb!.delete(table ,where: mywhere);
    return response;
  }
  //    insertDate(String sql)async{
  //   Database? mydb = await db;
  //   int response = await mydb!.raw(sql);
  //   return response;
  // }
  mydeleteDatebase()async{
        String databasepath = await getDatabasesPath();
     String path = join(databasepath,'wael.db');
     await deleteDatabase(path);
  }
}