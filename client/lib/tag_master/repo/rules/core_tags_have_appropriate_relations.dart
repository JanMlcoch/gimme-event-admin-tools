part of tagMaster2.repo;

///finds out whether or not do core tags have appropriate relations regarding to the definitions of their types.
class CoreTagsHaveAppropriateRelations extends TagMasterRepositoryRule{
  static const String onFailure = "Some core tag does not have appropriate relations";

  CoreTagsHaveAppropriateRelations() : super(_doCoreTagsHaveAppropriateRelations, onFailure);

  ///finds out whether or not do core tags have appropriate relations regarding to the definitions of their types.
  static bool _doCoreTagsHaveAppropriateRelations(TagMasterRepository repo) {
    List<Tag> core = repo.tags.where((Tag tag) => tag.tagType == Tag.TYPE_CORE).toList();

    bool coreTest(Tag tag) {
      List<Relation> relevantRelations = repo.getRelationsRelevantFor(tag);
      relevantRelations.removeWhere(RepositoryValidator._getSynonymityTest(tag.tagId));
      relevantRelations.removeWhere(RepositoryValidator._getComposityTest(tag.tagId));
      if (relevantRelations.length == 0) return false;
      if (relevantRelations
          .where((r) => r.type == RelationSubstance.IMPRINT)
          .toList()
          .where((r) => r.destinationTagId == tag.tagId)
          .isEmpty) return false;
      relevantRelations.removeWhere((r) => r.type == RelationSubstance.IMPRINT);
      return relevantRelations.isEmpty;
    }

    core.removeWhere(coreTest);
    return core.isEmpty;
  }
}