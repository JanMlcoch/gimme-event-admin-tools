part of model;

class Tags{
  List<Tag> tags = [];

  void fromList(List tagsData){
    for(Map tagData in tagsData){
      tags.add(new Tag()..fromMap(tagData));
    }
  }

  List toList(){
    List tagsData = [];
    for(Tag tag in tags){
      tagsData.add(tag.toMap());
    }
    return tagsData;
  }
}

class Tag{
  int id;
  String name;

  void fromMap(Map tagData){
    id = tagData["id"];
    name = tagData["name"];
  }

  Map toMap(){
    Map tagData = {
      "id": id,
      "name": name
    };
    return tagData;
  }
}