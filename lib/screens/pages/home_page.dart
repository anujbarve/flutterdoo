import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterdoo/constants/colors.dart';
import 'package:flutterdoo/models/task.dart';
import 'package:flutterdoo/providers/task_provider.dart';
import 'package:flutterdoo/screens/edit_screen.dart';
import 'package:flutterdoo/services/sql_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../widgets/taskTile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      await Provider.of<TaskProvider>(context, listen: false).getTasks();
    });
  }

  var user = FirebaseAuth.instance.currentUser;
  List<String> filters = ["HIGH", "MEDIUM", "LOW"];
  List<String> selectedFilters = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width-10,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: filters
                  .map((filter) => Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: FilterChip(
                          selected: selectedFilters.contains(filter),
                          label: Text(filter),
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                selectedFilters.add(filter);
                              } else {
                                selectedFilters.remove(filter);
                              }
                            });
                          },
                        ),
                      ))
                  .toList(),
            ),
          ),
        ),
        Expanded(
          child: Consumer<TaskProvider>(
            builder: (BuildContext context, TaskProvider value, Widget? child) {
              final tasklist = value.taskLists.where((element) {
                return (selectedFilters.isEmpty ||
                    selectedFilters.contains(element.priority));
              }).toList();

              if(tasklist.isEmpty)
                {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                    SvgPicture.asset("assets/not_found_svg.svg",height: 200,width: double.infinity,),
                    SizedBox(height: 20,),
                    Text("No Tasks Here",style: TextStyle(fontSize: 24,color: Colors.black87,fontWeight: FontWeight.bold),)
                    
                    ],
                  );
                }

              return ListView.builder(
                  itemCount: tasklist.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    return Slidable(
                      endActionPane: ActionPane(
                        motion: const BehindMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (ctx) async {
                              await Provider.of<TaskProvider>(context,
                                      listen: false)
                                  .deleteTasks(tasklist[index].id);
                            },
                            backgroundColor: Colors.red,
                            icon: Icons.delete,
                          ),
                          SlidableAction(
                            onPressed: (ctx) async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditTaskScreen(
                                          id: tasklist[index].id)));
                            },
                            backgroundColor: AppColors.deepGreen,
                            icon: Icons.edit,
                          )
                        ],
                      ),
                      startActionPane: ActionPane(
                        motion: const BehindMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (ctx) async {
                              await Provider.of<TaskProvider>(context,
                                      listen: false)
                                  .completeTask(tasklist[index],
                                      tasklist[index].id);
                            },
                            backgroundColor: AppColors.deepGreen,
                            icon: Icons.check_box,
                          )
                        ],
                      ),
                      child: TaskTile(task: tasklist[index]),
                    );
                  });
            },
          ),
        ),
      ],
    );
  }
}
