part of tagMaster2;

class ActionRecord {
  static const String TYPE_BINARY_RELATION = "t1";
  static const String TYPE_TERNARY_RELATION = "t2";
  static const String TYPE_QUATERNARY_RELATION = "t3";
  static const String TYPE_ADD_TAG = "addTag";
  static const String TYPE_REMOVE_TAG = "removeTag";
  static const String TYPE_CHANGE_TAG = "changeTag";

  int id;
  int versionId;
  int userId;
  Record record;
  String type;

  ActionRecord.addTag(this.id, this.versionId, this.userId, Tag tag){
    type = TYPE_ADD_TAG;
    record = new Record.recordTag(userId, tag);
  }

  ActionRecord.removeTag(this.id, this.versionId, this.userId, Tag tag){
    type = TYPE_REMOVE_TAG;
    record = new Record.recordTag(userId, tag);
  }

  ActionRecord.changeTag(this.id, this.versionId, this.userId, Tag tag){
    type = TYPE_CHANGE_TAG;
    record = new Record.recordTag(userId, tag);
  }

  //todo: should this change argument or return copy?
  TagMasterRepository applyOn(TagMasterRepository repo) {
    TagMasterRepository repoCopy = new TagMasterRepository()..fromMap(repo.toMap());
    if (type == TYPE_REMOVE_TAG) {
      repoCopy.tags.remove(repoCopy.getTagById(record.tag.tagId));
    }
    if (type == TYPE_ADD_TAG) {
      repoCopy.tags.add(record.tag);
    }
    if (type == TYPE_CHANGE_TAG) {
      repoCopy.tags.remove(repoCopy.getTagById(record.tag.tagId));
      repoCopy.tags.add(record.tag);
    }
    if (type == TYPE_BINARY_RELATION || type == TYPE_TERNARY_RELATION || type == TYPE_QUATERNARY_RELATION) {
      List<Relation> equivalentRelations = repoCopy.relations.where(record.relation.hasEquivalentTags);
      if(equivalentRelations.isNotEmpty){
        repoCopy.relations.remove(equivalentRelations.first);
      }
      repoCopy.relations.add(record.relation);
    }
    return repoCopy;
  }

  void fromMap(Map<String, dynamic> map) {
    id = map["id"];
    versionId = map["versionId"];
    userId = map["userId"];
    if (map["record"] is Map<String, dynamic>) {
      record = new Record.fromMapConstructor((map["record"]) as Map<String, dynamic>);
    } else {
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
