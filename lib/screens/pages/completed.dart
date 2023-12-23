import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterdoo/constants/colors.dart';
import 'package:flutterdoo/providers/task_provider.dart';
import 'package:flutterdoo/widgets/taskTile.dart';
import 'package:provider/provider.dart';

class Completed extends StatefulWidget {
  const Completed({super.key});

  @override
  State<Completed> createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.height-250,
          child: Consumer<TaskProvider>(
            builder: (BuildContext context, TaskProvider value, Widget? child) {

              if(value.completedTaskLists.isEmpty)
              {
                return Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      SvgPicture.asset("assets/not_found_svg.svg",height: 200,width: double.infinity),
                      SizedBox(height: 20,),
                      Text("No Tasks Here \nTry to complete some",style: TextStyle(fontSize: 24,color: Colors.black87,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)

                    ],
                  ),
                );
              }

              print(value.completedTaskLists);
              return ListView.builder(
                  itemCount: value.completedTaskLists.length,
                  itemBuilder: (BuildContext ctx,int index) {
                    return Slidable(
                      endActionPane: ActionPane(
                        motion: const BehindMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (ctx) async {
                              await Provider.of<TaskProvider>(context,listen: false).deleteTasks(value.taskLists[index].id);
                            },
                            backgroundColor: Colors.red,
                            icon: Icons.delete ,
                          )
                        ],
                      ),
                      child: value.completedTaskLists[index] != null ? TaskTile(task: value.completedTaskLists[index]!) : Center(),
                    );
                  }
              );
            },
          ),
        ),
      ],
    );
  }
}
