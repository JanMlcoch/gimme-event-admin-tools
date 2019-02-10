part of tag_master_2.repo;

class UniqueTagIds extends TagMasterRepositoryRule{
  static const String onFailure = "Tag ids are not unique";

  UniqueTagIds() : super(_areTagIdsUniqueMethod, onFailure);

  static bool _areTagIdsUniqueMethod(TagMasterRepository repo) {
    List<int> tagIds = [];
    for (Tag tag in repo.tags) {
      if (tagIds.contains(tag.tagId)) return false;
      tagIds.add(tag.tagId);
    }
    return true;
  }
}