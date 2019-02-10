part of tag_master_2.version;

class ActionRecord {
  static const String TYPE_BINARY_RELATION = "t1";
  static const String TYPE_TERNARY_RELATION = "t2";
  static const String TYPE_QUATERNARY_RELATION = "t3";
//  static const String TYPE_REMOVE_RELATION = "t-";
//  static const String TYPE_ADD_TAG = "addTag";
  static const String TYPE_REMOVE_TAG = "removeTag";
  static const String TYPE_CHANGE_TAG = "changeTag";

  int id;
  int versionId;
  int userId;
  Record record;
  String get type => record.getType();

  ActionRecord.addTag(this.id, this.versionId, this.userId, Tag tag){
    record = new Record.recordTag(tag);
  }

  ActionRecord.removeTag(this.id, this.versionId, this.userId, Tag tag){
    record = new Record.recordTag(tag);
    record.isRemoval = true;
  }

  ActionRecord.changeTag(this.id, this.versionId, this.userId, Tag tag){
    record = new Record.recordTag(tag);
  }

  //todo: other constructors (relations, fromRecord)
  //todo: is validation needed? (no)

  //todo: should this change argument or return copy?
  //todo docs
  TagMasterRepository appliedOn(TagMasterRepository repo) {
    return record.appliedOn(repo);
  }

  void fromMap(Map<String, dynamic> map) {
    id = map["id"];
    versionId = map["versionId"];
    userId = map["userId"];
    if (map["record"] is Map<String, dynamic>) {
      //todo: on is not
      if((map["record"]) is Map<String, dynamic>)record = new Record.fromMapConstructor((map["record"]) as Map<String, Map<String,dynamic>>);
    } else {
      print("JSON object for creation of record had wrong format");
    }
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};

    map["id"] = id;
    map["versionId"] = versionId;
    map["userId"] = userId;
    map["record"] = record.toMap();

    return map;
  }
}
