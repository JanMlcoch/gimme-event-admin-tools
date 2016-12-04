part of test.tagMaster2;

void repoDiffTests() {
  test("Test of empty-empty diff", () {
    List<Record> diff = Record.diff(emptyRepo,emptyRepo);
    expect(diff, equals([]));
  });

  test("Test of tag-tag diff", () {
    List<Record> diff = Record.diff(repoOnlyCustomTag,repoOnlyCustomTag);
    expect(diff, equals([]));
  });

  test("Test of empty-tag diff", () {
    List<Record> diff = Record.diff(emptyRepo,repoOnlyCustomTag);
    expect(diff, equals([]));
  });
}