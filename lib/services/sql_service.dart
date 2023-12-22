import 'package:flutter/cupertino.dart';
import 'package:flutterdoo/models/task.dart';
import 'package:sqflite/sql.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLService {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE tasks(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT,
        description TEXT,
        createdAt INTEGER,
        dueDate INTEGER,
        priority TEXT,
        isCompleted INTEGER
    )""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('tasks.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  static Future<int> createTask(Task task) async {
    final db = await SQLService.db();
    final data = task.toJson();
    final id = await db.insert(
      "tasks",
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
    return id;
  }

  static Future<List<Map<String,dynamic>>> getTasks() async {
    final db = await SQLService.db();
    return db.query('tasks',orderBy: "id");
  }

  static Future<List<Map<String,dynamic>>> getOneTask(int id) async {
    final db = await SQLService.db();
    return db.query('tasks',where: "id = ?",whereArgs: [id],limit: 1);
  }

  static Future<int> updateTask(Task task,int id) async
  {
    final db = await SQLService.db();
    final data = {
    'createdAt' : DateTime.now().toIso8601String(),
    'title' : task.title,
    'description' : task.description,
    'dueDate' : task.dueDate,
    'priority' : task.priority,
    'isCompleted' : 0,
    };

    final result = await db.update('tasks', data,where: "id = ?",whereArgs: [id]);
    return result;
  }

  static void deleteTask(Task task,int id) async {
    final db = await SQLService.db();
    try{
      await db.delete("tasks",where: "id = ?",whereArgs: [id]);
    }catch(err)
    {
      debugPrint("Something went wrong while deleting an item");
    }
  }
}
