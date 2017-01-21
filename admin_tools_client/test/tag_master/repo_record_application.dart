part of test.tagMaster2;

void actionRecordApplicationTests() {
  test("Test of adding tag", () {
    Tag tag = new Tag.custom(0,"tag0",0);
    TagMasterRepository expectedRepo = new TagMasterRepository.withData([tag],[]);
    Record record = new Record.recordTag(tag);
    expect(record.appliedOn(emptyRepo).toMap(), equals(expectedRepo.toMap()));
  });

  test("Test of removing tag", () {
    Tag tag = new Tag.custom(0,"tag0",0);
    TagMasterRepository originalRepo = new TagMasterRepository.withData([tag],[]);
    Record record = new Record.removeTag(tag);
    TagMasterRepository actualRepo = record.appliedOn(originalRepo);
    TagMasterRepository expectedRepo = new TagMasterRepository.withData([],[]);
    expect(actualRepo.toMap(), equals(expectedRepo.toMap()));
  });

  test("Test of change tag", () {
    Tag tag = new Tag.custom(0,"tag0",0);
    Tag tag1 = new Tag.custom(0,"tag1",0);
    TagMasterRepository originalRepo = new TagMasterRepository.withData([tag],[]);
    Record record = new Record.recordTag(tag1);
    TagMasterRepository actualRepo = record.appliedOn(originalRepo);
    TagMasterRepository expectedRepo = new TagMasterRepository.withData([tag1],[]);
    expect(actualRepo.toMap(), equals(expectedRepo.toMap()));
  });

  test("Test of specific tag removal", () {
    Tag tag = new Tag.custom(0,"tag0",0);
    Tag tag1 = new Tag.custom(1,"tag1",0);
    TagMasterRepository originalRepo = new TagMasterRepository.withData([tag, tag1],[]);
    Record record = new Record.removeTag(tag1);
    TagMasterRepository actualRepo = record.appliedOn(originalRepo);
    TagMasterRepository expectedRepo = new TagMasterRepository.withData([tag],[]);
    expect(actualRepo.toMap(), equals(expectedRepo.toMap()));
  });

  test("Test of relation insertion", () {
    Relation relation = new Relation.synonym([0],1);
    TagMasterRepository originalRepo = new TagMasterRepository.withData([],[]);
    Record record = new Record.recordRelation(relation);
    TagMasterRepository actualRepo = record.appliedOn(originalRepo);
    TagMasterRepository expectedRepo = new TagMasterRepository.withData([],[relation]);
    expect(actualRepo.toMap(), equals(expectedRepo.toMap()));
  });

  test("Test of relation deletion", () {
    Relation relation = new Relation.synonym([0],1);
    TagMasterRepository originalRepo = new TagMasterRepository.withData([],[relation]);
    Record record = new Record.removeRelation(relation);
    TagMasterRepository actualRepo = record.appliedOn(originalRepo);
    TagMasterRepository expectedRepo = new TagMasterRepository.withData([],[]);
    expect(actualRepo.toMap(), equals(expectedRepo.toMap()));
  });


  test("Test of specific relation deletion", () {
    Relation relation = new Relation.synonym([0],1);
    Relation relation1 = new Relation.synonym([3],1);
    TagMasterRepository originalRepo = new TagMasterRepository.withData([],[relation, relation1]);
    Record record = new Record.removeRelation(relation);
    TagMasterRepository actualRepo = record.appliedOn(originalRepo);
    TagMasterRepository expectedRepo = new TagMasterRepository.withData([],[relation1]);
    expect(actualRepo.toMap(), equals(expectedRepo.toMap()));
  });
  //todo:relations
  //todo better removal
}