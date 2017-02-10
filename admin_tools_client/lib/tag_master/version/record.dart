part of tag_master_2.version;

///instance of [Record] represents atomic difference between [TagMasterRepository]s.
class Record{
  Tag tag;
  Relation relation;
  bool isRemoval = false;

  ///Creates instance of [Record] representing tag operation
  Record.recordTag(this.tag);

  ///Creates instance of [Record] representing tag deletion
  Record.removeTag(this.tag){
    isRemoval = true;
  }

  ///Creates instance of [Record] representing relation operation
  Record.recordRelation(this.relation);


  ///Creates instance of [Record] representing relation deletion
  Record.removeRelation(this.relation){
    isRemoval = true;
  }

  Record.fromMapConstructor(Map<String, Map<String,dynamic>> map){
    this.fromMap(map);
  }

  String getType(){
    if(tag != null){
      if(isRemoval){
        return ActionRecord.TYPE_REMOVE_TAG;
      }
      else{
        return ActionRecord.TYPE_CHANGE_TAG;
      }
    }
    if(relation != null){
      if(relation.originTagIds.length == 1)return ActionRecord.TYPE_BINARY_RELATION;
      if(relation.originTagIds.length == 2)return ActionRecord.TYPE_TERNARY_RELATION;
      if(relation.originTagIds.length == 3)return ActionRecord.TYPE_QUATERNARY_RELATION;
      throw new Exception("Too many origin tags to determine valid Record type");
    }
    throw new Exception("This action record is pointless");
  }

  //todo:doc
  TagMasterRepository appliedOn(TagMasterRepository repo) {
    TagMasterRepository repoCopy = new TagMasterRepository()..fromMap(repo.toMap());
    if (getType() == ActionRecord.TYPE_REMOVE_TAG) {
      repoCopy.tags.remove(repoCopy.getTagById(tag.tagId));
    }
//    if (getType() == ActionRecord.TYPE_ADD_TAG) {
//      repoCopy.tags.add(tag);
//    }
    if (getType() == ActionRecord.TYPE_CHANGE_TAG) {
      repoCopy.tags.remove(repoCopy.getTagById(tag.tagId));
      repoCopy.tags.add(tag);
    }
    if (getType() == ActionRecord.TYPE_BINARY_RELATION || getType() == ActionRecord.TYPE_TERNARY_RELATION || getType() == ActionRecord.TYPE_QUATERNARY_RELATION) {
      List<Relation> equivalentRelations = repoCopy.relations.where(relation.hasEquivalentTags).toList();
      if(equivalentRelations.isNotEmpty){
        repoCopy.relations.remove(equivalentRelations.first);
      }
      if(!isRemoval)repoCopy.relations.add(relation);
    }
    return repoCopy;
  }

  //todo: doc
  static List<Record> diff(TagMasterRepository originalRepo, TagMasterRepository finalRepo){
    List<Record> records = [];
    for(Tag originTag in originalRepo.tags){
      Tag finalTag = finalRepo.getTagById(originTag.tagId);
      if(finalTag == null){
        records.add(new Record.removeTag(originTag));
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
      List<Relation> finalRelations = finalRepo.relations.where((Relation r)=>r.hasEquivalentTags(originRelation)).toList();
      if(finalRelations.isEmpty){
        records.add(new Record.removeRelation(originRelation));
        continue;
      }
      if(finalRelations.first.substance.toMap().toString() != originRelation.substance.toMap().toString()){
        records.add(new Record.recordRelation(finalRelations.first));
      }
    }
    for(Relation finalRelation in finalRepo.relations){
      List<Relation> originRelations = originalRepo.relations.where((Relation r)=>r.hasEquivalentTags(finalRelation)).toList();
      if(originRelations.isEmpty){
        records.add(new Record.recordRelation(finalRelation));
        continue;
      }
    }
    return records;
  }

  void fromMap(Map<String, dynamic> map){
    //todo: typecheck
    tag = new Tag()..fromMap(map["tag"] as Map<String,dynamic>);
    relation = new Relation()..fromMap(map["relation"] as Map<String,dynamic>);
    isRemoval = map["isRemoval"];
  }

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {};

    map["tag"] = tag?.toMap();
    map["relation"] = relation?.toMap();
    map["isRemoval"] = isRemoval;

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