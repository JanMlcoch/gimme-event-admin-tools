part of test.tagMaster2;

TagMasterRepository emptyRepo = new TagMasterRepository.withData([], []);

TagMasterRepository repoWithOnlyNullTag = new TagMasterRepository.withData([null], []);
TagMasterRepository repoWithOnlyNullRelation = new TagMasterRepository.withData([], [null]);
TagMasterRepository repoWithOnlyNullTags = new TagMasterRepository.withData([null, null], []);
TagMasterRepository repoWithOnlyNullRelations = new TagMasterRepository.withData([], [null, null]);
TagMasterRepository repoWithOnlyNullRelationOnlyNullTag = new TagMasterRepository.withData([null], [null]);
TagMasterRepository repoWithOnlyNullRelationOnlyNullTags = new TagMasterRepository.withData([null, null], [null]);
TagMasterRepository repoWithOnlyNullRelationsOnlyNullTag = new TagMasterRepository.withData([null], [null, null]);
TagMasterRepository repoWithOnlyNullRelationsOnlyNullTags =
    new TagMasterRepository.withData([null, null], [null, null]);

TagMasterRepository repoOnlySynonymTag = new TagMasterRepository.withData([new Tag.synonym(0, "customTag", 0)], []);
TagMasterRepository repoOnlyCustomTag = new TagMasterRepository.withData([new Tag.custom(0, "customTag", 0)], []);
TagMasterRepository repoOnlyCompositeTag = new TagMasterRepository.withData([new Tag.composite(0, "customTag", 0)], []);
TagMasterRepository repoOnlySpecificTag = new TagMasterRepository.withData([new Tag.specific(0, "customTag", 0)], []);
TagMasterRepository repoOnlyCoreTag = new TagMasterRepository.withData([new Tag.core(0, "customTag", 0)], []);

TagMasterRepository validRepoWithAdditionalNullTag =
    new TagMasterRepository.withData([new Tag.custom(0, "customTag", 0), null], []);

TagMasterRepository repoSynonymPointingItself = new TagMasterRepository.withData([
  new Tag.synonym(0, "synonym", 0),
], [
  new Relation.synonym([0], 0)
]);

TagMasterRepository repoSynonymsPointingEachOther = new TagMasterRepository.withData([
  new Tag.synonym(0, "synonym1", 0),
  new Tag.synonym(1, "synonym2", 0),
], [
  new Relation.synonym([1], 0),
  new Relation.synonym([0], 1),
]);

TagMasterRepository repoSynonymPointingCustomTag = new TagMasterRepository.withData([
  new Tag.synonym(0, "synonym", 0),
  new Tag.custom(1, "custom", 0),
], [
  new Relation.synonym([0], 1),
]);

TagMasterRepository repoSynonymPointingCompositeTag = new TagMasterRepository.withData([
  new Tag.synonym(0, "synonym", 0),
  new Tag.composite(1, "composite", 0),
], [
  new Relation.synonym([0], 1),
]);

TagMasterRepository repoSynonymPointingSpecificTag = new TagMasterRepository.withData([
  new Tag.synonym(0, "synonym", 0),
  new Tag.specific(1, "specific", 0),
], [
  new Relation.synonym([0], 1),
]);

TagMasterRepository repoSynonymPointingCoreTag = new TagMasterRepository.withData([
  new Tag.synonym(0, "synonym", 0),
  new Tag.core(1, "core", 0),
], [
  new Relation.synonym([0], 1),
]);

TagMasterRepository repoSynonymPointingWithCompositeRelation = new TagMasterRepository.withData([
  new Tag.synonym(0, "synonym", 0),
  new Tag.custom(1, "custom", 0),
], [
  new Relation.composite([0], 1, 0.5),
]);

TagMasterRepository repoSynonymPointingWithImprintRelation = new TagMasterRepository.withData([
  new Tag.synonym(0, "synonym", 0),
  new Tag.custom(1, "custom", 0),
], [
  new Relation.imprint([0], 1, new ImprintPoint()),
]);
