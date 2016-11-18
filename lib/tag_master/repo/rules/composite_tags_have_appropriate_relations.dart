part of tagMaster2.repo;

///finds out whether or not do composite tags have appropriate relations regarding to the definitions of their types.
class CompositeTagsHaveAppropriateRelations extends TagMasterRepositoryRule{
  static const String onFailure = "Some composite tag does not have appropriate relations";

  CompositeTagsHaveAppropriateRelations() : super(_doCompositeTagsHaveAppropriateRelations, onFailure);

  ///finds out whether or not do composite tags have appropriate relations regarding to the definitions of their types.
  static bool _doCompositeTagsHaveAppropriateRelations(TagMasterRepository repo) {
    List<Tag> composite = repo.tags.where((Tag tag) => tag.tagType == Tag.TYPE_COMPOSITE).toList();

    bool compositeTest(Tag tag) {
      List<Relation> relevantRelations = repo.getRelationsRelevantFor(tag);
      relevantRelations.removeWhere(RepositoryValidator._getSynonymityTest(tag.tagId));
      if (relevantRelations.length == 0) return false;
      relevantRelations.removeWhere((Relation relation) {
        return relation.type == RelationSubstance.COMPOSITE && relation.originTagIds == [tag.tagId];
      });
      return relevantRelations.isEmpty;
    }

    composite.removeWhere(compositeTest);
    return composite.isEmpty;
  }
}