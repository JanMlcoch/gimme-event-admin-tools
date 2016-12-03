part of tagMaster2;

///instance of [Record] represents atomic difference between [TagMasterRepository]s.
class Record{
  Tag tag;
  Relation relation;
  bool isRemoval = false;

  ///Creates instance of [Record] representing tag operation
  Record.recordTag(this.tag);

  ///Creates instance of [Record] representing relation operation
  Record.recordRelation(this.relation);

  Record.fromMapConstructor(Map<String, Map<String,dynamic>> map){
    this.fromMap(map);
  }

  static List<Record> diff(TagMasterRepository originalRepo, TagMasterRepository finalRepo){
    List<Record> records = [];
    for(Tag originTag in originalRepo.tags){
      Tag finalTag = finalRepo.getTagById(originTag.tagId);
      if(finalTag == null){
        records.add(new Record.recordTag(originTag)..isRemoval = true);
        continue;
      }
      if(finalTag.toMap().toString() != originTag.toMap().toString()){
        records.add(new Record.recordTag(finalTag));
      }
    }
    for(Tag finalTag in finalRepo.tags){
      if(originalRepo.getTagById(finalTag.tagId)==null){
        records.add(new Record.recordTag(finalTag));
      }
    }
    for(Relation originRelation in originalRepo.relations){
      List<Relation> finalRelations = finalRepo.relations.where((Relation r){r.hasEquivalentTags(originRelation);});
      if(finalRelations.isEmpty){
        records.add(new Record.recordRelation(originRelation)..isRemoval=true);
        continue;
      }
      if(finalRelations.first.substance.toMap().toString() != originRelation.substance.toMap().toString()){
        records.add(new Record.recordRelation(finalRelations.first));
      }
    }
    for(Relation finalRelation in finalRepo.relations){
      List<Relation> originRelations = finalRepo.relations.where((Relation r){r.hasEquivalentTags(finalRelation);});
      if(originRelations.isEmpty){
        records.add(new Record.recordRelation(finalRelation));
        continue;
      }
    }
    return records;
  }

  void fromMap(Map<String, Map<String, dynamic>> map){
    tag = new Tag()..fromMap(map["tag"]);
    relation = new Relation()..fromMap(map["relation"]);
  }

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {};

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