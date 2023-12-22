class UserModel{
  late final String id;
  late final String username;
  late final String name;
  late final String email;

  UserModel({required this.id, required this.username, required this.name, required this.email});

  fromJson(Map<String,dynamic> map){
    id = map['id'];
    username = map['username'];
    name = map['name'];
    email = map['email'];
  }

  Map<String,dynamic> toJson()
  {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['username'] = username;
    data['email'] = email;
    return data;
  }

  UserModel.demo(){
    id = "1234567890";
    name = "Anuj Barve";
    username = "anujb";
    email = "anujbarve27@gmail.com";
  }
}