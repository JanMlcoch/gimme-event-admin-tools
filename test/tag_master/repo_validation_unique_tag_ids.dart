part of test.tagMaster2;

void uniqueTagIdsTests(){
    test("Test of empty repo unique tag ids rule", () {
      bool isValid = emptyRepo.validate(rules: [new TagMasterRepositoryRule.uniqueTagIds()]);
      expect(isValid, equals(true));
    });

    test("Test of repo with one tag unique tag ids rule", () {
      bool isValid = repoOnlyCustomTag.validate(rules: [new TagMasterRepositoryRule.uniqueTagIds()]);
      expect(isValid, equals(true));
    });

    test("Test of repo with two same tags unique tag ids rule", () {
      bool isValid = repoWithTwoSameTags.validate(rules: [new TagMasterRepositoryRule.uniqueTagIds()]);
      expect(isValid, equals(false));
    });

    test("Test of repo with two same and one different tags unique tag ids rule", () {
      bool isValid = repoWithTwoSameAndOneDifferentTags.validate(rules: [new TagMasterRepositoryRule.uniqueTagIds()]);
      expect(isValid, equals(false));
    });

    test("Test of repo with two different tags unique tag ids rule", () {
      bool isValid = repoOnlyCustomTags.validate(rules: [new TagMasterRepositoryRule.uniqueTagIds()]);
      expect(isValid, equals(true));
    });
}