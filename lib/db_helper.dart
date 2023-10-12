import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class DatabaseHelper{

  static final _databasename = 'person.db';
  static final version = 1;

  static final _tablename = 'my_table';
  static final Colid = 'id';
  static final Colname = 'name';
  static final Colage = 'age';

  static Database?  _database  ;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future<Database?> get database async{
    if(_database!=null){
      return _database;
    }
    else{
      _database = await initDatabase();
      return _database;
    }
  }
  initDatabase()async{
    Directory docDirectory = await getApplicationDocumentsDirectory();
    String path = join(docDirectory.path,_databasename);
    return await openDatabase(path,version: version,onCreate: _onCreate);
  }
  Future _onCreate(Database db,int version)async{
    await db.execute(
      '''
      CREATE TABLE $_tablename(
      $Colid INTEGER PRIMARY KEY,
      $Colage INTEGER NOT NULL,
      $Colname TEXT NOT NULL
      )
      '''
    );
  }

  //Functions to play with database
Future<int> insert(Map<String,dynamic> row) async {
  Database? db = await instance.database;
    if(db!=null){
      return await db.insert(_tablename,row);
    }
    else{
      return 0;
    }
}


Future<List<Map<String,dynamic>>> queryAll() async {
  Database? db = await instance.database;
    if(db!=null){
      return await db.query(_tablename);
    }
    else{
      return [{
        Colid: 0,
        Colname : 'No Data',
        Colage: 0
      }];
    }
}

  Future<int> update(Map<String,dynamic> row) async {
    Database? db = await instance.database;
    if(db!=null){
      int id = row[Colid];
      return await db.update(_tablename, row ,where: '$Colid = ?',whereArgs: [id] );
    }
    else{
      return 0;
    }
  }

  Future<int> delete(int id) async {
    Database? db = await instance.database;
    if(db!=null){
      return await db.delete(_tablename ,where: '$Colid = ?',whereArgs: [id] );
    }
    else{
      return 0;
    }
  }
}