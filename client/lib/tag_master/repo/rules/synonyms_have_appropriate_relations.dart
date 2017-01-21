part of tagMaster2.repo;

///finds out whether or not do synonym tags have appropriate relations regarding to the definitions of their types.
class SynonymsHaveAppropriateRelations extends TagMasterRepositoryRule{
  static const String onFailure = "Some synonym tag does not have appropriate relations";

  SynonymsHaveAppropriateRelations() : super(_doSynonymsHaveAppropriateRelations, onFailure);

  ///finds out whether or not do synonym tags have appropriate relations regarding to the definitions of their types.
  static bool _doSynonymsHaveAppropriateRelations(TagMasterRepository repo) {
    List<Tag> synonyms = repo.tags.where((Tag tag) => tag.tagType == Tag.TYPE_SYNONYM).toList();

    bool synonymTest(Tag tag) {
      List<Relation> relevantRelations = repo.getRelationsRelevantFor(tag);
      if (relevantRelations.length != 1) return false;
      if (relevantRelations[0].type != RelationSubstance.SYNONYM) return false;
      if (relevantRelations[0].originTagIds.length != 1) return false;
      if (relevantRelations[0].originTagIds[0] != tag.tagId) return false;
      if (relevantRelations[0].destinationTagId == tag.tagId) return false;
      return true;
    }

    synonyms.removeWhere(synonymTest);
    return synonyms.isEmpty;
  }
}