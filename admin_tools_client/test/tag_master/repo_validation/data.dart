part of test.tag_master_2;

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

TagMasterRepository repoOnlyEmptyTag = new TagMasterRepository.withData([new Tag()],[]);
TagMasterRepository repoOnlyTagNullId = new TagMasterRepository.withData([new Tag.custom(null, "tag", 0)],[]);
TagMasterRepository repoOnlyTagNullName = new TagMasterRepository.withData([new Tag.custom(0, null, 0)],[]);
TagMasterRepository repoOnlyTagNullAuthor = new TagMasterRepository.withData([new Tag.custom(0, "tag", null)],[]);
TagMasterRepository repoOnlyTagNullLang = new TagMasterRepository.withData([new Tag.custom(0, "tag", 0, lang: null)],[]);
TagMasterRepository repoOnlyEmptyRelation = new TagMasterRepository.withData([],[new Relation()]);
TagMasterRepository repoOnlyRelationNullOriginTags = new TagMasterRepository.withData([],[new Relation.composite(null,0,0.5)]);
TagMasterRepository repoOnlyRelationOriginTagsWithOnlyNull = new TagMasterRepository.withData([],[new Relation.composite([null],0,0.5)]);
TagMasterRepository repoOnlyRelationOriginTagsWithNotOnlyNull = new TagMasterRepository.withData([],[new Relation.composite([null,0],0,0.5)]);
TagMasterRepository repoOnlyRelationPointingNull = new TagMasterRepository.withData([],[new Relation.composite([0],null,0.5)]);
TagMasterRepository repoOnlyCompositeRelationWithNullStrength = new TagMasterRepository.withData([],[new Relation.composite([0],0,null)]);
TagMasterRepository repoOnlyImprintRelationWithNullPoint = new TagMasterRepository.withData([],[new Relation.imprint([0],0,null)]);

TagMasterRepository repoOnlySynonymTag = new TagMasterRepository.withData([new Tag.synonym(0, "customTag", 0)], []);
TagMasterRepository repoOnlyCustomTag = new TagMasterRepository.withData([new Tag.custom(0, "customTag", 0)], []);
TagMasterRepository repoOnlyCompositeTag = new TagMasterRepository.withData([new Tag.composite(0, "customTag", 0)], []);
TagMasterRepository repoOnlySpecificTag = new TagMasterRepository.withData([new Tag.specific(0, "customTag", 0)], []);
TagMasterRepository repoOnlyCoreTag = new TagMasterRepository.withData([new Tag.core(0, "customTag", 0)], []);

TagMasterRepository emptyOriginTagsSynonym = new TagMasterRepository.withData([],[new Relation.synonym([],1)]);
TagMasterRepository emptyOriginTagsComposite = new TagMasterRepository.withData([],[new Relation.composite([],1,0.5)]);
TagMasterRepository emptyOriginTagsImprint = new TagMasterRepository.withData([],[new Relation.imprint([],1, new ImprintPoint())]);

TagMasterRepository ternaryRelationWithOneMissingOriginTag = new TagMasterRepository.withData([new Tag.core(0,"0",0)],[new Relation.imprint([0,1],0,new ImprintPoint())]);

TagMasterRepository validRepoWithAdditionalNullTag = new TagMasterRepository.withData([new Tag.custom(0, "customTag", 0), null], []);

TagMasterRepository validRepoWithAdditionalNullRelation = new TagMasterRepository.withData([
  new Tag.custom(0, "customTag", 0),
  new Tag.synonym(1, "synonym", 0)
], [
  new Relation.synonym([1], 0),
  null
]);

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

TagMasterRepository repoSynonymsPointingSameTag = new TagMasterRepository.withData([
  new Tag.synonym(0, "synonym", 0),
  new Tag.synonym(1, "synonym2", 0),
  new Tag.custom(2, "custom", 0),
], [
  new Relation.synonym([0], 2),
  new Relation.synonym([1], 2),
]);

TagMasterRepository synonymPointingNonexistentTag = new TagMasterRepository.withData([new Tag.synonym(0,"synonym",0)],[new Relation.synonym([0],1)]);
TagMasterRepository nonexistentSynonymPointing = new TagMasterRepository.withData([new Tag.core(1,"core",0)],[new Relation.synonym([0],1)]);
TagMasterRepository customPointingAsSynonym = new TagMasterRepository.withData([new Tag.custom(0,"imposter",0),new Tag.core(1,"core",0)],[new Relation.synonym([0],1)]);
TagMasterRepository compositePointingAsSynonym = new TagMasterRepository.withData([new Tag.composite(0,"imposter",0),new Tag.core(1,"core",0)],[new Relation.synonym([0],1)]);
TagMasterRepository specificPointingAsSynonym = new TagMasterRepository.withData([new Tag.specific(0,"imposter",0),new Tag.core(1,"core",0)],[new Relation.synonym([0],1)]);
TagMasterRepository corePointingAsSynonym = new TagMasterRepository.withData([new Tag.core(0,"imposter",0),new Tag.core(1,"core",0)],[new Relation.synonym([0],1)]);
TagMasterRepository twoSynonymsPointingAsSynonym = new TagMasterRepository.withData([new Tag.synonym(0,"synonym0",0),new Tag.synonym(1,"synonym1",0),new Tag.core(2,"core",0)],[new Relation.synonym([0,1],2)]);

TagMasterRepository repoOnlyCustomTags =
    new TagMasterRepository.withData([new Tag.custom(0, "custom0", 0), new Tag.custom(1, "custom1", 0)], []);

