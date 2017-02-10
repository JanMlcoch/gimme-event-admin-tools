part of test.tag_master_2;

void sSAllowedTypeTests() {
  Function getAllowedTypesTest(List<Tag> unfilteredTags, List<Tag> expectedTags, List<int> allowedTypes) {
    return () {
      String string = "";
      TagMasterRepository repo = new TagMasterRepository.withData(unfilteredTags, []);
      List<Tag> filteredTags = SmartSorter.getTags(
          string, repo, giveMaximalAmount: true, shouldReMapSynonyms: false, allowedTypes: allowedTypes);
      List<Map<String, dynamic>> actualList = [];
      List<Map<String, dynamic>> expectedList = [];
      for (Tag tag in filteredTags) {
        actualList.add(tag.toMap());
      }
      for (Tag tag in expectedTags) {
        expectedList.add(tag.toMap());
      }
      actualList.sort((a, b) => a.toString().compareTo(b.toString()));
      expectedList.sort((a, b) => a.toString().compareTo(b.toString()));
      expect(actualList, equals(expectedList));
    };
  }

  Tag synonym = new Tag.synonym(0, "", 0);
  Tag custom = new Tag.custom(1, "a", 0);
  Tag composite = new Tag.composite(2, "b", 0);
  Tag specific = new Tag.specific(3, "ab", 0);
  Tag core = new Tag.core(4, "abc", 0);

  List<Tag> allTags = [synonym, custom, composite, specific, core];

  test("Allowed types tests - no allowed", getAllowedTypesTest(allTags, [], []));

  test("Allowed types tests - [1]", getAllowedTypesTest(allTags, [synonym], [1]));
  test("Allowed types tests - [2]", getAllowedTypesTest(allTags, [custom], [2]));
  test("Allowed types tests - [3]", getAllowedTypesTest(allTags, [composite], [3]));
  test("Allowed types tests - [4]", getAllowedTypesTest(allTags, [specific], [4]));
  test("Allowed types tests - [5]", getAllowedTypesTest(allTags, [core], [5]));

  test("Allowed types tests - multiple w syn", getAllowedTypesTest(allTags, [synonym, specific], [1,4]));
  test("Allowed types tests - multiple w/o syn", getAllowedTypesTest(allTags, [custom, specific], [2,4]));

  test("Allowed types tests - all alowed", getAllowedTypesTest(allTags, allTags, [1,2,3,4,5]));
}
