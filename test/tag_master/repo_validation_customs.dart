part of test.tagMaster2;

void tagMasterRepoCustomValidationTests() {
  test("Test of only custom tag repo default validity", () {
    bool isValid = repoOnlyCustomTag.validate();
    expect(isValid, equals(true));
  });

  test("Test of only custom tags repo default validity", () {
    bool isValid = repoOnlyCustomTags.validate();
    expect(isValid, equals(true));
  });



  test("Test of only custom tags repo default validity", () {
    bool isValid = repoOnlyCustomTags.validate();
    expect(isValid, equals(true));
  });
}
