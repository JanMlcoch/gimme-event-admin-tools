library generate;

import 'dart:io';
import 'dart:convert';
import '../../tag_master/repo/library.dart';

void main() {
  String oldString = "";

  File oldRepo = new File("data/repo_refactor/original_repo");
  oldString = oldRepo.readAsStringSync();

  oldString = oldString.replaceAll(";", ",");
  oldString = oldString.replaceAll(",,", ",null,");
  oldString = oldString.replaceAll("\n", "],\n");
  List<String> linesOfOldString = oldString.split("\n");
  List<String> lines2 = [];
  for (String line in linesOfOldString) {
    lines2.add(line.replaceFirst(",", ":["));
  }
  oldString = lines2.reduce((a, b) => "$a$b");
  String oldStringDart = "Map original = {$oldString};";

  File old = new File("data/repo_refactor/original.dart");
  old.createSync();
  old.writeAsStringSync(oldStringDart);

  oldString = oldString.replaceAll("],", "],\"");
  oldString = oldString.replaceAll(":[", "\":[");
  oldString = "{\"$oldString}";
  oldString = oldString.replaceAll("],\"}", "]}");

  String json = "";

  Map<String, dynamic> preJson = {"tags": [], "relations": []};

  Map<String, dynamic> originalMap = (JSON.decode(oldString) as Map<String, dynamic>);

  originalMap.forEach((String key, List<dynamic> values) {
    preJson["tags"].add({"tagId": int.parse(key), "tagName": values[0], "tagType": values[1], "lang": "cz", "authorId": -1});
    if (values[1] == 1) {
      preJson["relations"].add({
        "originTagIds": [int.parse(key)],
        "destinationTagId": values[5],
        "relation": {"type": "synonym"}
      });
    }
  });


  json = JSON.encode(preJson);

  String postJson = "Map newRepo = $json ;";

  File file = new File("data/repo_refactor/new.dart");
  file.createSync();
  file.writeAsStringSync(postJson);

  File newRepo = new File("data/repo_refactor/new_repo");
  newRepo.createSync();
  newRepo.writeAsStringSync(json);

  TagMasterRepository repo = new TagMasterRepository()..fromMap(preJson as Map<String, List<Map<String, dynamic>>>);
  Map mapie = repo.toMap();
  String deserializedJson = JSON.encode(mapie);
  deserializedJson = "Map a =$deserializedJson;";

  File filex = new File("data/repo_refactor/new_deserialized.dart");
  filex.createSync();
  filex.writeAsStringSync(deserializedJson);

  repo.validate();
}
