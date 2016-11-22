part of test.tagMaster2;

void tagMasterRepoBasicValidationTests() {
  test("Test of empty repo default local validity", () {
    bool isValid = emptyRepo.validateAtomsLocally();
    expect(isValid, equals(true));
  });

  test("Test of empty repo default validity", () {
    bool isValid = emptyRepo.validate();
    expect(isValid, equals(true));
  });

  test("Test of null-tag repo default local validity", () {
    bool isValid = repoWithOnlyNullTag.validateAtomsLocally();
    expect(isValid, equals(false));
  });

  test("Test of null-tag repo default validity", () {
    bool isValid = repoWithOnlyNullTag.validate();
    expect(isValid, equals(false));
  });

  test("Test of null-relation repo default local validity", () {
    bool isValid = repoWithOnlyNullRelation.validateAtomsLocally();
    expect(isValid, equals(false));
  });

  test("Test of null-relation repo default validity", () {
    bool isValid = repoWithOnlyNullRelation.validate();
    expect(isValid, equals(false));
  });

  test("Test of null-tags repo default local validity", () {
    bool isValid = repoWithOnlyNullTags.validateAtomsLocally();
    expect(isValid, equals(false));
  });

  test("Test of null-tags repo default validity", () {
    bool isValid = repoWithOnlyNullTags.validate();
    expect(isValid, equals(false));
  });

  test("Test of null-relations repo default local validity", () {
    bool isValid = repoWithOnlyNullRelations.validateAtomsLocally();
    expect(isValid, equals(false));
  });

  test("Test of null-relations repo default validity", () {
    bool isValid = repoWithOnlyNullRelations.validate();
    expect(isValid, equals(false));
  });

  test("Test of null-relation+null-tag repo default local validity", () {
    bool isValid = repoWithOnlyNullRelationOnlyNullTag.validateAtomsLocally();
    expect(isValid, equals(false));
  });

  test("Test of null-relation+null-tag repo default validity", () {
    bool isValid = repoWithOnlyNullRelationOnlyNullTag.validate();
    expect(isValid, equals(false));
  });

  test("Test of null-relations+null-tag repo default local validity", () {
    bool isValid = repoWithOnlyNullRelationsOnlyNullTag.validateAtomsLocally();
    expect(isValid, equals(false));
  });

  test("Test of null-relations+null-tag repo default validity", () {
    bool isValid = repoWithOnlyNullRelationsOnlyNullTag.validate();
    expect(isValid, equals(false));
  });

  test("Test of null-relation+null-tags repo default local validity", () {
    bool isValid = repoWithOnlyNullRelationOnlyNullTags.validateAtomsLocally();
    expect(isValid, equals(false));
  });

  test("Test of null-relation+null-tags repo default validity", () {
    bool isValid = repoWithOnlyNullRelationOnlyNullTags.validate();
    expect(isValid, equals(false));
  });

  test("Test of null-relations+null-tags repo default local validity", () {
    bool isValid = repoWithOnlyNullRelationsOnlyNullTags.validateAtomsLocally();
    expect(isValid, equals(false));
  });

  test("Test of null-relations+null-tags repo default validity", () {
    bool isValid = repoWithOnlyNullRelationsOnlyNullTags.validate();
    expect(isValid, equals(false));
  });

  test("Test of only_synonym_tag repo default local validity", () {
    bool isValid = repoOnlySynonymTag.validateAtomsLocally();
    expect(isValid, equals(true));
  });

  test("Test of only_synonym_tag repo default validity", () {
    bool isValid = repoOnlySynonymTag.validate();
    expect(isValid, equals(false));
  });

  test("Test of only_custom_tag repo default local validity", () {
    bool isValid = repoOnlyCustomTag.validateAtomsLocally();
    expect(isValid, equals(true));
  });

  test("Test of only_custom_tag repo default validity", () {
    bool isValid = repoOnlyCustomTag.validate();
    expect(isValid, equals(true));
  });

  test("Test of only_composite_tag repo default local validity", () {
    bool isValid = repoOnlyCompositeTag.validateAtomsLocally();
    expect(isValid, equals(true));
  });

  test("Test of only_composite_tag repo default validity", () {
    bool isValid = repoOnlyCompositeTag.validate();
    expect(isValid, equals(false));
  });

  test("Test of only_specific_tag repo default local validity", () {
    bool isValid = repoOnlySpecificTag.validateAtomsLocally();
    expect(isValid, equals(true));
  });

  test("Test of only_specific_tag repo default validity", () {
    bool isValid = repoOnlySpecificTag.validate();
    expect(isValid, equals(false));
  });

  test("Test of only_core_tag repo default local validity", () {
    bool isValid = repoOnlyCoreTag.validateAtomsLocally();
    expect(isValid, equals(true));
  });

  test("Test of only_core_tag repo default validity", () {
    bool isValid = repoOnlyCoreTag.validate();
    expect(isValid, equals(false));
  });

  test("Test of not only null tag repo default local validity", () {
    bool isValid = validRepoWithAdditionalNullTag.validateAtomsLocally();
    expect(isValid, equals(false));
  });

  test("Test of not only null tag repo default validity", () {
    bool isValid = validRepoWithAdditionalNullTag.validate();
    expect(isValid, equals(false));
  });

  test("Test of not only null relation repo default local validity", () {
    bool isValid = validRepoWithAdditionalNullRelation.validateAtomsLocally();
    expect(isValid, equals(false));
  });

  test("Test of not only null relation repo default validity", () {
    bool isValid = validRepoWithAdditionalNullRelation.validate();
    expect(isValid, equals(false));
  });
}
