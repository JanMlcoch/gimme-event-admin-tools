part of tagMaster2.relation;

class CompositeRelation extends RelationSubstance {
  CompositeRelation() : super._();
  double strength;

  @override
  void fromMap(Map<dynamic, dynamic> map) {
    strength = map["strength"];
  }

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = super.toMap();
    map["strength"] = strength;
    return map;
  }

  @override
  bool validateLocally(){
    return strength is double;
  }
}
