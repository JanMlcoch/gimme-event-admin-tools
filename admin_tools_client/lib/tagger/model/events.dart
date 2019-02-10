part of model;

class GimmeEvents{
  List<GimmeEvent> events = [];

  Map toMap(){
    List<Map> eventsData = [];
    for(GimmeEvent event in events){
      eventsData.add(event.toMap());
    }
    return {"events": eventsData};
  }

  void saveEvents(){

  }
}

class GimmeEvent {
  static int _idIterator = 1;
  int id;
  String name;
  DateTime dateFrom;
  String image;
  String place;
  String annotation;
  String sourceUrl;
  String description;
  Tags tags;

  GimmeEvent() {
    id = _idIterator++;
  }

  void fromMap(Map eventData) {
    name = eventData["name"];
    if(eventData["dateForm"] is int){
      dateFrom = new DateTime.fromMillisecondsSinceEpoch(eventData["dateFrom"]);
    }else{
//      dateFrom = new DateTime(1975);
    }
    image = eventData["image"];
    place = eventData["place"];
    annotation = eventData["annotation"];
    sourceUrl = eventData["sourceUrl"];
    if (eventData.containsKey("description")) {
      description = eventData["description"];
    }
    if (eventData.containsKey("tags")) {
      tags = new Tags()..fromList(eventData["tags"]);
    }
  }

  Map toMap(){
    Map eventData = {};
    eventData["name"] = name;
    eventData["dateForm"] = dateFrom;
    eventData["image"] = image;
    eventData["annotation"] = annotation;
    eventData["description"] = description;
    eventData["tags"] = tags?.toList();
    return eventData;
  }
}
