part of tag_master_2.repo;

///Checks whether all synonym relations have appropriate relations regarding to the definitions of their types.
class SynonymRelationsHaveAppropriateTagsAndTagTypes extends TagMasterRepositoryRule{
  static const String onFailure = "Some synonym relation relates to inapropriate tag types";

  SynonymRelationsHaveAppropriateTagsAndTagTypes() : super(_doSynonymRelationsHaveAppropriateTagsAndTagTypes, onFailure);

  ///Checks whether all synonym relations have appropriate relations regarding to the definitions of their types.
  static bool _doSynonymRelationsHaveAppropriateTagsAndTagTypes(TagMasterRepository repo) {
    List<Relation> synonymRelations = repo.relations.where((r) => r.type == RelationSubstance.SYNONYM).toList();

    bool synonymRelationTest(Relation relation) {
      if (relation.originTagIds.length != 1) return false;
      if (repo.getTagById(relation.originTagIds[0])?.tagType != Tag.TYPE_SYNONYM) return false;
      if (repo.getTagById(relation.destinationTagId)?.tagType == Tag.TYPE_SYNONYM) return false;
      return true;
    }

    synonymRelations.removeWhere(synonymRelationTest);
    return synonymRelations.isEmpty;
  }
}