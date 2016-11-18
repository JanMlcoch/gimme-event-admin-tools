part of tagMaster2.repo;

///finds out whether or not do custom tags have appropriate relations regarding to the definitions of their types.
class CustomTagsHaveAppropriateRelations extends TagMasterRepositoryRule{
  static const String onFailure = "Some custom tag does not have appropriate relations";

  CustomTagsHaveAppropriateRelations() : super(_doCustomTagsHaveAppropriateRelations, onFailure);

  ///finds out whether or not do custom tags have appropriate relations regarding to the definitions of their types.
  static bool _doCustomTagsHaveAppropriateRelations(TagMasterRepository repo) {
    List<Tag> custom = repo.tags.where((Tag tag) => tag.tagType == Tag.TYPE_CUSTOM).toList();

    bool customTest(Tag tag) {
      List<Relation> relevantRelations = repo.getRelationsRelevantFor(tag);
      relevantRelations.removeWhere(RepositoryValidator._getSynonymityTest(tag.tagId));
      return relevantRelations.isEmpty;
    }

    custom.removeWhere(customTest);
    return custom.isEmpty;
  }
}