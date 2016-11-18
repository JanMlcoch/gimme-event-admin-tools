part of tagMaster2;

///Class which instance represent complete output from tagMaster
class TagMasterRepository {
  List<Tag> tags;
  List<Relation> relations;

  Map<String, List<Map<String, dynamic>>> toMap() {
    Map<String, dynamic> map = {};

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

  void fromMap(Map<String, dynamic> map) {
    for (Map relationMap in map["relations"]) {
      if(relations == null)relations = [];
      relations.add(new Relation()..fromMap(relationMap));
    }
    for (Map tagMap in map["tags"]) {
      if(tags == null)tags = [];
      tags.add(new Tag()..fromMap(tagMap));
    }
  }

  ///Validates this instance
  bool validate() {
    return RepositoryValidator.validate(this);
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

  Tag getTagById(int tagId) {
    return tags.firstWhere((t) => t.tagId == tagId);
  }

  List<Relation> getRelationsRelevantFor(Tag tag) {
    List<Relation> relevantRelations = [];
    for (Relation relation in relations) {
      if (relation.destinationTagId == tag.tagId || relation.originTagIds.contains(tag.tagId))
        relevantRelations.add(relation);
    }
    return relevantRelations;
  }
}