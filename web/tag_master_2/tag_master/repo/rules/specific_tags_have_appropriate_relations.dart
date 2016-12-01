part of tagMaster2.repo;

///finds out whether or not do specific tags have appropriate relations regarding to the definitions of their types.
class SpecificTagsHaveAppropriateRelations extends TagMasterRepositoryRule{
  static const String onFailure = "Some specific tag does not have appropriate relations";

  SpecificTagsHaveAppropriateRelations() : super(_doSpecificTagsHaveAppropriateRelations, onFailure);

  ///finds out whether or not do specific tags have appropriate relations regarding to the definitions of their types.
  static bool _doSpecificTagsHaveAppropriateRelations(TagMasterRepository repo) {
    List<Tag> specific = repo.tags.where((Tag tag) => tag.tagType == Tag.TYPE_SPECIFIC).toList();

    bool specificTest(Tag tag) {
      List<Relation> relevantRelations = repo.getRelationsRelevantFor(tag);
      relevantRelations.removeWhere(RepositoryValidator._getSynonymityTest(tag.tagId));
      relevantRelations.removeWhere(RepositoryValidator._getComposityTest(tag.tagId));
      if (relevantRelations.length == 0) return false;
      relevantRelations.removeWhere((Relation relation) {
        return relation.type == RelationSubstance.IMPRINT && relation.originTagIds.contains(tag.tagId);
      });
      return relevantRelations.isEmpty;
    }

    specific.removeWhere(specificTest);
    return specific.isEmpty;
  }
}