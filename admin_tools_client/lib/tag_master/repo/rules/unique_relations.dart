part of tagMaster2.repo;

///tests whether there are or are not two [Relation]s with the same origin and destination tags
class UniqueRelations extends TagMasterRepositoryRule{
  static const String onFailure = "Relations are not tagwise distinct";

  UniqueRelations() : super(_areRelationsUnique, onFailure);

  ///tests whether there are or are not two [Relation]s with the same origin and destination tags
  static bool _areRelationsUnique(TagMasterRepository repo) {
    for (int i = 0; i < repo.relations.length - 1; i++) {
      for (int j = i + 1; j < repo.relations.length; j++) {
        if (repo.relations[i].hasEquivalentTags(repo.relations[j])) return false;
      }
    }
    return true;
  }
}