part of test.tagMaster2;

void sSReMapSynonymsTests() {
  Function getAllowedTypesTest(String string, List<Tag> unfilteredTags, List<Relation> relations, List<Tag> expectedTags) {
    return () {
//      String string = "";
      TagMasterRepository repo = new TagMasterRepository.withData(unfilteredTags, relations);
      List<Tag> filteredTags = SmartSorter.getTags(string, repo, giveMaximalAmount: true);
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

  Tag synonym = new Tag.synonym(0, "synonym", 0);
  Tag custom = new Tag.custom(1, "a", 0);
  Tag composite = new Tag.composite(2, "b", 0);
  Tag specific = new Tag.specific(3, "ab", 0);
  Tag core = new Tag.core(4, "abcsyn", 0);

  Relation syn2Custom = new Relation.synonym([0],1);
  Relation syn2Core = new Relation.synonym([0],4);

  String getLabel(Tag tag){return "${tag.tagName} -->";}
  List<Tag> allTags = [synonym, custom, composite, specific, core];

  test("Synonym remap test - under priority", getAllowedTypesTest("", allTags, [syn2Custom], [custom,composite,specific,core]));
  test("Synonym remap - only synonym matches", getAllowedTypesTest("synonym", allTags, [syn2Custom], [new LabeledTag.fromTag(getLabel(synonym),custom)]));
  test("Synonym remap - synonym matches, target doesent", getAllowedTypesTest("syno", allTags, [syn2Core], [new LabeledTag.fromTag(getLabel(synonym),core)]));
  test("Synonym remap - synonym matches better than target", getAllowedTypesTest("syn", allTags, [syn2Core], [new LabeledTag.fromTag(getLabel(synonym),core)]));
}
