part of tagMaster2;

///instance of [Record] represents atomic difference between [TagMasterRepository]s.
class Record{
  int userId;
  Tag tag;
  Relation relation;

  ///Creates instance of [Record] representing tag operation
  Record.recordTag(this.userId, this.tag);

  ///Creates instance of [Record] representing relation operation
  Record.recordRelation(this.userId, this.relation);

  Record.fromMapConstructor(Map<String, dynamic> map){
    this.fromMap(map);
  }

  void fromMap(Map<String, dynamic> map){
    userId = map["userId"];
    if(map["tag"] is Map<String, dynamic>)tag = new Tag()..fromMap((map["tag"] as Map<String, dynamic>));
    if(map["relation"] is Map<String, dynamic>)relation = new Relation()..fromMap((map["relation"] as Map<String, dynamic>));
  }

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {};

    map["userId"] = userId;
    map["tag"] = tag.toMap();
    map["relation"] = relation.toMap();

    return map;
  }

  bool isInConflictWith(Record record){
    if((tag == null) == (record.relation == null))return false;
    if(tag == null){
      return relation.hasEquivalentTags(record.relation);
    }
    else{
      return tag.tagId == record.tag.tagId;
    }
  }
}