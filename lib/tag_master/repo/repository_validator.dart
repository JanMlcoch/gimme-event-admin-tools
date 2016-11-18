part of tagMaster2;

///Class handling various validations of [TagMasterRepository]'s instances.
abstract class RepositoryValidator {
  ///Validates this instance
  static bool validate(TagMasterRepository repo) {
    if (!validateAtomsLocally(repo)) return false;
    return validateGlobally(repo);
  }

  ///This method returns true or false depending on whether the atomic
  /// [Relation]s and [Tag]s in [relations] and [tags] are valid as standalones.
  static bool validateAtomsLocally(TagMasterRepository repo) {
    for (Tag tag in repo.tags) {
      if (!tag.validateLocally()) {
        print("Local validation of tag with id ${tag.tagId} failed");
        return false;
      }
    }
    for (Relation relation in repo.relations) {
      if (!relation.validateLocally()) {
        print(
            "Local validation of relation leading from ${relation.originTagIds} to ${relation.destinationTagId} failed");
      }
    }
    return true;
  }

  ///validates global relationships between [Relation]s and [Tag]s in [relations] and [tags].
  static bool validateGlobally(TagMasterRepository repo) {
    List<String> reasonsToFail = [];
    //todo: performance optimisation
    if (!_areTagIdsUnique(repo)) reasonsToFail.add("Tag ids are not unique");
    if (!_areTagNamesUnique(repo)) reasonsToFail.add("Tag names are not unique");
    if (!_areRelationsUnique(repo)) reasonsToFail.add("Relations are not tagwise distinct");
    if (!_doRelationTagsExist(repo)) reasonsToFail.add("Some of the relation-relevant tags do not exist");
    if (!_doSynonymsHaveAppropriateRelations(repo))
      reasonsToFail.add("Some synonym tag does not have appropriate relations");
    if (!_doCustomTagsHaveAppropriateRelations(repo))
      reasonsToFail.add("Some custom tag does not have appropriate relations");
    if (!_doCompositeTagsHaveAppropriateRelations(repo))
      reasonsToFail.add("Some composite tag does not have appropriate relations");
    if (!_doSpecificTagsHaveAppropriateRelations(repo))
      reasonsToFail.add("Some specific tag does not have appropriate relations");
    if (!_doCoreTagsHaveAppropriateRelations(repo))
      reasonsToFail.add("Some core tag does not have appropriate relations");
    if (!_doSynonymRelationsHaveAppropriateTagsAndTagTypes(repo))
      reasonsToFail.add("Some synonym relation relates to inapropriate tag types");
    if (!_doCompositeRelationsHaveAppropriateTagsAndTagTypes(repo))
      reasonsToFail.add("Some composite relation relates to inapropriate tag types");
    if (!_doImprintRelationsHaveAppropriateTagsAndTagTypes(repo))
      reasonsToFail.add("Some imprint relation relates to inapropriate tag types");

    if (reasonsToFail.isEmpty) {
      print("Global validation passed");
      return true;
    } else {
      print("Global validation failed because:");
      for (String reason in reasonsToFail) print(reason);
      return false;
    }
  }

  static bool _areTagIdsUnique(TagMasterRepository repo) {
    List<int> tagIds = [];
    for (Tag tag in repo.tags) {
      if (tagIds.contains(tag.tagId)) return false;
      tagIds.add(tag.tagId);
    }
    return true;
  }

  static bool _areTagNamesUnique(TagMasterRepository repo) {
    List<String> tagNames = [];
    for (Tag tag in repo.tags) {
      if (tagNames.contains(tag.tagName)) return false;
      tagNames.add(tag.tagName);
    }
    return true;
  }

  //tests whether there are or are not two [Relation]s with the same origin and destination tags
  static bool _areRelationsUnique(TagMasterRepository repo) {
    for (int i = 0; i < repo.relations.length - 1; i++) {
      for (int j = i + 1; j < repo.relations.length; j++) {
        if (repo.relations[i].hasEquivalentTags(repo.relations[j])) return false;
      }
    }
    return true;
  }

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

  //finds out whether or not do synonym tags have appropriate relations regarding to the definitions of their types.
  static bool _doSynonymsHaveAppropriateRelations(TagMasterRepository repo) {
    List<Tag> synonyms = repo.tags.where((Tag tag) => tag.tagType == Tag.TYPE_SYNONYM).toList();

    bool synonymTest(Tag tag) {
      List<Relation> relevantRelations = repo.getRelationsRelevantFor(tag);
      if (relevantRelations.length != 1) return false;
      if (relevantRelations[0].type != RelationSubstance.SYNONYM) return false;
      if (relevantRelations[0].originTagIds.length != 1) return false;
      if (relevantRelations[0].originTagIds[0] != tag.tagId) return false;
      if (relevantRelations[0].destinationTagId == tag.tagId) return false;
      return true;
    }

    synonyms.removeWhere(synonymTest);
    return synonyms.isEmpty;
  }

  //finds out whether or not do custom tags have appropriate relations regarding to the definitions of their types.
  static bool _doCustomTagsHaveAppropriateRelations(TagMasterRepository repo) {
    List<Tag> custom = repo.tags.where((Tag tag) => tag.tagType == Tag.TYPE_CUSTOM).toList();

    bool customTest(Tag tag) {
      List<Relation> relevantRelations = repo.getRelationsRelevantFor(tag);
      relevantRelations.removeWhere(_getSynonymityTest(tag.tagId));
      return relevantRelations.isEmpty;
    }

    custom.removeWhere(customTest);
    return custom.isEmpty;
  }

