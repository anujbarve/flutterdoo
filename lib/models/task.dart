class Task {
  late int id;
  late int createdAt;
  late String title;
  late String description;
  late int dueDate;
  late String priority;
  late int isCompleted;

  Task({
    required this.id,
    required this.createdAt,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.priority,
    required this.isCompleted,
  });

  Task.fromJson(Map<String, dynamic> map) {
    id = map['id'];
    createdAt = map['createdAt'];
    title = map['title'];
    description = map['description'];
    dueDate = map['dueDate'];
    priority = map['priority'];
    isCompleted = map['isCompleted'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['title'] = title;
    data['description'] = description;
    data['dueDate'] = dueDate;
    data['priority'] = priority;
    data['isCompleted'] = isCompleted;
    return data;
  }

  Task.demo()
      : id = 12343556,
        createdAt = 3241781727,
        title = "Complete SQFLITE Integration and a lot of stuff",
        description =
        "Complete the full SQFLITE Integration in the app,Complete the full SQFLITE Integration in the app,Complete the full SQFLITE Integration in the app",
        dueDate = 143478124701,
        priority = "MEDIUM",
        isCompleted = 0;
}