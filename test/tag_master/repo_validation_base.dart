part of test.tagMaster2;

void tagMasterRepoBasicValidationTests() {
  test("Test of empty repo default local validity", () {
    bool isValid = emptyRepo.validateAtomsLocally();
    expect(true, equals(isValid));
  });

  test("Test of empty repo default validity", () {
    bool isValid = emptyRepo.validate();
    expect(true, equals(isValid));
  });

  test("Test of null-tag repo default local validity", () {
    bool isValid = repoWithOnlyNullTag.validateAtomsLocally();
    expect(false, equals(isValid));
  });

  test("Test of null-tag repo default validity", () {
    bool isValid = repoWithOnlyNullTag.validate();
    expect(false, equals(isValid));
  });

  test("Test of null-relation repo default local validity", () {
    bool isValid = repoWithOnlyNullRelation.validateAtomsLocally();
    expect(false, equals(isValid));
  });

  test("Test of null-relation repo default validity", () {
    bool isValid = repoWithOnlyNullRelation.validate();
    expect(false, equals(isValid));
  });

  test("Test of null-tags repo default local validity", () {
    bool isValid = repoWithOnlyNullTags.validateAtomsLocally();
    expect(false, equals(isValid));
  });

  test("Test of null-tags repo default validity", () {
    bool isValid = repoWithOnlyNullTags.validate();
    expect(false, equals(isValid));
  });

  test("Test of null-relations repo default local validity", () {
    bool isValid = repoWithOnlyNullRelations.validateAtomsLocally();
    expect(false, equals(isValid));
  });

  test("Test of null-relations repo default validity", () {
    bool isValid = repoWithOnlyNullRelations.validate();
    expect(false, equals(isValid));
  });

  test("Test of null-relation+null-tag repo default local validity", () {
    bool isValid = repoWithOnlyNullRelationOnlyNullTag.validateAtomsLocally();
    expect(false, equals(isValid));
  });

  test("Test of null-relation+null-tag repo default validity", () {
    bool isValid = repoWithOnlyNullRelationOnlyNullTag.validate();
    expect(false, equals(isValid));
  });

  test("Test of null-relations+null-tag repo default local validity", () {
    bool isValid = repoWithOnlyNullRelationsOnlyNullTag.validateAtomsLocally();
    expect(false, equals(isValid));
  });

  test("Test of null-relations+null-tag repo default validity", () {
    bool isValid = repoWithOnlyNullRelationsOnlyNullTag.validate();
    expect(false, equals(isValid));
  });

  test("Test of null-relation+null-tags repo default local validity", () {
    bool isValid = repoWithOnlyNullRelationOnlyNullTags.validateAtomsLocally();
    expect(false, equals(isValid));
  });

  test("Test of null-relation+null-tags repo default validity", () {
    bool isValid = repoWithOnlyNullRelationOnlyNullTags.validate();
    expect(false, equals(isValid));
  });

  test("Test of null-relations+null-tags repo default local validity", () {
    bool isValid = repoWithOnlyNullRelationsOnlyNullTags.validateAtomsLocally();
    expect(false, equals(isValid));
  });

  test("Test of null-relations+null-tags repo default validity", () {
    bool isValid = repoWithOnlyNullRelationsOnlyNullTags.validate();
    expect(false, equals(isValid));
  });

  test("Test of only_synonym_tag repo default local validity", () {
    bool isValid = repoOnlySynonymTag.validateAtomsLocally();
    expect(true, equals(isValid));
  });

  test("Test of only_synonym_tag repo default validity", () {
    bool isValid = repoOnlySynonymTag.validate();
    expect(false, equals(isValid));
  });

  test("Test of only_custom_tag repo default local validity", () {
    bool isValid = repoOnlyCustomTag.validateAtomsLocally();
    expect(true, equals(isValid));
  });

  test("Test of only_custom_tag repo default validity", () {
    bool isValid = repoOnlyCustomTag.validate();
    expect(true, equals(isValid));
  });

  test("Test of only_composite_tag repo default local validity", () {
    bool isValid = repoOnlyCompositeTag.validateAtomsLocally();
    expect(true, equals(isValid));
  });

  test("Test of only_composite_tag repo default validity", () {
    bool isValid = repoOnlyCompositeTag.validate();
    expect(false, equals(isValid));
  });

  test("Test of only_specific_tag repo default local validity", () {
    bool isValid = repoOnlySpecificTag.validateAtomsLocally();
    expect(true, equals(isValid));
  });

  test("Test of only_specific_tag repo default validity", () {
    bool isValid = repoOnlySpecificTag.validate();
    expect(false, equals(isValid));
  });

  test("Test of only_core_tag repo default local validity", () {
    bool isValid = repoOnlyCoreTag.validateAtomsLocally();
    expect(true, equals(isValid));
  });

  test("Test of only_core_tag repo default validity", () {
    bool isValid = repoOnlyCoreTag.validate();
    expect(false, equals(isValid));
  });

  test("Test of not only null tag repo default local validity", () {
    bool isValid = validRepoWithAdditionalNullTag.validateAtomsLocally();
    expect(false, equals(isValid));
  });

  test("Test of not only null tag repo default validity", () {
    bool isValid = validRepoWithAdditionalNullTag.validate();
    expect(false, equals(isValid));
  });
}
