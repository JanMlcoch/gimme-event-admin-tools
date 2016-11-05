part of tagMaster2.relation;

class Relation {
  List<int> originTagIds;
  int destinationTagId;
  RelationSubstance substance;
  String get type => substance.getType();

  bool hasEquivalentTags(Relation relation){
    if(destinationTagId == relation.destinationTagId && originTagIds.length == relation.originTagIds.length){
      bool areEquivalent = true;
      int i = 0;
      List<int> localOriginIds = originTagIds.toList()..sort();
      List<int> externalOriginIds = relation.originTagIds.toList()..sort();
      while(i<originTagIds.length && areEquivalent){
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
    originTagIds = map["originTagIds"];
    destinationTagId = map["destinationTagId"];
    substance = new RelationSubstance.createFromMap(map["relation"]);
  }

  bool validateLocally(){
    if(!(originTagIds is List<int>))return false;
    if(!(destinationTagId is int))return false;
    if(type == RelationSubstance.SYNONYM && originTagIds.length>1)return false;

    return substance.validateLocally();
  }
}
