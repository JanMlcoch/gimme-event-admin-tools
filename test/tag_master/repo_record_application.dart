part of test.tagMaster2;

void actionRecordApplicationTests() {
  test("Test of adding tag", () {
    Tag tag = new Tag.custom(0,"tag0",0);
    TagMasterRepository expectedRepo = new TagMasterRepository.withData([tag],[]);
    ActionRecord actionRecord = new ActionRecord.addTag(0,0,0,tag);
    expect(actionRecord.applyOn(emptyRepo).toMap(), equals(expectedRepo.toMap()));
  });

  test("Test of removing tag", () {
    Tag tag = new Tag.custom(0,"tag0",0);
    TagMasterRepository originalRepo = new TagMasterRepository.withData([tag],[]);
    ActionRecord actionRecord = new ActionRecord.removeTag(0,0,0,tag);
    TagMasterRepository actualRepo = actionRecord.applyOn(originalRepo);
    TagMasterRepository expectedRepo = new TagMasterRepository.withData([],[]);
    expect(actualRepo.toMap(), equals(expectedRepo.toMap()));
  });

  test("Test of removing tag", () {
    Tag tag = new Tag.custom(0,"tag0",0);
    Tag tag1 = new Tag.custom(0,"tag1",0);
    TagMasterRepository originalRepo = new TagMasterRepository.withData([tag],[]);
    ActionRecord actionRecord = new ActionRecord.changeTag(0,0,0,tag1);
    TagMasterRepository actualRepo = actionRecord.applyOn(originalRepo);
    TagMasterRepository expectedRepo = new TagMasterRepository.withData([tag1],[]);
    expect(actualRepo.toMap(), equals(expectedRepo.toMap()));
  });

  //todo:relations
}