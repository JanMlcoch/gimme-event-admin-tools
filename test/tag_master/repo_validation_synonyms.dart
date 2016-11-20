part of test.tagMaster2;

void tagMasterRepoSynonymValidationTests() {
  test("Test of only_synonym_tag repo default local validity", () {
    bool isValid = repoOnlySynonymTag.validateAtomsLocally();
    expect(true, equals(isValid));
  });

  test("Test of only_synonym_tag repo default validity", () {
    bool isValid = repoOnlySynonymTag.validate();
    expect(false, equals(isValid));
  });

  test("Test of synonym pointing itself repo default local validity", () {
    bool isValid = repoSynonymPointingItself.validateAtomsLocally();
    expect(true, equals(isValid));
  });

  test("Test of synonym pointing itself repo default validity", () {
    bool isValid = repoSynonymPointingItself.validate();
    expect(false, equals(isValid));
  });

  test("Test of synonym pointing itself repo synonyms having appropriate relation validity", () {
    bool isValid =
        repoSynonymPointingItself.validate(rules: [new TagMasterRepositoryRule.synonymsHaveAppropriateRelation()]);
    expect(false, equals(isValid));
  });

  test("Test of synonym pointing itself repo synonym relations having appropriate tag types validity", () {
    bool isValid = repoSynonymPointingItself
        .validate(rules: [new TagMasterRepositoryRule.synonymRelationsHaveAppropriateTagsAndTagTypes()]);
    expect(false, equals(isValid));
  });

  test("Test of synonyms pointing each other repo default local validity", () {
    bool isValid = repoSynonymsPointingEachOther.validateAtomsLocally();
    expect(true, equals(isValid));
  });

  test("Test of synonym pointing each other repo default validity", () {
    bool isValid = repoSynonymsPointingEachOther.validate();
    expect(false, equals(isValid));
  });

  test("Test of synonym pointing each other repo synonyms having appropriate relation validity", () {
    bool isValid =
        repoSynonymsPointingEachOther.validate(rules: [new TagMasterRepositoryRule.synonymsHaveAppropriateRelation()]);
    expect(false, equals(isValid));
  });

  test("Test of synonym pointing each other repo synonym relations having appropriate tag types validity", () {
    bool isValid = repoSynonymsPointingEachOther
        .validate(rules: [new TagMasterRepositoryRule.synonymRelationsHaveAppropriateTagsAndTagTypes()]);
    expect(false, equals(isValid));
  });

  test("Test of synonym pointing custom repo default local validity", () {
    bool isValid = repoSynonymPointingCustomTag.validateAtomsLocally();
    expect(true, equals(isValid));
  });

  test("Test of synonym pointing custom repo default validity", () {
    bool isValid = repoSynonymPointingCustomTag.validate();
    expect(true, equals(isValid));
  });

  test("Test of synonym pointing custom repo synonyms having appropriate relation validity", () {
    bool isValid =
        repoSynonymPointingCustomTag.validate(rules: [new TagMasterRepositoryRule.synonymsHaveAppropriateRelation()]);
    expect(true, equals(isValid));
  });

  test("Test of synonym pointing custom repo synonym relations having appropriate tag types validity", () {
    bool isValid = repoSynonymPointingCustomTag
        .validate(rules: [new TagMasterRepositoryRule.synonymRelationsHaveAppropriateTagsAndTagTypes()]);
    expect(true, equals(isValid));
  });

  test("Test of synonym pointing composite repo default local validity", () {
    bool isValid = repoSynonymPointingCompositeTag.validateAtomsLocally();
    expect(true, equals(isValid));
  });

  test("Test of synonym pointing composite repo default validity", () {
    bool isValid = repoSynonymPointingCompositeTag.validate();
    expect(false, equals(isValid));
  });

  test("Test of synonym pointing composite repo synonyms having appropriate relation validity", () {
    bool isValid = repoSynonymPointingCompositeTag
        .validate(rules: [new TagMasterRepositoryRule.synonymsHaveAppropriateRelation()]);
    expect(true, equals(isValid));
  });

  test("Test of synonym pointing composite repo synonym relations having appropriate tag types validity", () {
    bool isValid = repoSynonymPointingCompositeTag
        .validate(rules: [new TagMasterRepositoryRule.synonymRelationsHaveAppropriateTagsAndTagTypes()]);
    expect(true, equals(isValid));
  });

  test("Test of synonym pointing specific repo default local validity", () {
    bool isValid = repoSynonymPointingSpecificTag.validateAtomsLocally();
    expect(true, equals(isValid));
  });

  test("Test of synonym pointing specific repo default validity", () {
    bool isValid = repoSynonymPointingSpecificTag.validate();
    expect(false, equals(isValid));
  });

  test("Test of synonym pointing specific repo synonyms having appropriate relation validity", () {
    bool isValid =
        repoSynonymPointingSpecificTag.validate(rules: [new TagMasterRepositoryRule.synonymsHaveAppropriateRelation()]);
    expect(true, equals(isValid));
  });

  test("Test of synonym pointing specific repo synonym relations having appropriate tag types validity", () {
    bool isValid = repoSynonymPointingSpecificTag
        .validate(rules: [new TagMasterRepositoryRule.synonymRelationsHaveAppropriateTagsAndTagTypes()]);
    expect(true, equals(isValid));
  });

  test("Test of synonym pointing core repo default local validity", () {
    bool isValid = repoSynonymPointingCoreTag.validateAtomsLocally();
    expect(true, equals(isValid));
  });

  test("Test of synonym pointing core repo default validity", () {
    bool isValid = repoSynonymPointingCoreTag.validate();
    expect(false, equals(isValid));
  });

  test("Test of synonym pointing core repo synonyms having appropriate relation validity", () {
    bool isValid =
        repoSynonymPointingCoreTag.validate(rules: [new TagMasterRepositoryRule.synonymsHaveAppropriateRelation()]);
    expect(true, equals(isValid));
  });

  test("Test of synonym pointing core repo synonym relations having appropriate tag types validity", () {
    bool isValid = repoSynonymPointingCoreTag
        .validate(rules: [new TagMasterRepositoryRule.synonymRelationsHaveAppropriateTagsAndTagTypes()]);
    expect(true, equals(isValid));
  });

  test("Test of synonym with composite relation repo default local validity", () {
    bool isValid = repoSynonymPointingWithCompositeRelation.validateAtomsLocally();
    expect(true, equals(isValid));
  });

  test("Test of synonym pointing with composite relation repo default validity", () {
    bool isValid = repoSynonymPointingWithCompositeRelation.validate();
    expect(false, equals(isValid));
  });

  test("Test of synonym pointing with composite relation repo synonyms having appropriate relation validity", () {
    bool isValid = repoSynonymPointingWithCompositeRelation
        .validate(rules: [new TagMasterRepositoryRule.synonymsHaveAppropriateRelation()]);
    expect(false, equals(isValid));
  });

  test("Test of synonym with imprint relation repo default local validity", () {
    bool isValid = repoSynonymPointingWithImprintRelation.validateAtomsLocally();
    expect(true, equals(isValid));
  });

  test("Test of synonym pointing with imprint relation repo default validity", () {
    bool isValid = repoSynonymPointingWithImprintRelation.validate();
    expect(false, equals(isValid));
  });

  test("Test of synonym pointing with imprint relation repo synonyms having appropriate relation validity", () {
    bool isValid = repoSynonymPointingWithImprintRelation
        .validate(rules: [new TagMasterRepositoryRule.synonymsHaveAppropriateRelation()]);
    expect(false, equals(isValid));
  });
}