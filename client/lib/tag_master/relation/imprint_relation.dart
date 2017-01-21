part of tagMaster2.relation;

class ImprintRelation extends RelationSubstance {
  ImprintRelation() : super._();
  ImprintRelation.withImprintPoint(this.imprintPoint) : super._();
  ImprintPoint imprintPoint;

  @override
  void fromMap(Map<dynamic, dynamic> map) {
    imprintPoint = new ImprintPoint()..fromMap(map["imprintPoint"]);
  }

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = super.toMap();
    map["imprintPoint"] = imprintPoint.toFullMap();
    return map;
  }

  @override
  bool validateLocally(){
    //todo: implement upon higher version of SIDOS, when validation of SidosEntities will be implemented
    return imprintPoint is ImprintPoint;
  }

  @override
  double getRepresentativeStrength(){
    double val = imprintPoint?.value == null ? 0.0 : imprintPoint.value;
    double prob = imprintPoint?.probability == null ? 0.0 : imprintPoint.probability;
    return val*prob;
  }
}
