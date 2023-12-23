import 'package:flutter/material.dart';
import 'package:flutterdoo/models/task.dart';
import 'package:flutterdoo/services/sql_service.dart';
import 'package:sqflite/sqflite.dart' as sql;
import '../models/task.dart' as t;

class TaskProvider extends ChangeNotifier {
  List<Task> taskLists = [];
  List<Task?> completedTaskLists = [];
  late Task currentTask;
  late sql.Database db;

  Future<void> init(String username) async {
    db = await SQLService.db(username);
    notifyListeners();
  }

  Future<List<Task>> getTasks() async {
    var _tasks = await SQLService.getTasks(db);
    taskLists = _tasks.map((e) => Task.fromJson(e)).toList();
    completedTaskLists = taskLists.map((e) {
      if(e.isCompleted == 1)
      {
        return e;
      }
    }).toList();
    notifyListeners();
    return taskLists;
  }

  Future<Task> getSingleTask(int id) async {
    var task = await SQLService.getOneTask(id,db);
    currentTask = Task.fromJson(task.first);
    notifyListeners();
    return currentTask;
  }

  Future<void> addTasks(Task task) async {
    var data = await SQLService.createTask(task,db);
    taskLists.add(task);
    notifyListeners();
  }


  Future<void> completeTask(Task task,int id) async {
    await SQLService.completeTask(id,db);
    var _tasks = await SQLService.getTasks(db);
    taskLists = _tasks.map((e) => Task.fromJson(e)).toList();
    completedTaskLists = taskLists.map((e) {
      if(e.isCompleted == 1)
        {
          return e;
        }
    }).toList();
    notifyListeners();
  }

  Future<void> editTasks(Task task,int id) async {
    await SQLService.updateTask(task, id,db);
    taskLists.clear();
    getTasks();
    notifyListeners();
  }
  
  Future<void> deleteTasks(int id) async {
    await SQLService.deleteTask(id,db);
    taskLists.clear();
    completedTaskLists.clear();
    getTasks();
    notifyListeners();
  }

  Future<void> logout() async {
    db.close();
    taskLists.clear();
    completedTaskLists.clear();
    notifyListeners();
  }
  @override
  void dispose() {
    db.close();
    taskLists.clear();
    completedTaskLists.clear();
    // TODO: implement dispose
    super.dispose();
  }
}
