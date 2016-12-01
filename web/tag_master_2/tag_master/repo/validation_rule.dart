part of tagMaster2.repo;

class TagMasterRepositoryRule {
  RepoTest repositoryTest;
  String onInvalidMessage;

  TagMasterRepositoryRule(this.repositoryTest, this.onInvalidMessage);

  factory TagMasterRepositoryRule.uniqueTagIds() => new UniqueTagIds();
  factory TagMasterRepositoryRule.uniqueTagNames() => new UniqueTagNames();
  ///tests whether there are or are not two [Relation]s with the same origin and destination tags
  factory TagMasterRepositoryRule.uniqueRelation() => new UniqueRelations();
  factory TagMasterRepositoryRule.relationTagsExists() => new RelationTagsExists();
  ///finds out whether or not do synonym tags have appropriate relations regarding to the definitions of their types.
  factory TagMasterRepositoryRule.synonymsHaveAppropriateRelation() => new SynonymsHaveAppropriateRelations();
  ///finds out whether or not do custom tags have appropriate relations regarding to the definitions of their types.
  factory TagMasterRepositoryRule.customTagsHaveAppropriateRelation() => new CustomTagsHaveAppropriateRelations();
  ///finds out whether or not do composite tags have appropriate relations regarding to the definitions of their types.
  factory TagMasterRepositoryRule.compositeTagsHaveAppropriateRelation() => new CompositeTagsHaveAppropriateRelations();
  ///finds out whether or not do specific tags have appropriate relations regarding to the definitions of their types.
  factory TagMasterRepositoryRule.specificTagsHaveAppropriateRelation() => new SpecificTagsHaveAppropriateRelations();
  ///finds out whether or not do core tags have appropriate relations regarding to the definitions of their types.
  factory TagMasterRepositoryRule.coreTagsHaveAppropriateRelation() => new CoreTagsHaveAppropriateRelations();
  ///Checks whether all synonym relations have appropriate relations regarding to the definitions of their types.
  factory TagMasterRepositoryRule.synonymRelationsHaveAppropriateTagsAndTagTypes() => new SynonymRelationsHaveAppropriateTagsAndTagTypes();
  ///Checks whether all composite relations have appropriate relations regarding to the definitions of their types.
  factory TagMasterRepositoryRule.compositeRelationsHaveAppropriateTagsAndTagTypes() => new CompositeRelationsHaveAppropriateTagsAndTagTypes();
  ///Checks whether all imprint relations have appropriate relations regarding to the definitions of their types.
  factory TagMasterRepositoryRule.imprintRelationsHaveAppropriateTagsAndTagTypes() => new ImprintRelationsHaveAppropriateTagsAndTagTypes();
}
