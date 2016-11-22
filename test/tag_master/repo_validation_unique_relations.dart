part of test.tagMaster2;

void uniqueRelationsTests(){
    test("Test of empty repo unique relations rule", () {
      bool isValid = emptyRepo.validate(rules: [new TagMasterRepositoryRule.uniqueRelation()]);
      expect(isValid, equals(true));
    });

    test("Test of one Relation repo unique relations rule", () {
      bool isValid = repoSynonymPointingCompositeTag.validate(rules: [new TagMasterRepositoryRule.uniqueRelation()]);
      expect(isValid, equals(true));
    });


    test("Test of two tags pointing same tag separately unique relations rule", () {
      bool isValid = repoWithTwoCompositeTagsPointingSpecificSeparately.validate(rules: [new TagMasterRepositoryRule.uniqueRelation()]);
      expect(isValid, equals(true));
    });


    test("Test of two tags pointing same tag together unique relations rule", () {
      bool isValid = repoWithTwoCompositeTagsPointingSpecificTogether.validate(rules: [new TagMasterRepositoryRule.uniqueRelation()]);
      expect(isValid, equals(true));
    });


    test("Test of two tags pointing same tag separately and together unique relations rule", () {
      bool isValid = repoWithTwoCompositeTagsPointingSpecificTogetherAndSeparately.validate(rules: [new TagMasterRepositoryRule.uniqueRelation()]);
      expect(isValid, equals(true));
    });

    test("Test of two tags pointing each other unique relations rule", () {
      bool isValid = coreTagsPointingEachOther.validate(rules: [new TagMasterRepositoryRule.uniqueRelation()]);
      expect(isValid, equals(true));
    });


    test("Test of two tags pointing same tag unique relations rule", () {
      bool isValid = coreTagsPointingSameTag.validate(rules: [new TagMasterRepositoryRule.uniqueRelation()]);
      expect(isValid, equals(true));
    });

    test("Test of tag pointing two tags unique relations rule", () {
      bool isValid = coreTagPointingTwoTags.validate(rules: [new TagMasterRepositoryRule.uniqueRelation()]);
      expect(isValid, equals(true));
    });

    test("Test of ternary and higher relations positive case relations rule", () {
      bool isValid = complete3coreHyperGraph.validate(rules: [new TagMasterRepositoryRule.uniqueRelation()]);
      expect(isValid, equals(true));
    });

    test("Test of duplicit self-pointing relations unique relations rule", () {
      bool isValid = onlyDuplicitSelfPointingBinaryRelation.validate(rules: [new TagMasterRepositoryRule.uniqueRelation()]);
      expect(isValid, equals(false));
    });


    test("Test of duplicit relations unique relations rule", () {
      bool isValid = onlyDuplicitBinaryRelation.validate(rules: [new TagMasterRepositoryRule.uniqueRelation()]);
      expect(isValid, equals(false));
    });


    test("Test of duplicit ternary relations unique relations rule", () {
      bool isValid = onlyDuplicitTernaryRelation.validate(rules: [new TagMasterRepositoryRule.uniqueRelation()]);
      expect(isValid, equals(false));
    });


    test("Test of duplicit relations with different substance unique relations rule", () {
      bool isValid = onlyDuplicitTernaryRelationWithDifferentStrength.validate(rules: [new TagMasterRepositoryRule.uniqueRelation()]);
      expect(isValid, equals(false));
    });
}