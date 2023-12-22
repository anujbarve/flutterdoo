class Task {

  late final String createdAt;
  late final String title;
  late final String description;
  late final String dueDate;
  late final String priority;
  late final int isCompleted;

  Task(
      {
      required this.createdAt,
      required this.title,
      required this.description,
      required this.dueDate,
      required this.priority,
      required this.isCompleted
      });

  fromJson(Map<String, dynamic> map) {
    createdAt = map['createdAt'];
    title = map['title'];
    description = map['description'];
    dueDate = map['dueDate'];
    priority = map['priority'];
    isCompleted = map['isCompleted'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['createdAt'] = createdAt;
    data['title'] = title;
    data['description'] = description;
    data['dueDate'] = dueDate;
    data['priority'] = priority;
    data['isCompleted'] = isCompleted;
    return data;
  }

  Task.demo(){
    createdAt = "22-12-2023";
    title = "Complete SQFLITE Integration and a lot of stuff";
    description = "Complete the full SQFLITE Integration in the app,Complete the full SQFLITE Integration in the app,Complete the full SQFLITE Integration in the app";
    dueDate = "23-12-2023";
    priority = "MEDIUM";
    isCompleted = 0;
  }
}
