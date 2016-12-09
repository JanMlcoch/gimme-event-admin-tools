part of tagMaster2.repo;

///Checks whether all higher order [Relation]s have nonrepeating originTagIds.
class MultiRelationsHaveNonrepeatingOrigins extends TagMasterRepositoryRule{
  static const String onFailure = "Some relation have multiple mentions of same tag in originTagIds";

  MultiRelationsHaveNonrepeatingOrigins() : super(_doMultiRelationsHaveNonrepeatingOrigins, onFailure);

  ///Checks whether all higher order [Relation]s have nonrepeating originTagIds.
  static bool _doMultiRelationsHaveNonrepeatingOrigins(TagMasterRepository repo) {
    //todo: move to local validation?
    for(Relation relation in repo.relations){
      if(relation.originTagIds.toSet().length != relation.originTagIds.length)return false;
    }
    return true;
  }
}