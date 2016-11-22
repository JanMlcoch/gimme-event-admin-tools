part of test.tagMaster2;

void synonymRelationsHaveAppropriateTagsAndTagTypesTests() {
  test("Test of synonym pointing itself repo default validity", () {
    bool isValid = repoSynonymPointingItself
        .validate(rules: [new TagMasterRepositoryRule.synonymRelationsHaveAppropriateTagsAndTagTypes()]);
    expect(isValid, equals(false));
  });

  test("Test of synonym pointing itself repo synonym relations having appropriate tag types validity", () {
    bool isValid = repoSynonymPointingItself
        .validate(rules: [new TagMasterRepositoryRule.synonymRelationsHaveAppropriateTagsAndTagTypes()]);
    expect(isValid, equals(false));
  });

  test("Test of synonym pointing each other repo tagsAndTyps validity", () {
    bool isValid = repoSynonymsPointingEachOther
        .validate(rules: [new TagMasterRepositoryRule.synonymRelationsHaveAppropriateTagsAndTagTypes()]);
    expect(isValid, equals(false));
  });

  test("Test of synonym pointing custom repo synonym relations having appropriate tag types validity", () {
    bool isValid = repoSynonymPointingCustomTag
        .validate(rules: [new TagMasterRepositoryRule.synonymRelationsHaveAppropriateTagsAndTagTypes()]);
    expect(isValid, equals(true));
  });

  test("Test of synonym pointing composite repo synonym relations having appropriate tag types validity", () {
    bool isValid = repoSynonymPointingCompositeTag
        .validate(rules: [new TagMasterRepositoryRule.synonymRelationsHaveAppropriateTagsAndTagTypes()]);
    expect(isValid, equals(true));
  });

  test("Test of synonym pointing specific repo synonym relations having appropriate tag types validity", () {
    bool isValid = repoSynonymPointingSpecificTag
        .validate(rules: [new TagMasterRepositoryRule.synonymRelationsHaveAppropriateTagsAndTagTypes()]);
    expect(isValid, equals(true));
  });

  test("Test of synonym pointing core repo synonym relations having appropriate tag types validity", () {
    bool isValid = repoSynonymPointingCoreTag
        .validate(rules: [new TagMasterRepositoryRule.synonymRelationsHaveAppropriateTagsAndTagTypes()]);
    expect(isValid, equals(true));
  });

  test("Test of synonym pointing same tag tags&types validity", () {
    bool isValid = repoSynonymsPointingSameTag
        .validate(rules: [new TagMasterRepositoryRule.synonymRelationsHaveAppropriateTagsAndTagTypes()]);
    expect(isValid, equals(true));
  });


  test("Test of synonym pointing nonexistent tag synonym having relation validity stability", () {
    bool isValid =
    synonymPointingNonexistentTag.validate(rules: [new TagMasterRepositoryRule.synonymRelationsHaveAppropriateTagsAndTagTypes()]);
    expect(true, equals(true));
  });

  test("Test of nonexistent synonym pointing tag synonym having relation validity stability", () {
    bool isValid =
    nonexistentSynonymPointing.validate(rules: [new TagMasterRepositoryRule.synonymRelationsHaveAppropriateTagsAndTagTypes()]);
    expect(true, equals(true));
  });

  test("Test of custom tag pointing as synonym - synonym having relation validity", () {
    bool isValid =
    customPointingAsSynonym.validate(rules: [new TagMasterRepositoryRule.synonymRelationsHaveAppropriateTagsAndTagTypes()]);
    expect(isValid, equals(false));
  });

  test("Test of composite tag pointing as synonym - synonym having relation validity", () {
    bool isValid =
    compositePointingAsSynonym.validate(rules: [new TagMasterRepositoryRule.synonymRelationsHaveAppropriateTagsAndTagTypes()]);
    expect(isValid, equals(false));
  });

  test("Test of specific tag pointing as synonym - synonym having relation validity", () {
    bool isValid =
    specificPointingAsSynonym.validate(rules: [new TagMasterRepositoryRule.synonymRelationsHaveAppropriateTagsAndTagTypes()]);
    expect(isValid, equals(false));
  });

  test("Test of core tag pointing as synonym - synonym having relation validity", () {
    bool isValid =
    corePointingAsSynonym.validate(rules: [new TagMasterRepositoryRule.synonymRelationsHaveAppropriateTagsAndTagTypes()]);
    expect(isValid, equals(false));
  });

  test("Test of two synonyms pointing as synonym - synonym having relation validity", () {
    bool isValid =
    twoSynonymsPointingAsSynonym.validate(rules: [new TagMasterRepositoryRule.synonymRelationsHaveAppropriateTagsAndTagTypes()]);
    expect(isValid, equals(false));
  });
}
