part of tagMaster2.repo;

class RelationTagsExists extends TagMasterRepositoryRule{
  static const String onFailure = "Some of the relation-relevant tags do not exist";

  RelationTagsExists() : super(_doRelationTagsExist, onFailure);

  static bool _doRelationTagsExist(TagMasterRepository repo) {
    Set<int> tagIds = new Set();
    for (Relation relation in repo.relations) {
      tagIds.addAll(relation.originTagIds.toList());
      tagIds.add(relation.destinationTagId);
    }
    for (int tagId in tagIds) {
      bool doesTagIdExist = repo.tags.any((Tag tag) => tag.tagId == tagId);
      if (!doesTagIdExist) return false;
    }
    return true;
  }
}