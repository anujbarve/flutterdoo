class Task{
  late final String id;
  late final String createdAt;
  late final String title;
  late final String description;
  late final String dueDate;
  late final String priority;

  Task({required this.id, required this.username, required this.name, required this.email});

  fromJson(Map<String,dynamic> map){
    id = map['id'];
    createdAt = map['createdAt'];
    title = map['title'];
    description = map['description'];
    dueDate = map['dueDate'];
    priority = map['priority'];
  }

  Map<String,dynamic> toJson()
  {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['title'] = data;
    data['description'] = description;
    data['dueDate'] = dueDate;
    data['priority'] = priority;
    return data;
  }
}