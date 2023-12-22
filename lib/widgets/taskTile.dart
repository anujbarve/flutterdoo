import 'package:flutter/material.dart';
import 'package:flutterdoo/models/task.dart';

class TaskTile extends StatefulWidget {
  final Task task;

  const TaskTile({super.key, required this.task});

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 6,
        decoration: BoxDecoration(
            color: Colors.greenAccent, borderRadius: BorderRadius.circular(20)),
        child: Stack(
          children: [
            Positioned(
              top: 20,
              left: 10,
              width: MediaQuery.of(context).size.width-30,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  widget.task.title,
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      overflow: TextOverflow.ellipsis),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                alignment: Alignment.centerLeft,
                height: 50,
                width: MediaQuery.of(context).size.width-15,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20)),
                    color: Colors.black.withOpacity(0.2)
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(widget.task.dueDate,style: TextStyle(color: Colors.white),),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                alignment: Alignment.centerLeft,
                height: 50,
                width: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),topLeft: Radius.circular(20)),
                    color: Colors.black.withOpacity(0.2)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(widget.task.priority,style: TextStyle(color: Colors.white),),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),topLeft: Radius.circular(20)),
                  color: Colors.black.withOpacity(0.2)
                ),
                child: widget.task.isCompleted == 0 ? Icon(Icons.check_box_outlined,color: Colors.white,) : Icon(Icons.check_box_outline_blank_outlined,color: Colors.white,),
              ),
            ),


            Positioned(
              top: 50,
              left: 20,
              width: MediaQuery.of(context).size.width-20,
              child: Text(
                widget.task.description,
                overflow: TextOverflow.fade,
                maxLines: 2,
                style: TextStyle(fontSize: 14,),
              ),
            )
          ],
        ),
      ),
    );
  }
}
