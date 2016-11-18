part of tagMaster2;

class ActionRecord {
  static const String TYPE_BINARY_RELATION = "t1";
  static const String TYPE_TERNARY_RELATION = "t2";
  static const String TYPE_QUATERNARY_RELATION = "t1";
  static const String TYPE_ADD_TAG = "addTag";
  static const String TYPE_REMOVE_TAG = "removeTag";
  static const String TYPE_CHANGE_TAG = "t1";

  int id;
  int versionId;
  int userId;
  Record record;
  String type;

  void fromMap(Map<String, dynamic> map) {
    id = map["id"];
    versionId = map["versionId"];
    userId = map["userId"];
    if (map["record"] is Map<String, dynamic>) {
      record = new Record.fromMapConstructor((map["record"]) as Map<String, dynamic>);
    }
    else{
      print("JSON object for creation of record had wrong format");
    }
    type = map["type"];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};

    map["id"] = id;
    map["versionId"] = versionId;
    map["userId"] = userId;
    map["record"] = record.toMap();
    map["type"] = type;

    return map;
  }
}
