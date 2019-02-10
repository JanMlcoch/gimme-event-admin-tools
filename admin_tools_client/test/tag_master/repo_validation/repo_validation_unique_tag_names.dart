part of test.tag_master_2;

void uniqueTagNamesTests(){
    test("Test of empty repo unique tag names rule", () {
      bool isValid = emptyRepo.validate(rules: [new TagMasterRepositoryRule.uniqueTagNames()]);
      expect(isValid, equals(true));
    });

    test("Test of repo with one tag unique tag names rule", () {
      bool isValid = repoOnlyCustomTag.validate(rules: [new TagMasterRepositoryRule.uniqueTagNames()]);
      expect(isValid, equals(true));
    });

    test("Test of repo with two same tags unique tag names rule", () {
      bool isValid = repoWithTwoSameTags.validate(rules: [new TagMasterRepositoryRule.uniqueTagNames()]);
      expect(isValid, equals(false));
    });

    test("Test of repo with two same and one different tags unique tag names rule", () {
      bool isValid = repoWithTwoSameAndOneDifferentTags.validate(rules: [new TagMasterRepositoryRule.uniqueTagNames()]);
      expect(isValid, equals(false));
    });

    test("Test of repo with two different tags unique tag names rule", () {
      bool isValid = repoOnlyCustomTags.validate(rules: [new TagMasterRepositoryRule.uniqueTagNames()]);
      expect(isValid, equals(true));
    });
}