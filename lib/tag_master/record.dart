part of tagMaster2;

///instance of [Record] represents atomic difference between [TagMasterRepository]s.
class Record {
  int userId;
  Tag tag;
  Relation relation;

  ///Creates instance of [Record] representing tag operation
  Record.recordTag(this.userId, this.tag);

  ///Creates instance of [Record] representing relation operation
  Record.recordRelation(this.userId, this.relation);

  void fromMap(Map<String, dynamic> map) {
    userId = map["userId"];
    var tagMap = map["tag"];
    if (tagMap is Map<String, dynamic>) {
      tag = new Tag()..fromMap(tagMap);
    }
    var relationMap = map["relation"];
    if (relationMap is Map<String, dynamic>) {
      relation = new Relation()..fromMap(relationMap);
    }
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};

    map["userId"] = userId;
    map["tag"] = tag.toMap();
    map["relation"] = relation.toMap();

    return map;
  }

  bool isInConflictWith(Record record) {
    if ((tag == null) == (record.relation == null)) return false;
    if (tag == null) {
      return relation.hasEquivalentTags(record.relation);
    } else {
      return tag.tagId == record.tag.tagId;
    }
  }
}
