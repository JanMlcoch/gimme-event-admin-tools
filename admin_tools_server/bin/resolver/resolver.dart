library resolver;
import 'dart:convert';
import 'dart:io';
import '../../../admin_tools_client/lib/tagger/model/library.dart';

List<User> users = [];

void main(){

  File usersDataFile = new File("bin/resolver/users.json");
  String userData = usersDataFile.readAsStringSync();
  for(Map user in JSON.decode(userData)){
    users.add(new User()..fromMap(user));
  }

  print(users.length);

}


class User{
  Tags tags = new Tags();
  int id;
  String name;

  void fromMap(Map data){
    id = data["id"];
    name = data["name"];
    tags.fromList(data["tags"]);
  }

}
