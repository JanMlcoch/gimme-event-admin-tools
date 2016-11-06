part of tagMaster2;

///Class which instance represent complete output from tagMaster
class TagMasterRepository {
  List<Tag> tags;
  List<Relation> relations;

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

  void fromMap(Map<String, List<Map<String,dynamic>>> map) {
    for (Map<String,dynamic> relationMap in map["relations"]) {
      relations.add(new Relation()..fromMap(relationMap));
    }
    for (Map<String,dynamic> tagMap in map["tags"]) {
      tags.add(new Tag()..fromMap(tagMap));
    }
  }

  ///Validates this instance
  bool validate() {
    if (!validateAtomsLocally()) return false;
    return validateGlobally();
  }

  ///This method returns true or false depending on whether the atomic
  /// [Relation]s and [Tag]s in [relations] and [tags] are valid as standalones.
  bool validateAtomsLocally() {
    for (Tag tag in tags) {
      if (!tag.validateLocally()) {
        print("Loacl validation of tag with id ${tag.tagId} failed");
        return false;
      }
    }
    for (Relation relation in relations) {
      if (!relation.validateLocally()) {
        print(
            "Local validation of relation leading from ${relation.originTagIds} to ${relation.destinationTagId} failed");
      }
    }
    return true;
  }

  ///validates global relationships between [Relation]s and [Tag]s in [relations] and [tags].
  bool validateGlobally() {
    //todo: implement
    return false;
  }
}
