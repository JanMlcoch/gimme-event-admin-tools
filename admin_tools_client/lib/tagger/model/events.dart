part of model;

class Events{
  List<Event> list = [];
  Event selected;
}

class Event {
  static int _idIterator = 1;
  int id;
  String name;
  DateTime dateFrom;
  String image;
  String place;
  String annotation;
  String sourceUrl;
  String description;
  List<Tag> tags = [];

  Event() {
    id = _idIterator++;
  }

  void fromMap(Map eventData) {
    name = eventData["name"];
    dateFrom = new DateTime.fromMillisecondsSinceEpoch(eventData["dateFrom"]);
    image = eventData["image"];
    place = eventData["place"];
    annotation = eventData["annotation"];
    sourceUrl = eventData["sourceUrl"];
    if (eventData.containsKey("description")) {
      description = eventData["description"];
    }
    if (eventData.containsKey("tags")) {
      tags.clear();
      for (Map tagData in eventData["tags"]) {
        tags.add(new Tag()..fromMap(tagData));
      }
    }
  }
}
