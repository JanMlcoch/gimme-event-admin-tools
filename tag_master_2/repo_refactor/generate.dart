library generate;

import 'dart:io';
import 'dart:convert';

void main() {
  String oldString = "";

  File oldRepo = new File("repo_refactor/original_repo");
  oldString = oldRepo.readAsStringSync();

  oldString = oldString.replaceAll(";",",");
  oldString = oldString.replaceAll(",,",",null,");
  oldString = oldString.replaceAll("\n", "],\n");
  List<String> linesOfOldString = oldString.split("\n");
  List<String> lines2 = [];
  for(String line in linesOfOldString){
    lines2.add(line.replaceFirst(",",":["));
  }
  oldString = lines2.reduce((a,b)=>"$a$b");
  String oldStringDart = "Map<String,dynamic> original = {$oldString};";

  File old = new File("repo_refactor/original.dart");
  old.createSync();
  old.writeAsStringSync(oldStringDart);

  oldString = oldString.replaceAll("],","],\"");
  oldString = oldString.replaceAll(":[","\":[");
  oldString = "{\"$oldString}";
  oldString = oldString.replaceAll("],\"}","]}");

  String json = "";

  Map<String, dynamic> preJson = {"tags": {}, "relations": []};

  Map<String, dynamic> originalMap = JSON.decode(oldString);

  originalMap.forEach((String key, List<dynamic> values) {
    preJson["tags"][key] = {"name": values[0], "type": values[1], "lang": "cz", "authorId": -1};
    if (values[1] == 1) {
      preJson["relations"].add({
        "originTagIds": [int.parse(key)],
        "destinationTagId": values[5],
        "relation": {"type": "synonym"}
      });
    }
  });


  json = JSON.encode(preJson);

  String postJson = "Map<String,dynamic> newRepo = $json ;";

  File file = new File("repo_refactor/new.dart");
  file.createSync();
  file.writeAsStringSync(postJson);

  File newRepo = new File("repo_refactor/new_repo");
  newRepo.createSync();
  newRepo.writeAsStringSync(json);
}