  //finds out whether or not do composite tags have appropriate relations regarding to the definitions of their types.
  static bool _doCompositeTagsHaveAppropriateRelations(TagMasterRepository repo) {
    List<Tag> composite = repo.tags.where((Tag tag) => tag.tagType == Tag.TYPE_COMPOSITE).toList();

    bool compositeTest(Tag tag) {
      List<Relation> relevantRelations = repo.getRelationsRelevantFor(tag);
      relevantRelations.removeWhere(_getSynonymityTest(tag.tagId));
      if (relevantRelations.length == 0) return false;
      relevantRelations.removeWhere((Relation relation) {
        return relation.type == RelationSubstance.COMPOSITE && relation.originTagIds == [tag.tagId];
      });
      return relevantRelations.isEmpty;
    }

    composite.removeWhere(compositeTest);
    return composite.isEmpty;
  }

  //finds out whether or not do specific tags have appropriate relations regarding to the definitions of their types.
  static bool _doSpecificTagsHaveAppropriateRelations(TagMasterRepository repo) {
    List<Tag> specific = repo.tags.where((Tag tag) => tag.tagType == Tag.TYPE_SPECIFIC).toList();

    bool specificTest(Tag tag) {
      List<Relation> relevantRelations = repo.getRelationsRelevantFor(tag);
      relevantRelations.removeWhere(_getSynonymityTest(tag.tagId));
      relevantRelations.removeWhere(_getComposityTest(tag.tagId));
      if (relevantRelations.length == 0) return false;
      relevantRelations.removeWhere((Relation relation) {
        return relation.type == RelationSubstance.IMPRINT && relation.originTagIds.contains(tag.tagId);
      });
      return relevantRelations.isEmpty;
    }

    specific.removeWhere(specificTest);
    return specific.isEmpty;
  }

  //finds out whether or not do core tags have appropriate relations regarding to the definitions of their types.
  static bool _doCoreTagsHaveAppropriateRelations(TagMasterRepository repo) {
    List<Tag> core = repo.tags.where((Tag tag) => tag.tagType == Tag.TYPE_CORE).toList();

    bool coreTest(Tag tag) {
      List<Relation> relevantRelations = repo.getRelationsRelevantFor(tag);
      relevantRelations.removeWhere(_getSynonymityTest(tag.tagId));
      relevantRelations.removeWhere(_getComposityTest(tag.tagId));
      if (relevantRelations.length == 0) return false;
      if (relevantRelations
          .where((r) => r.type == RelationSubstance.IMPRINT)
          .toList()
          .where((r) => r.destinationTagId == tag.tagId)
          .isEmpty) return false;
      relevantRelations.removeWhere((r) => r.type == RelationSubstance.IMPRINT);
      return relevantRelations.isEmpty;
    }

    core.removeWhere(coreTest);
    return core.isEmpty;
  }

  //Checks whether all synonym relations have appropriate relations regarding to the definitions of their types.
  static bool _doSynonymRelationsHaveAppropriateTagsAndTagTypes(TagMasterRepository repo) {
    List<Relation> synonymRelations = repo.relations.where((r) => r.type == RelationSubstance.SYNONYM).toList();

    bool synonymRelationTest(Relation relation) {
      if (relation.originTagIds.length != 1) return false;
      if (repo.getTagById(relation.originTagIds[0]).tagType != Tag.TYPE_SYNONYM) return false;
      if (repo.getTagById(relation.destinationTagId).tagType == Tag.TYPE_SYNONYM) return false;
      return true;
    }

    synonymRelations.removeWhere(synonymRelationTest);
    return synonymRelations.isEmpty;
  }

  //Checks whether all composite relations have appropriate relations regarding to the definitions of their types.
  static bool _doCompositeRelationsHaveAppropriateTagsAndTagTypes(TagMasterRepository repo) {
    List<Relation> compositeRelations = repo.relations.where((r) => r.type == RelationSubstance.COMPOSITE).toList();

    bool compositeRelationTest(Relation relation) {
      //todo: again, is this necessary?
      if (relation.originTagIds.length != 1) return false;
      if (repo.getTagById(relation.originTagIds[0]).tagType != Tag.TYPE_COMPOSITE) return false;
      int destinationType = repo.getTagById(relation.destinationTagId).tagType;
      if (destinationType != Tag.TYPE_SPECIFIC && destinationType != Tag.TYPE_CORE) return false;
      return true;
    }

    compositeRelations.removeWhere(compositeRelationTest);
    return compositeRelations.isEmpty;
  }

  //Checks whether all imprint relations have appropriate relations regarding to the definitions of their types.
  static bool _doImprintRelationsHaveAppropriateTagsAndTagTypes(TagMasterRepository repo) {
    List<Relation> imprintRelations = repo.relations.where((r) => r.type == RelationSubstance.IMPRINT).toList();

    bool imprintRelationTest(Relation relation) {
      for (int tagId in relation.originTagIds) {
        int tagType = repo.getTagById(tagId).tagType;
        if (tagType != Tag.TYPE_SPECIFIC && tagType != Tag.TYPE_CORE) return false;
      }
      int destinationType = repo.getTagById(relation.destinationTagId).tagType;
      if (destinationType != Tag.TYPE_CORE) return false;
      return true;
    }

    imprintRelations.removeWhere(imprintRelationTest);
    return imprintRelations.isEmpty;
  }
}
