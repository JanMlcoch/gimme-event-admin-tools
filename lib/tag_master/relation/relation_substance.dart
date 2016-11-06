part of tagMaster2.relation;

class RelationSubstance {
  static const String SYNONYM = "synonym";
  static const String COMPOSITE = "composite";
  static const String IMPRINT = "imprint";

  RelationSubstance._();

  factory RelationSubstance.createFromMap(Map<String, String> map) {
    switch (map["type"]) {
      case SYNONYM:
        return new SynonymRelation()..fromMap(map);
      case COMPOSITE:
        return new CompositeRelation()..fromMap(map);
      case IMPRINT:
        return new ImprintRelation()..fromMap(map);
      default:
        throw new Exception("""Unknown relation type:

        RelationSubstance factory tried to create instance of RelationSubstance from (json-like) Map map,
        but map[\"type\"] did not correspond with eny registered subtype of RelationSubstance""");
    }
  }

  String getType() {
    if (this is CompositeRelation) return COMPOSITE;
    if (this is ImprintRelation) return IMPRINT;
    if (this is SynonymRelation) return SYNONYM;
    return "general relation";
  }

  void fromMap(Map<String, String> map) {}

  Map<String, dynamic> toMap() {
    return {"type": getType()};
  }

  bool validateLocally() {
    throw new Exception("tried validation of instance that should have NEVER EVER been created.");
  }
}