TagMasterRepository repoCustomsWithRelation = new TagMasterRepository.withData([
  new Tag.custom(0, "custom0", 0),
  new Tag.custom(1, "custom1", 0)
], [
  new Relation.synonym([0], 1)
]);

TagMasterRepository repoWithTwoSameTags =
    new TagMasterRepository.withData([new Tag.custom(0, "custom0", 0), new Tag.custom(0, "custom0", 0)], []);

TagMasterRepository repoWithTwoSameAndOneDifferentTags = new TagMasterRepository.withData(
    [new Tag.custom(0, "custom0", 0), new Tag.custom(0, "custom0", 0), new Tag.custom(1, "custom1", 0)], []);

TagMasterRepository onlyDuplicitSelfPointingBinaryRelation = new TagMasterRepository.withData([], [
  new Relation.composite([0], 0, 0.2),
  new Relation.composite([0], 0, 0.2),
]);

TagMasterRepository onlyDuplicitBinaryRelation = new TagMasterRepository.withData([], [
  new Relation.composite([0], 1, 0.2),
  new Relation.composite([0], 1, 0.2),
]);

TagMasterRepository onlyDuplicitTernaryRelation = new TagMasterRepository.withData([], [
  new Relation.composite([0,1], 1, 0.2),
  new Relation.composite([0,1], 1, 0.2),
]);


TagMasterRepository onlyDuplicitTernaryRelationWithDifferentStrength = new TagMasterRepository.withData([], [
  new Relation.composite([0,1], 1, 0.2),
  new Relation.composite([0,1], 1, 0.2),
]);

///___________________________
///
TagMasterRepository repoWithCompositeTagPointingSpecific = new TagMasterRepository.withData([
  new Tag.composite(0, "composite", 0),
  new Tag.specific(1, "specific", 0)
], [
  new Relation.composite([0], 1, 1.0)
]);

TagMasterRepository repoWithTwoCompositeTagsPointingSpecificSeparately = new TagMasterRepository.withData([
  new Tag.composite(0, "composite", 0),
  new Tag.composite(2, "composite2", 0),
  new Tag.specific(1, "specific", 0)
], [
  new Relation.composite([0], 1, 1.0),
  new Relation.composite([2], 1, 1.0)
]);

TagMasterRepository repoWithTwoCompositeTagsPointingSpecificTogether = new TagMasterRepository.withData([
  new Tag.composite(0, "composite", 0),
  new Tag.composite(2, "composite2", 0),
  new Tag.specific(1, "specific", 0)
], [
  new Relation.composite([0, 2], 1, 1.0)
]);

TagMasterRepository repoWithTwoCompositeTagsPointingSpecificTogetherAndSeparately = new TagMasterRepository.withData([
  new Tag.composite(0, "composite", 0),
  new Tag.composite(2, "composite2", 0),
  new Tag.specific(1, "specific", 0)
], [
  new Relation.composite([0, 2], 1, 1.0),
  new Relation.composite([0], 1, 1.0),
  new Relation.composite([2], 1, 1.0),
]);

//_______________________________________

TagMasterRepository coreTagsPointingEachOther = new TagMasterRepository.withData([
  new Tag.core(0, "0", 0),
  new Tag.core(1, "1", 0)
], [
  new Relation.imprint([0], 1, new ImprintPoint()),
  new Relation.imprint([1], 0, new ImprintPoint()),
]);

TagMasterRepository coreTagsPointingSameTag = new TagMasterRepository.withData([
  new Tag.core(0, "0", 0),
  new Tag.core(1, "1", 0)
], [
  new Relation.imprint([0], 1, new ImprintPoint()),
  new Relation.imprint([1], 1, new ImprintPoint()),
]);

TagMasterRepository coreTagPointingTwoTags = new TagMasterRepository.withData([
  new Tag.core(0, "0", 0),
  new Tag.core(1, "1", 0)
], [
  new Relation.imprint([0], 1, new ImprintPoint()),
  new Relation.imprint([1], 1, new ImprintPoint()),
]);

TagMasterRepository complete3coreHyperGraph = new TagMasterRepository.withData([
  new Tag.core(0, "0", 0),
  new Tag.core(1, "1", 0),
  new Tag.core(2, "2", 0),
], [
  new Relation.imprint([0], 0, new ImprintPoint()),
  new Relation.imprint([0], 1, new ImprintPoint()),
  new Relation.imprint([0], 2, new ImprintPoint()),
  new Relation.imprint([1], 0, new ImprintPoint()),
  new Relation.imprint([1], 1, new ImprintPoint()),
  new Relation.imprint([1], 2, new ImprintPoint()),
  new Relation.imprint([2], 0, new ImprintPoint()),
  new Relation.imprint([2], 1, new ImprintPoint()),
  new Relation.imprint([2], 2, new ImprintPoint()),
  new Relation.imprint([0, 1], 0, new ImprintPoint()),
  new Relation.imprint([0, 1], 1, new ImprintPoint()),
  new Relation.imprint([0, 1], 2, new ImprintPoint()),
  new Relation.imprint([0, 2], 0, new ImprintPoint()),
  new Relation.imprint([0, 2], 1, new ImprintPoint()),
  new Relation.imprint([0, 2], 2, new ImprintPoint()),
  new Relation.imprint([1, 2], 0, new ImprintPoint()),
  new Relation.imprint([1, 2], 1, new ImprintPoint()),
  new Relation.imprint([1, 2], 2, new ImprintPoint()),
  new Relation.imprint([0, 1, 2], 0, new ImprintPoint()),
  new Relation.imprint([0, 1, 2], 1, new ImprintPoint()),
  new Relation.imprint([0, 1, 2], 2, new ImprintPoint()),
]);
