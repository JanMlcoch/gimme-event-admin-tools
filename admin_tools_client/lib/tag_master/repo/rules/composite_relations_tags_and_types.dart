part of tag_master_2.repo;

///Checks whether all composite relations have appropriate relations regarding to the definitions of their types.
class CompositeRelationsHaveAppropriateTagsAndTagTypes extends TagMasterRepositoryRule{
  static const String onFailure = "Some composite relation relates to inapropriate tag types";

  CompositeRelationsHaveAppropriateTagsAndTagTypes() : super(_doCompositeRelationsHaveAppropriateTagsAndTagTypes, onFailure);

  ///Checks whether all composite relations have appropriate relations regarding to the definitions of their types.
  static bool _doCompositeRelationsHaveAppropriateTagsAndTagTypes(TagMasterRepository repo) {
    List<Relation> compositeRelations = repo.relations.where((r) => r.type == RelationSubstance.COMPOSITE).toList();

    bool compositeRelationTest(Relation relation) {
      //todo: again, is this necessary?
      if (relation.originTagIds.length != 1) return false;
      if (repo.getTagById(relation.originTagIds[0]).tagType != Tag.TYPE_COMPOSITE) return false;
      int destinationType = repo.getTagById(relation.destinationTagId)?.tagType;
      if(destinationType==null)return false;
      if (destinationType != Tag.TYPE_SPECIFIC && destinationType != Tag.TYPE_CORE) return false;
      return true;
    }

    compositeRelations.removeWhere(compositeRelationTest);
    return compositeRelations.isEmpty;
  }
}