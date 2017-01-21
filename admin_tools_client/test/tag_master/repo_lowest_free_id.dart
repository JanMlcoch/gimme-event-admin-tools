part of test.tagMaster2;

void tagMasterRepoLowestUnusedIdTests() {
  test("Test of empty repo lowest unused id", () {
    expect(emptyRepo.getLowestUnusedTagId(), equals(0));
  });

  test("Test of [0] repo lowest unused id", () {
    TagMasterRepository repo = new TagMasterRepository.withData([new Tag.custom(0,"",0)],[]);
    expect(repo.getLowestUnusedTagId(), equals(1));
  });

  test("Test of [1] repo lowest unused id", () {
    TagMasterRepository repo = new TagMasterRepository.withData([new Tag.custom(1,"",0)],[]);
    expect(repo.getLowestUnusedTagId(), equals(0));
  });

  test("Test of [2] repo lowest unused id", () {
    TagMasterRepository repo = new TagMasterRepository.withData([new Tag.custom(2,"",0)],[]);
    expect(repo.getLowestUnusedTagId(), equals(0));
  });

  test("Test of [0,1] repo lowest unused id", () {
    TagMasterRepository repo = new TagMasterRepository.withData([new Tag.custom(0,"",0),new Tag.custom(1,"a",0)],[]);
    expect(repo.getLowestUnusedTagId(), equals(2));
  });

  test("Test of [0,2] repo lowest unused id", () {
    TagMasterRepository repo = new TagMasterRepository.withData([new Tag.custom(0,"",0),new Tag.custom(2,"a",0)],[]);
    expect(repo.getLowestUnusedTagId(), equals(1));
  });

  test("Test of [0,3] repo lowest unused id", () {
    TagMasterRepository repo = new TagMasterRepository.withData([new Tag.custom(0,"",0),new Tag.custom(3,"a",0)],[]);
    expect(repo.getLowestUnusedTagId(), equals(1));
  });

  test("Test of [1,2] repo lowest unused id", () {
    TagMasterRepository repo = new TagMasterRepository.withData([new Tag.custom(1,"",0),new Tag.custom(2,"a",0)],[]);
    expect(repo.getLowestUnusedTagId(), equals(0));
  });

  test("Test of [1,3] repo lowest unused id", () {
    TagMasterRepository repo = new TagMasterRepository.withData([new Tag.custom(1,"",0),new Tag.custom(3,"a",0)],[]);
    expect(repo.getLowestUnusedTagId(), equals(0));
  });
}
