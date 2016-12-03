part of tagMaster2.relation;

class Relation {
  List<int> originTagIds;
  int destinationTagId;
  RelationSubstance substance;
  String get type => substance.getType();

  Relation();

  Relation.synonym(this.originTagIds, this.destinationTagId) {
    this.substance = new SynonymRelation();
  }

  Relation.composite(this.originTagIds, this.destinationTagId, double strength) {
    this.substance = new CompositeRelation.withStrength(strength);
  }

  Relation.imprint(this.originTagIds, this.destinationTagId, ImprintPoint imprintPoint) {
    this.substance = new ImprintRelation.withImprintPoint(imprintPoint);
  }

  //todo: revise
  Relation.imprintDefault(this.originTagIds, this.destinationTagId) {
    this.substance = new ImprintRelation.withImprintPoint(new ImprintPoint());
  }

  bool hasEquivalentTags(Relation relation) {
    if (destinationTagId == relation.destinationTagId && originTagIds.length == relation.originTagIds.length) {
      bool areEquivalent = true;
      int i = 0;
      List<int> localOriginIds = originTagIds.toList()..sort();
      List<int> externalOriginIds = relation.originTagIds.toList()..sort();
      while (i < originTagIds.length && areEquivalent) {
        areEquivalent = localOriginIds[i] == externalOriginIds[i];
        i++;
      }
      return areEquivalent;
    }
    return false;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map["originTagIds"] = originTagIds.toList();
    map["destinationTagId"] = destinationTagId;
    map["relation"] = substance.toMap();
    return map;
  }

  void fromMap(Map<String, dynamic> map) {
    if (map["originTagIds"] is List<int>) originTagIds = (map["originTagIds"] as List<int>);
    destinationTagId = map["destinationTagId"];
    if (map["relation"] is Map<String, dynamic>) {
      substance = new RelationSubstance.createFromMap((map["relation"] as Map<String, dynamic>));
    }
  }

  bool validateLocally() {
    if (!(originTagIds is List<int>)) return false;
    if (originTagIds.contains(null)) return false;
    if (!(destinationTagId is int)) return false;
    if (originTagIds?.isEmpty != false) return false;
    if (type == RelationSubstance.SYNONYM && originTagIds.length > 1) return false;

    return substance.validateLocally();
  }
}
