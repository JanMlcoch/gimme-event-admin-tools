part of tagMaster2.version;

class Version {
  int id;
  DateTime insertionTime;
  int generatedBy;
  String comment;
  TagMasterRepository initialState;
  TagMasterRepository currentState;

  void applyActionRecord(ActionRecord record){
    //todo: checking versionIds and shit
    currentState = record.appliedOn(currentState);
  }

  void fromMap(Map<String, dynamic> map) {
    id = map["id"];
    insertionTime = new DateTime.fromMillisecondsSinceEpoch(map["insertionTime"]);
    generatedBy = map["generatedBy"];
    comment = map["comment"];
    dynamic initialStateMap = map["initialState"];
    if (initialStateMap is Map<String, List<Map<String, dynamic>>>) {
      initialState = new TagMasterRepository()..fromMap(initialStateMap);
    }
    dynamic currentStateMap = map["currentState"];
    if (currentStateMap is Map<String, List<Map<String, dynamic>>>) {
      currentState = new TagMasterRepository()..fromMap(currentStateMap);
    }
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};

    map["id"] = id;
    map["insertionTime"] = insertionTime.millisecondsSinceEpoch;
    map["generatedBy"] = generatedBy;
    map["comment"] = comment;
    map["initialState"] = initialState.toMap();
    map["currentState"] = currentState.toMap();

    return map;
  }
}
