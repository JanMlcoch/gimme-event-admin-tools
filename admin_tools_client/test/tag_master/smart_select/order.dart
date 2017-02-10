part of test.tag_master_2;

void sSOrderTests() {
  Function getOrderTest(List<Tag> unfilteredTags, List<Tag> expectedTags, String string) {
    return () {
      TagMasterRepository repo = new TagMasterRepository.withData(unfilteredTags, []);
      List<Tag> filteredTags = SmartSorter.getTags(string, repo, shouldReMapSynonyms: false, giveMaximalAmount: true);
      List<Map<String, dynamic>> actualList = [];
      List<Map<String, dynamic>> expectedList = [];
      for (Tag tag in filteredTags) {
        actualList.add(tag.toMap());
      }
      for (Tag tag in expectedTags) {
        expectedList.add(tag.toMap());
      }
      expect(actualList, equals(expectedList));
    };
  }

  Tag abSyn = new Tag.synonym(0,"ab",0);
  Tag baSyn = new Tag.synonym(1,"ba",0);
  Tag abCus = new Tag.custom(2,"ab",0);
  Tag baCus = new Tag.custom(3,"ba",0);
  Tag abaSyn = new Tag.synonym(4,"aba",0);

//todo: tests for abbrev types
  test("Test of ordering synonyms by match type", getOrderTest([abSyn,baSyn],[baSyn,abSyn],"b"));
  test("Test of ordering non-synonyms by match type", getOrderTest([abCus,baCus],[baCus,abCus],"b"));
  test("Test of ordering by Tag type", getOrderTest([abaSyn,abCus],[abCus,abaSyn],"a"));
  test("Test of match type having priority over tag type", getOrderTest([baCus,abSyn],[abSyn,baCus],"a"));
  //todo: prefere direct match over synonym remap


}
