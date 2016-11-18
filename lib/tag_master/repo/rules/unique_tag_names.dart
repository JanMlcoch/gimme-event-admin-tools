part of tagMaster2.repo;

class UniqueTagNames extends TagMasterRepositoryRule{
  static const String onFailure = "Tag names are not unique";

  UniqueTagNames() : super(_areTagNamesUnique, onFailure);

  static bool _areTagNamesUnique(TagMasterRepository repo) {
    List<String> tagNames = [];
    for (Tag tag in repo.tags) {
      if (tagNames.contains(tag.tagName)) return false;
      tagNames.add(tag.tagName);
    }
    return true;
  }
}