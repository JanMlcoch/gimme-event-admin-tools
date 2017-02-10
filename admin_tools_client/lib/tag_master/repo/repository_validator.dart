part of tag_master_2.repo;

///Class handling various validations of [TagMasterRepository]'s instances.
abstract class RepositoryValidator {
  ///[List] of default rules for [TagMasterRepository]
  static List<TagMasterRepositoryRule> defaultRules = [
    new TagMasterRepositoryRule.uniqueTagIds(),
    new TagMasterRepositoryRule.uniqueTagNames(),
    new TagMasterRepositoryRule.uniqueRelation(),
    new TagMasterRepositoryRule.originTagIdsAreSetish(),
    new TagMasterRepositoryRule.relationTagsExists(),
    new TagMasterRepositoryRule.synonymsHaveAppropriateRelation(),
    new TagMasterRepositoryRule.customTagsHaveAppropriateRelation(),
    new TagMasterRepositoryRule.compositeTagsHaveAppropriateRelation(),
    new TagMasterRepositoryRule.specificTagsHaveAppropriateRelation(),
    new TagMasterRepositoryRule.coreTagsHaveAppropriateRelation(),
    new TagMasterRepositoryRule.synonymRelationsHaveAppropriateTagsAndTagTypes(),
    new TagMasterRepositoryRule.compositeRelationsHaveAppropriateTagsAndTagTypes(),
    new TagMasterRepositoryRule.imprintRelationsHaveAppropriateTagsAndTagTypes(),
  ];

  ///Validates this instance. If no [rules] are provided, or are provided as [null], [defaultRules] will be used instead.
  static bool validate(TagMasterRepository repo, {List<TagMasterRepositoryRule> rules: null}) {
    if (!validateAtomsLocally(repo)) return false;
    return validateGlobally(repo, rules: rules);
  }

  ///This method returns true or false depending on whether the atomic
  /// [Relation]s and [Tag]s in [relations] and [tags] are valid as standalones.
  static bool validateAtomsLocally(TagMasterRepository repo) {
    for (Tag tag in repo.tags) {
      if (tag?.validateLocally() != true) {
        print("Local validation of tag with id ${tag?.tagId} failed");
        return false;
      }
    }
    for (Relation relation in repo.relations) {
      if (relation?.validateLocally() != true) {
        print(
            "Local validation of relation leading from ${relation?.originTagIds} to ${relation?.destinationTagId} failed");
        return false;
      }
    }
    return true;
  }

  ///validates global relationships between [Relation]s and [Tag]s in [relations] and [tags].
  static bool validateGlobally(TagMasterRepository repo, {List<TagMasterRepositoryRule> rules: null}) {
    if (rules == null) rules = defaultRules;
    List<String> reasonsToFail = [];
    //todo: ?performance optimisation
    for (TagMasterRepositoryRule rule in rules) {
      if (!rule.repositoryTest(repo)) reasonsToFail.add(rule.onInvalidMessage);
    }
    if (reasonsToFail.isEmpty) {
//      print("Global validation passed");
      return true;
    } else {
//      print("Global validation failed because:");
      for (String reason in reasonsToFail) print(reason);
//      print("*end of reasons*");
      return false;
    }
  }

  static RelationTest _getSynonymityTest(int tagId) {
    bool testFunction(Relation relation) {
      if (relation.type != RelationSubstance.SYNONYM) return false;
      if (relation.originTagIds.length != 1) return false;
      if (relation.originTagIds.contains(tagId)) return false;
      if (relation.destinationTagId != tagId) return false;
      return true;
    }

    return testFunction;
  }

  static RelationTest _getComposityTest(int tagId) {
    bool testFunction(Relation relation) {
      if (relation.type != RelationSubstance.COMPOSITE) return false;
      //todo: is this condition necessary?
      if (relation.originTagIds.length != 1) return false;
      if (relation.originTagIds.contains(tagId)) return false;
      if (relation.destinationTagId != tagId) return false;
      return true;
    }

    return testFunction;
  }
}
