library resolver;

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
//import '../../../admin_tools_client/lib/tagger/model/library.dart';

List<User> users = [];
GimmeEvents events;

void main() {
  File usersDataFile = new File("bin/resolver/users.json");
  String userData = usersDataFile.readAsStringSync();
  for (Map user in JSON.decode(userData)) {
    users.add(new User()..fromMap(user));
  }

  print(users.length);

  http.post("http://localhost:15555", body: JSON.encode({
    "action": "sendInitialData",
    "data": {
      "users": JSON.encode(users.map((u) => u.toMap()).toList()),
      "events": events.toMap()
    }
  }));
}


class User {
  Tags tags = new Tags();
  int id;
  String name;

  void fromMap(Map data) {
    id = data["id"];
    name = data["name"];
    tags.fromList(data["tags"]);
  }


  Map toMap() {
    return {
      "id": id,
      "name":name,
      "tags": tags.toList()
    };
  }
}
