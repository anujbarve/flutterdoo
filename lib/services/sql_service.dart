import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterdoo/models/task.dart';
import 'package:flutterdoo/services/shared_service.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLService {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE tasks(
        id INTEGER PRIMARY KEY,
        title TEXT,
        description TEXT,
        createdAt INTEGER,
        dueDate INTEGER,
        priority TEXT,
        isCompleted INTEGER
    )""");
  }

  static Future<void> initializeDatabase(String user) async {
    final databasePath = await sql.getDatabasesPath();
    final databasePathWithUser = '$databasePath/$user.db';

    // Check if the database file already exists
    bool databaseExists = await sql.databaseExists(databasePathWithUser);

    if (!databaseExists) {
      // If the database file doesn't exist, create it and tables
      sql.Database database = await sql.openDatabase(
        databasePathWithUser,
        version: 1,
        onCreate: (sql.Database db, int version) async {
          await createTables(db);
        },
      );
      await database.close();
    }
  }

  static Future<sql.Database> db(String user) async {
    print(user);

    await initializeDatabase(user);

    return sql.openDatabase('$user.db', version: 1);
  }
  static Future<int> createTask(Task task,sql.Database db) async {
    final data = task.toJson();
    final id = await db.insert(
      "tasks",
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
    return id;
  }

  static Future<List<Map<String,dynamic>>> getTasks(sql.Database db) async {
    return db.query('tasks',orderBy: "id");
  }

  static Future<List<Map<String,dynamic>>> getOneTask(int id,sql.Database db) async {
    return db.query('tasks',where: "id = ?",whereArgs: [id],limit: 1);
  }

  static Future<int> updateTask(Task task,int id,sql.Database db) async
  {
    final data = {
    'title' : task.title,
    'description' : task.description,
    'dueDate' : task.dueDate,
    'priority' : task.priority,
    'isCompleted' : task.isCompleted,
    };

    final result = await db.update('tasks', data,where: "id = ?",whereArgs: [id]);
    return result;
  }

  static Future<int> completeTask(int id,sql.Database db) async
  {
    final data = {
      'isCompleted' : 1,
    };
    final result = await db.update('tasks', data,where: "id = ?",whereArgs: [id]);
    return result;
  }

  static Future<void> deleteTask(int id,sql.Database db) async {
    try{
      await db.delete("tasks",where: "id = ?",whereArgs: [id]);
    }catch(err)
    {
      debugPrint("Something went wrong while deleting an item");
    }
  }
}
