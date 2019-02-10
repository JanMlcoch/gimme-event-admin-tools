part of test.tag_master_2;

void synonymsHaveRelationsTests() {
  test("Test of only_synonym_tag repo synonyms-have-appr.-relation validity", () {
    bool isValid = repoOnlySynonymTag.validate(rules: [new TagMasterRepositoryRule.synonymsHaveAppropriateRelation()]);
    expect(isValid, equals(false));
  });

  test("Test of synonym pointing itself repo synonyms having appropriate relation validity", () {
    bool isValid =
        repoSynonymPointingItself.validate(rules: [new TagMasterRepositoryRule.synonymsHaveAppropriateRelation()]);
    expect(isValid, equals(false));
  });

  test("Test of synonym pointing each other repo synonyms having appropriate relation validity", () {
    bool isValid =
        repoSynonymsPointingEachOther.validate(rules: [new TagMasterRepositoryRule.synonymsHaveAppropriateRelation()]);
    expect(isValid, equals(false));
  });

  test("Test of synonym pointing custom repo validity", () {
    bool isValid =
        repoSynonymPointingCustomTag.validate(rules: [new TagMasterRepositoryRule.synonymsHaveAppropriateRelation()]);
    expect(isValid, equals(true));
  });

  test("Test of synonym pointing custom repo synonyms having appropriate relation validity", () {
    bool isValid =
        repoSynonymPointingCustomTag.validate(rules: [new TagMasterRepositoryRule.synonymsHaveAppropriateRelation()]);
    expect(isValid, equals(true));
  });

  test("Test of synonym pointing composite repo synonyms having appropriate relation validity", () {
    bool isValid = repoSynonymPointingCompositeTag
        .validate(rules: [new TagMasterRepositoryRule.synonymsHaveAppropriateRelation()]);
    expect(isValid, equals(true));
  });

  test("Test of synonym pointing composite repo synonym relations having appropriate tag types validity", () {
    bool isValid = repoSynonymPointingCompositeTag
        .validate(rules: [new TagMasterRepositoryRule.synonymRelationsHaveAppropriateTagsAndTagTypes()]);
    expect(isValid, equals(true));
  });
  test("Test of synonym pointing specific repo synonyms having appropriate relation validity", () {
    bool isValid =
        repoSynonymPointingSpecificTag.validate(rules: [new TagMasterRepositoryRule.synonymsHaveAppropriateRelation()]);
    expect(isValid, equals(true));
  });

  test("Test of synonym pointing core repo synonyms having appropriate relation validity", () {
    bool isValid =
        repoSynonymPointingCoreTag.validate(rules: [new TagMasterRepositoryRule.synonymsHaveAppropriateRelation()]);
    expect(isValid, equals(true));
  });

  test("Test of synonym pointing with composite relation repo synonyms having appropriate relation validity", () {
    bool isValid = repoSynonymPointingWithCompositeRelation
        .validate(rules: [new TagMasterRepositoryRule.synonymsHaveAppropriateRelation()]);
    expect(isValid, equals(false));
  });

  test("Test of synonym pointing with imprint relation repo synonyms having appropriate relation validity", () {
    bool isValid = repoSynonymPointingWithImprintRelation
        .validate(rules: [new TagMasterRepositoryRule.synonymsHaveAppropriateRelation()]);
    expect(isValid, equals(false));
  });

  test("Test of synonymd pointing same tag synonym having relation validity", () {
    bool isValid =
        repoSynonymsPointingSameTag.validate(rules: [new TagMasterRepositoryRule.synonymsHaveAppropriateRelation()]);
    expect(isValid, equals(true));
  });

}
