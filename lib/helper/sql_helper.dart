import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tasky/models/data.dart';

class SqlHelper {
  SqlHelper.createInstance();
  static final SqlHelper instance = SqlHelper.createInstance();

  static Database _database;

  Future<Database> get database async {
    if (_database == null) _database = await initializedDatabase();
    return _database;
  }

  Future<Database> initializedDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "todoList.db");
    return await openDatabase(path, version: 1, onCreate: createDatabase);
  }

  void createDatabase(Database db, int version) async {
    print("create database");
    await db.execute('''
    CREATE TABLE Tasks(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      category TEXT,
      title TEXT,
      proirty INTEGER,
      date INTEGER,
      isDone INTEGER
    );
    ''');
  }

  Future<List<Data>> getTodoList(String tableName) async {
    print("get data from $tableName");
    Database db = await instance.database;
    var todo =[];
    if(tableName == "All") 
    try {
      todo = await db.query("Tasks", orderBy: 'date');
    } catch (e) {
      print(e);
    }
    else
    try{
    todo = await db.query("Tasks", orderBy: 'date',where: "category = ?", whereArgs: [tableName]);
    }catch(e){
      print(e);
    }
    List<Data> todoList =
        todo.isNotEmpty ? todo.map((e) => Data.fromMap(e)).toList() : [];
    return todoList;
  }

Future<List<Data>> getAllTodoList() async {
    print("get data from All");
    Database db = await instance.database;
    var todo = await db.query("Tasks", orderBy: 'id');
    List<Data> todoList =
        todo.isNotEmpty ? todo.map((e) => Data.fromMap(e)).toList() : [];
    return todoList;
  }

  // Future<List<Data>> getAllTodoList() async {
  //   print("get all data");
  //   Database db = await instance.database;
  //   List<String> tables = await instance.getAll();
  //   var l = [];
  //   for (var item in tables) {
  //     var todo = await db.query(item, orderBy: 'id');
  //     l = [...todo];
  //   }
  //   List<Data> todoList =
  //       l.isNotEmpty ? l.map((e) => Data.fromMap(e)).toList() : [];
  //   return todoList;
  // }

  

  Future<int> insert(Data data) async {
    print("insert $data");
    Database db = await instance.database;
    return await db.insert("Tasks", data.tomap());
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    print("delete $id");
    return await db.delete("Tasks", where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(Data data) async {
    Database db = await instance.database;
    return await db
        .update('Tasks', data.tomap(), where: "id = ?", whereArgs: [data.id]);
  }

  Future<List<String>> getCategories()async{
     Database db = await instance.database;
     var result = await db.rawQuery("SELECT DISTINCT category FROM Tasks");
     print("result = $result");
     List<String> l = [];
     for (var item in result) {
       l.add(item["category"]);
     }
     print("l = $l");
     return l;
    //  print("Vals = ${result.}")
     var res = await db.query("Tasks",distinct: true,columns: ["category"] );
     print("res = $res");
     List<String> categories = res.isNotEmpty ? res.map((e) => e.values) : [];
     print("cats = $categories");
     return categories;
 
    //  return result;
  }

  Future getAll() async {
    Database db = await instance.database;
    var result = await db.query('sqlite_master',
        columns: ['name'],
        where: 'type = ?',
        whereArgs: ['table'],
        orderBy: 'name');

    List<String> tablesList =
        result.isNotEmpty ? result.map((e) => Data.fromMap(e)).toList() : [];
    return tablesList;
  }
}
