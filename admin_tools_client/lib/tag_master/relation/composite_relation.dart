part of tag_master_2.relation;

class CompositeRelation extends RelationSubstance {
  CompositeRelation() : super._();
  CompositeRelation.withStrength(this.strength) : super._();
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

  @override
  double getRepresentativeStrength(){
    return strength;
  }
}
