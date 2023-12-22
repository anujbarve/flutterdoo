import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterdoo/models/task.dart';
import 'package:flutterdoo/services/sql_service.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/taskTile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String,dynamic>> _tasks = [];
  bool loading = true;

  void addtasks() async {
    final data = await SQLService.getTasks();
    setState(() {
      _tasks = data;
      loading = false;
    });
    print(data);
    final id = await SQLService.createTask(Task.demo());
    print(id);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData() async
  {
    final data = await SQLService.getTasks();
    setState(() {
      _tasks = data;
      loading = false;
    });
    print(data.length);
  }

  var user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: _tasks.length,
          itemBuilder: (BuildContext context,int index) {
            print(_tasks[index]);
            index++;
          }
      )
    );
  }
}
