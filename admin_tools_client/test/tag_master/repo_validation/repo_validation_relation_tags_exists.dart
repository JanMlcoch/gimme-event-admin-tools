part of test.tag_master_2;

void relationTagsExistsTests(){
    test("Test of empty repo - relations tags exists rule", () {
      bool isValid = emptyRepo.validate(rules: [new TagMasterRepositoryRule.relationTagsExists()]);
      expect(isValid, equals(true));
    });

    test("Test of missing all tags from binary relation - relations tags exists rule", () {
      bool isValid = onlyDuplicitBinaryRelation.validate(rules: [new TagMasterRepositoryRule.relationTagsExists()]);
      expect(isValid, equals(false));
    });

    test("Test of missing all tags from ternary relation - relations tags exists rule", () {
      bool isValid = onlyDuplicitTernaryRelation.validate(rules: [new TagMasterRepositoryRule.relationTagsExists()]);
      expect(isValid, equals(false));
    });

    test("Test of missing only origin tag relation - relations tags exists rule", () {
      bool isValid = nonexistentSynonymPointing.validate(rules: [new TagMasterRepositoryRule.relationTagsExists()]);
      expect(isValid, equals(false));
    });

    test("Test of missing destination tag relation - relations tags exists rule", () {
      bool isValid = synonymPointingNonexistentTag.validate(rules: [new TagMasterRepositoryRule.relationTagsExists()]);
      expect(isValid, equals(false));
    });

    test("Test of missing one of the origin tags relation - relations tags exists rule", () {
      bool isValid = ternaryRelationWithOneMissingOriginTag.validate(rules: [new TagMasterRepositoryRule.relationTagsExists()]);
      expect(isValid, equals(false));
    });
}