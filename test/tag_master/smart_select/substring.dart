part of test.tagMaster2;

void sSSubstringTests() {
  Function getSubstringTest(List<Tag> unfilteredTags, String string, List<Tag> expectedTags){
    return (){
      TagMasterRepository repo = new TagMasterRepository.withData(unfilteredTags,[]);
      List<Tag> filteredTags = SmartSorter.getSubstringTags(repo,string);
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
  Tag abTag = new Tag.composite(0, "ab", 0);
  Tag abcTag = new Tag.composite(0, "abc", 0);
  Tag cdTag = new Tag.composite(0, "cd", 0);
  Tag babTag = new Tag.composite(0, "bab", 0);

  test("Empty repo substring result tests", getSubstringTest([],"",[]));
  test("Empty string substring result tests", getSubstringTest([namelessTag,abTag,aTag,bTag],"",[namelessTag,abTag,aTag,bTag]));

  test("Handling empty names substring result test - 1char string", getSubstringTest([namelessTag],"a",[]));
  test("Full match 1 char substring result test - 1char string", getSubstringTest([aTag],"a",[aTag]));
  test("Startswith char substring result test - 1char string", getSubstringTest([abTag],"a",[abTag]));
  test("mismatch substring result test - 1char string", getSubstringTest([bTag],"a",[]));
  test("containes later substring result test - 1char string", getSubstringTest([abTag],"b",[abTag]));

  test("Handling empty names substring result test", getSubstringTest([namelessTag],"ab",[]));
  test("Full match substring result test", getSubstringTest([abTag],"ab",[abTag]));
  test("starts with substring result test", getSubstringTest([abcTag],"ab",[abcTag]));
  test("mismatch substring result test", getSubstringTest([cdTag],"ab",[]));
  test("name containes bit doesnt start with string substring result test", getSubstringTest([abcTag],"bc",[abcTag]));
  test("string containes bit doesnt start with name substring result test", getSubstringTest([cdTag],"acd",[]));
  test("string starts with but is not name substring result test", getSubstringTest([abTag],"abc",[]));
  test("string & name starts with same characters substring result test", getSubstringTest([abcTag],"abd",[]));

  test("misch mash substring result test", getSubstringTest([namelessTag,abTag,aTag,abcTag,bTag,cdTag,babTag],"ab",[abTag,abcTag,babTag]));
}
