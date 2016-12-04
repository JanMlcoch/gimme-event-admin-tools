part of test.tagMaster2;

void repoDiffTests() {
  Function getTwoStatesTest(TagMasterRepository originRepo, TagMasterRepository finalRepox) {
    return () {
      TagMasterRepository originalRepo = originRepo;
      final TagMasterRepository finalRepo = finalRepox;
      List<Record> diff = Record.diff(originalRepo, finalRepo);
      print(diff);
      TagMasterRepository actualRepo = originalRepo;
      for (Record record in diff) {
        actualRepo = record.appliedOn(actualRepo);
      }
      Map actualMap = actualRepo.toMap();
      Map finalMap = finalRepo.toMap();
      (actualMap["tags"] as List<Map<String,dynamic>>).sort((a,b)=>a.toString().compareTo(b.toString()));
      (actualMap["relations"] as List<Map<String,dynamic>>).sort((a,b)=>a.toString().compareTo(b.toString()));
      (finalMap["tags"] as List<Map<String,dynamic>>).sort((a,b)=>a.toString().compareTo(b.toString()));
      (finalMap["relations"] as List<Map<String,dynamic>>).sort((a,b)=>a.toString().compareTo(b.toString()));
      expect(actualMap, equals(finalMap));
    };
  }

  test("Test of empty-empty diff", getTwoStatesTest(emptyRepo, emptyRepo));

  test("Test of tag-tag diff", getTwoStatesTest(repoOnlyCustomTag, repoOnlyCustomTag));

  test("Test of empty-tag diff", getTwoStatesTest(emptyRepo, repoOnlyCustomTag));

  test("Test of tag-empty diff", getTwoStatesTest(repoOnlyCustomTag, emptyRepo));

  test("Test of complex-empty diff", getTwoStatesTest(complete3coreHyperGraph, emptyRepo));

  test("Test of empty-complex diff", getTwoStatesTest(emptyRepo, complete3coreHyperGraph));

  test("Test of complex-complex diff", getTwoStatesTest(complete3coreHyperGraph, complete3coreHyperGraph));

  test("Test of complex-(different)complex diff", getTwoStatesTest(coreTagPointingTwoTags, complete3coreHyperGraph));
}