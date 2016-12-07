part of test.tagMaster2;

void sSStartsWithTests() {
  Function getStartsWithTest(List<Tag> unfilteredTags, String string, List<Tag> expectedTags){
    return (){
      TagMasterRepository repo = new TagMasterRepository.withData(unfilteredTags,[]);
      List<Tag> filteredTags = SmartSorter.getStartsWithTags(repo,string);
      List<Map<String,dynamic>> actualList = [];
      List<Map<String,dynamic>> expectedList = [];
      for(Tag tag in filteredTags){
        actualList.add(tag.toMap());
      }
      for(Tag tag in expectedTags){
        expectedList.add(tag.toMap());
      }
      actualList.sort((a,b)=>a.toString().compareTo(b.toString()));
      expectedList.sort((a,b)=>a.toString().compareTo(b.toString()));
      expect(actualList,equals(expectedList));
    };
  }

  Tag namelessTag = new Tag.composite(0, "", 0);
  Tag aTag = new Tag.composite(1, "a", 0);
  Tag bTag = new Tag.composite(2, "b", 0);
  Tag abTag = new Tag.composite(3, "ab", 0);
  Tag abcTag = new Tag.composite(4, "abc", 0);
  Tag cdTag = new Tag.composite(5, "cd", 0);
  Tag aBTag = new Tag.composite(6, "aB", 0);

  test("Empty repo startsWIth result tests", getStartsWithTest([],"",[]));
  test("Empty string startsWIth result tests", getStartsWithTest([namelessTag,abTag,aTag,bTag],"",[namelessTag,abTag,aTag,bTag]));

  test("Handling empty names startsWIth result test - 1char string", getStartsWithTest([namelessTag],"a",[]));
  test("Full match 1 char startsWIth result test - 1char string", getStartsWithTest([aTag],"a",[aTag]));
  test("Startswith char startsWIth result test - 1char string", getStartsWithTest([abTag],"a",[abTag]));
  test("mismatch startsWIth result test - 1char string", getStartsWithTest([bTag],"a",[]));
  test("containes later startsWIth result test - 1char string", getStartsWithTest([abTag],"b",[]));

  test("Handling empty names startsWIth result test", getStartsWithTest([namelessTag],"ab",[]));
  test("Full match startsWIth result test", getStartsWithTest([abTag],"ab",[abTag]));
  test("starts with startsWIth result test", getStartsWithTest([abcTag],"ab",[abcTag]));
  test("mismatch startsWIth result test", getStartsWithTest([cdTag],"ab",[]));
  test("name containes bit doesnt start with string startsWIth result test", getStartsWithTest([abcTag],"bc",[]));
  test("string containes bit doesnt start with name startsWIth result test", getStartsWithTest([cdTag],"acd",[]));
  test("string starts with but is not name startsWIth result test", getStartsWithTest([abTag],"abc",[]));
  test("string & name starts with same characters startsWIth result test", getStartsWithTest([abcTag],"abd",[]));

  test("case insensitivity startsWIth result test", getStartsWithTest([aBTag],"ab",[aBTag]));

  test("misch mash startsWIth result test", getStartsWithTest([namelessTag,abTag,aTag,abcTag,bTag,cdTag],"ab",[abTag,abcTag]));
}
