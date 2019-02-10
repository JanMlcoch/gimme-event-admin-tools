part of test.tag_master_2;

void sSUnicityTests() {
  Function getUnicityTest(String string, List<Tag> unfilteredTags, List<Relation> relations, List<Tag> expectedTags) {
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

  Tag synonym4custom = new Tag.synonym(0, "synonym2", 0);
  Tag synonym4composite = new Tag.synonym(5, "synonym3", 0);
  Tag synonym4specific = new Tag.synonym(6, "synonym4", 0);
  Tag synonym4core = new Tag.synonym(7, "synonym5", 0);
  Tag custom = new Tag.custom(1, "a", 0);
  Tag composite = new Tag.composite(2, "b", 0);
  Tag specific = new Tag.specific(3, "ab", 0);
  Tag core = new Tag.core(4, "abcsyn", 0);

  Tag douplicitousIdTag = new Tag.specific(4, "abcsyn2", 0);

  Relation syn2Custom = new Relation.synonym([0], 1);
  Relation syn2Composite = new Relation.synonym([5], 2);
  Relation syn2Specific = new Relation.synonym([6], 3);
  Relation syn2Core = new Relation.synonym([7], 4);

//  String getLabel(Tag tag) {
//    return "${tag.tagName} -->";
//  }

  List<Tag> allNonsynTags = [custom, composite, specific, core];
  List<Tag> allTags = [
    synonym4composite,
    synonym4core,
    synonym4custom,
    synonym4specific,
    custom,
    composite,
    specific,
    core
  ];

  List<Relation> allRelas = [syn2Custom, syn2Composite, syn2Specific, syn2Core];

  test("unicity test - type of match duplicities", getUnicityTest("", allNonsynTags, [], allNonsynTags));
  test("unicity test - type of match + synonymMap duplicities", getUnicityTest("", allTags, allRelas, allNonsynTags));
  test("unicity test - hard id duplicity", getUnicityTest("", [douplicitousIdTag]..addAll(allNonsynTags), [], allNonsynTags));
}
