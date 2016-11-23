part of test.tagMaster2;

void tagMasterRepoLocalValidationTests() {
  test("Test of empty repo default local validity", () {
    bool isValid = emptyRepo.validateAtomsLocally();
    expect(isValid, equals(true));
  });

  test("Test of null-tag repo default local validity", () {
    bool isValid = repoWithOnlyNullTag.validateAtomsLocally();
    expect(isValid, equals(false));
  });

  test("Test of null-relation repo default local validity", () {
    bool isValid = repoWithOnlyNullRelation.validateAtomsLocally();
    expect(isValid, equals(false));
  });

  test("Test of null-tags repo default local validity", () {
    bool isValid = repoWithOnlyNullTags.validateAtomsLocally();
    expect(isValid, equals(false));
  });

  test("Test of null-relations repo default local validity", () {
    bool isValid = repoWithOnlyNullRelations.validateAtomsLocally();
    expect(isValid, equals(false));
  });

  test("Test of null-relation+null-tag repo default local validity", () {
    bool isValid = repoWithOnlyNullRelationOnlyNullTag.validateAtomsLocally();
    expect(isValid, equals(false));
  });

  test("Test of null-relations+null-tag repo default local validity", () {
    bool isValid = repoWithOnlyNullRelationsOnlyNullTag.validateAtomsLocally();
    expect(isValid, equals(false));
  });

  test("Test of null-relation+null-tags repo default local validity", () {
    bool isValid = repoWithOnlyNullRelationOnlyNullTags.validateAtomsLocally();
    expect(isValid, equals(false));
  });

  test("Test of null-relations+null-tags repo default local validity", () {
    bool isValid = repoWithOnlyNullRelationsOnlyNullTags.validateAtomsLocally();
    expect(isValid, equals(false));
  });

  test("Test of only_synonym_tag repo default local validity", () {
    bool isValid = repoOnlySynonymTag.validateAtomsLocally();
    expect(isValid, equals(true));
  });

  test("Test of only_custom_tag repo default local validity", () {
    bool isValid = repoOnlyCustomTag.validateAtomsLocally();
    expect(isValid, equals(true));
  });

  test("Test of only_composite_tag repo default local validity", () {
    bool isValid = repoOnlyCompositeTag.validateAtomsLocally();
    expect(isValid, equals(true));
  });

  test("Test of only_specific_tag repo default local validity", () {
    bool isValid = repoOnlySpecificTag.validateAtomsLocally();
    expect(isValid, equals(true));
  });

  test("Test of only_core_tag repo default local validity", () {
    bool isValid = repoOnlyCoreTag.validateAtomsLocally();
    expect(isValid, equals(true));
  });

  test("Test of not only null tag repo default local validity", () {
    bool isValid = validRepoWithAdditionalNullTag.validateAtomsLocally();
    expect(isValid, equals(false));
  });

  test("Test of not only null relation repo default local validity", () {
    bool isValid = validRepoWithAdditionalNullRelation.validateAtomsLocally();
    expect(isValid, equals(false));
  });

  test("Test of empty tag local validity", () {
    bool isValid = repoOnlyEmptyTag.validateAtomsLocally();
    expect(isValid, equals(false));
  });


  test("Test of null-id tag local validity", () {
    bool isValid = repoOnlyTagNullId.validateAtomsLocally();
    expect(isValid, equals(false));
  });

  test("Test of null-name tag local validity", () {
    bool isValid = repoOnlyTagNullName.validateAtomsLocally();
    expect(isValid, equals(false));
  });

  test("Test of null-author tag local validity", () {
    bool isValid = repoOnlyTagNullAuthor.validateAtomsLocally();
    expect(isValid, equals(false));
  });

  test("Test of null-lang tag local validity", () {
    bool isValid = repoOnlyTagNullLang.validateAtomsLocally();
    expect(isValid, equals(false));
  });

  test("Test of empty relation local validity", () {
    bool isValid = repoOnlyEmptyRelation.validateAtomsLocally();
    expect(isValid, equals(false));
  });

  test("Test of null-originTags relation local validity", () {
    bool isValid = repoOnlyRelationNullOriginTags.validateAtomsLocally();
    expect(isValid, equals(false));
  });

  test("Test of [null]-originTags relation local validity", () {
    bool isValid = repoOnlyRelationOriginTagsWithOnlyNull.validateAtomsLocally();
    expect(isValid, equals(false));
  });

  test("Test of null-containing-originTags relation local validity", () {
    bool isValid = repoOnlyRelationOriginTagsWithNotOnlyNull.validateAtomsLocally();
    expect(isValid, equals(false));
  });

  test("Test of null-destinationTag relation local validity", () {
    bool isValid = repoOnlyRelationPointingNull.validateAtomsLocally();
    expect(isValid, equals(false));
  });

  test("Test of composite relation with null strength local validity", () {
    bool isValid = repoOnlyCompositeRelationWithNullStrength.validateAtomsLocally();
    expect(isValid, equals(false));
  });

  test("Test of imprint relation with null IMprintPoint local validity", () {
    bool isValid = repoOnlyImprintRelationWithNullPoint.validateAtomsLocally();
    expect(isValid, equals(false));
  });

  test("Test of synonym relation with empty originTags local validity", () {
    bool isValid = emptyOriginTagsSynonym.validateAtomsLocally();
    expect(isValid, equals(false));
  });

  test("Test of composite relation with empty originTags local validity", () {
    bool isValid = emptyOriginTagsComposite.validateAtomsLocally();
    expect(isValid, equals(false));
  });

  test("Test of imprint relation with empty originTags local validity", () {
    bool isValid = emptyOriginTagsImprint.validateAtomsLocally();
    expect(isValid, equals(false));
  });
}
