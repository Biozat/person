import 'package:get/utils.dart';
import 'package:sqflite/sqflite.dart';

import '../models/Person.dart';

class DBHelper{
  static Database? _db;
  static final int version = 1;
  static final String _tableName = "persons";

   static Future<void> initDb() async {
     if(_db != null){
       return;
     }

     try{
       String _path = await getDatabasesPath()+"person.db";
       _db = await openDatabase(
           _path,
         version: version,
         onCreate: (db, version){
             return db.execute(
               "CREATE TABLE $_tableName("
                   "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                    "name TEXT, "
                    "age TEXT)",

             );
         }
       );
     }catch(e){

     }

   }

   static Future<int> insert(Person? person) async{
     return await _db?.insert(_tableName, person!.toJson())??1;
   }

  static Future<List<Map<String, dynamic>>> query() async {
    return await _db!.query(_tableName,);
  }
}