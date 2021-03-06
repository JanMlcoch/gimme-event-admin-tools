part of tag_master_2.repo;

///Class which instance represent complete output from tagMaster
class TagMasterRepository {
  List<Tag> tags = [];
  List<Relation> relations = [];

  TagMasterRepository();

  TagMasterRepository.withData(this.tags, this.relations);

  Map<String, List<Map<String, dynamic>>> toMap() {
    Map<String, List<Map<String, dynamic>>> map = {};

    map["relations"] = [];
    for (Relation relation in relations) {
      map["relations"].add(relation.toMap());
    }

    map["tags"] = [];
    for (Tag tag in tags) {
      map["tags"].add(tag.toMap());
    }

    return map;
  }

  void fromMap(Map<String, List<Map<String, dynamic>>> map) {
    for (Map<String, dynamic> relationMap in map["relations"]) {
      if (relations == null) relations = [];
      relations.add(new Relation()..fromMap(relationMap));
    }
    for (Map<String, dynamic> tagMap in map["tags"]) {
      if (tags == null) tags = [];
      tags.add(new Tag()..fromMap(tagMap));
    }
  }

  ///Validates this instance
  bool validate({List<TagMasterRepositoryRule> rules: null}) {
    return RepositoryValidator.validate(this, rules: rules);
  }

  ///This method returns true or false depending on whether the atomic
  /// [Relation]s and [Tag]s in [relations] and [tags] are valid as standalones.
  bool validateAtomsLocally() {
    return RepositoryValidator.validateAtomsLocally(this);
  }

  ///validates global relationships between [Relation]s and [Tag]s in [relations] and [tags].
  bool validateGlobally() {
    return RepositoryValidator.validateGlobally(this);
  }

  ///Returns [Tag] by [Tag.id]. If no tag has desired id, returns null.
  Tag getTagById(int tagId) {
    return tags.firstWhere((t) => t.tagId == tagId, orElse: () => null);
  }

  ///Returns [List] of all [Relation]s that originates or destinates at [Tag] [tag]
  List<Relation> getRelationsRelevantFor(Tag tag) {
    List<Relation> relevantRelations = [];
    for (Relation relation in relations) {
      if (relation.destinationTagId == tag.tagId || relation.originTagIds.contains(tag.tagId))
        relevantRelations.add(relation);
    }
    return relevantRelations;
  }

  int getLowestUnusedTagId() {
    int currentMax = -1;
    List<int> freeIdsLowerThanCurrentMax = [];
    for (Tag tag in tags) {
      int id = tag.tagId;
      while(id > currentMax){
        currentMax++;
        freeIdsLowerThanCurrentMax.add(currentMax);
      }
      freeIdsLowerThanCurrentMax.remove(id);
    }
    if(freeIdsLowerThanCurrentMax.isEmpty){
      return currentMax+1;
    }
    else{
      return freeIdsLowerThanCurrentMax.reduce((a,b)=>min(a,b));
    }
  }

  TagMasterRepository copy(){
    return new TagMasterRepository()..fromMap(toMap());
  }
}
