part of tagMaster2;

class Version{
  int id;
  DateTime insertionTime;
  int generatedBy;
  String comment;
  TagMasterRepository initialState;
  TagMasterRepository currentState;

  void fromMap(Map<String, dynamic> map){
    id = map["id"];
    insertionTime = new DateTime.fromMillisecondsSinceEpoch(map["insertionTime"]);
    generatedBy = map["generatedBy"];
    comment = map["comment"];
    initialState = new TagMasterRepository()..fromMap(map["initialState"]);
    currentState = new TagMasterRepository()..fromMap(map["currentState"]);
  }

  Map<String, dynamic> toMap(){
    Map<String,dynamic> map = {};

    map["id"] = id;
    map["insertionTime"] = insertionTime.millisecondsSinceEpoch;
    map["generatedBy"] = generatedBy;
    map["comment"] = comment;
    map["initialState"] = initialState.toMap();
    map["currentState"] = currentState.toMap();

    return map;
  }
}