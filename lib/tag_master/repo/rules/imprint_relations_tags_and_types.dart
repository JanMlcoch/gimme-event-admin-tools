part of tagMaster2.repo;

///Checks whether all imprint relations have appropriate relations regarding to the definitions of their types.
class ImprintRelationsHaveAppropriateTagsAndTagTypes extends TagMasterRepositoryRule{
  static const String onFailure = "Some imprint relation relates to inapropriate tag types";

  ImprintRelationsHaveAppropriateTagsAndTagTypes() : super(_doImprintRelationsHaveAppropriateTagsAndTagTypes, onFailure);

  ///Checks whether all imprint relations have appropriate relations regarding to the definitions of their types.
  static bool _doImprintRelationsHaveAppropriateTagsAndTagTypes(TagMasterRepository repo) {
    List<Relation> imprintRelations = repo.relations.where((r) => r.type == RelationSubstance.IMPRINT).toList();

    bool imprintRelationTest(Relation relation) {
      for (int tagId in relation.originTagIds) {
        int tagType = repo.getTagById(tagId).tagType;
        if (tagType != Tag.TYPE_SPECIFIC && tagType != Tag.TYPE_CORE) return false;
      }
      int destinationType = repo.getTagById(relation.destinationTagId).tagType;
      if (destinationType != Tag.TYPE_CORE) return false;
      return true;
    }

    imprintRelations.removeWhere(imprintRelationTest);
    return imprintRelations.isEmpty;
  }
}