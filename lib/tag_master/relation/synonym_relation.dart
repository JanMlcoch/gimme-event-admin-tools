part of tagMaster2.relation;

class SynonymRelation extends RelationSubstance {
  SynonymRelation() : super._();

  @override
  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = super.toMap();
    return map;
  }

  @override
  void fromMap(_);

  @override
  bool validateLocally(){
    return true;
  }

  @override
  double getRepresentativeStrength(){
    return 1.0;
  }
}
