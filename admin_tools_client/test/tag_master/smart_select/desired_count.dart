part of test.tag_master_2;

void desiredCountTest() {
  Function getMaxAmountTestTest(List<Tag> unfilteredTags, String string, int filteredLength,{int numberOfTagsDesired: 3, bool giveMax: false}){
    return (){
      TagMasterRepository repo = new TagMasterRepository.withData(unfilteredTags,[]);
      List<Tag> sortedTags = SmartSorter.getTags(string, repo, numberOfTagsDesired: numberOfTagsDesired, giveMaximalAmount: giveMax);
      List<Map<String,dynamic>> actualList = [];
//      List<Map<String,dynamic>> expectedList = [];
      for(Tag tag in sortedTags){
        actualList.add(tag.toMap());
      }
//      for(Tag tag in expectedTags){
//        expectedList.add(tag.toMap());
//      }
//      actualList.sort((a,b)=>a.toString().compareTo(b.toString()));
//      expectedList.sort((a,b)=>a.toString().compareTo(b.toString()));
      expect(actualList.length,equals(filteredLength));
    };
  }

  Tag namelessTag = new Tag.composite(0, "", 0);
  Tag aTag = new Tag.composite(1, "a", 0);
  Tag bTag = new Tag.composite(2, "b", 0);
  Tag abTag = new Tag.composite(3, "ab", 0);
  Tag abcTag = new Tag.composite(4, "abc", 0);
  Tag cdTag = new Tag.composite(5, "cd", 0);
  Tag babTag = new Tag.composite(6, "bab", 0);

  List<Tag> allTags = [namelessTag,abcTag,aTag,abTag,bTag,babTag,cdTag];

  test("0 desired tags result tests", getMaxAmountTestTest(allTags,"",0,numberOfTagsDesired: 0));
  test("1 desired tags result tests", getMaxAmountTestTest(allTags,"",1,numberOfTagsDesired: 1));
  test("2 desired tags result tests", getMaxAmountTestTest(allTags,"",2,numberOfTagsDesired: 2));
  test("latge amount of desired tags result tests", getMaxAmountTestTest(allTags,"",allTags.length,numberOfTagsDesired: 200));
  test("give max amount result tests", getMaxAmountTestTest(allTags,"",allTags.length,giveMax: true));
}
