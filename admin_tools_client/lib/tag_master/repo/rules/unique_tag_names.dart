part of tag_master_2.repo;

class UniqueTagNames extends TagMasterRepositoryRule{
  static const String onFailure = "Tag names are not unique";

  UniqueTagNames() : super(_areTagNamesUnique, onFailure);

  static bool _areTagNamesUnique(TagMasterRepository repo) {
    List<String> tagNames = [];
    for (Tag tag in repo.tags) {
      if (tagNames.contains(tag.tagName.toLowerCase())) return false;
      tagNames.add(tag.tagName.toLowerCase());//todo: test case insesitivity
    }
    return true;
  }
}